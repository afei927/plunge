{-# LANGUAGE DeriveDataTypeable #-}
module Plunge.Options ( Options(..)
                      , defaultOpts
                      ) where

import Paths_plunge

import Data.Data
import Data.List
import Data.Version
import System.Console.CmdArgs

data Options = Options { inputFile    :: FilePath
                       , gccOptions   :: [String]
                       , linePadder   :: String
                       , emptyLine    :: String
                       , maxWidth     :: Maybe Int
                       -- , showLineNums :: Bool
                       -- , colorize     :: Bool
                       , verticalSep  :: String
                       , horizSep     :: String
                       } deriving (Show, Data, Typeable)

defaultOpts :: Options
defaultOpts = Options { inputFile = def      &= name "input-file"
                      , gccOptions = def     &= name "gcc-option"
                                             &= gccOptions_help
                      , linePadder = " "     &= name "line-padding"
                      , emptyLine = "."      &= name "empty-line-padding"
                      , maxWidth = Nothing   &= name "max-width"
                      -- , showLineNums = False &= name "show-line-numbers"
                      -- , colorize = False     &= name "colorize"
                      , verticalSep = " | "  &= name "vertical-sep"
                      , horizSep = "-"       &= name "horizontal-sep"
                      } &= program "plunge"
                        &= summary summary_str


summary_str :: String
summary_str = let tags = versionTags version
                  branch_str = concat $ intersperse "." $ map show (versionBranch version)
                  tags_str = case tags of
                                [] -> ""
                                _  -> " (" ++ (concat $ intersperse ", " $ tags) ++ ")"
            in "Plunge " ++ branch_str ++ tags_str ++ ", (C) John Van Enk 2012"

gccOptions_help :: Ann
gccOptions_help = help "An option to pass to GCC. Can be specified multiple times."