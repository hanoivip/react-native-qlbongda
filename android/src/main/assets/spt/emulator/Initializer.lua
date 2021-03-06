﻿--[[goalkeeping = 1830,--门线技术
anticipation = 1,--球路判断
commanding = 1,--防线指挥
composure = 1,--心理素质
launching = 1,--发起进攻]]

return {
    baseInfo = {
        grassTech = "Common",
        grassTechLvl = 0,
        home = 1,
        kickoffTime = "20:00",
        matchTime = 2,
        matchType = "quest",
        pitchPattern = 2,
        randSeed = 689524686,
        spectatorsType = 1,
        tips = "プロリーグの試合に出場した選手は１試合毎に無料潜在能力育成回数が＋１されます！",
        weather = "SummerNight",
        weatherTech = "SunShine",
        weatherTechLvl = 0,
        allowManualOperation = 1,
        questConditions = {
            {
                isStageClearCondition = false,
                type = 3,
                text = "完成3个净胜球",
                result = false,
                count = 0,
                targetCount = 3,
            },
            {
                isStageClearCondition = false,
                type = 6,
                text = "失2球以内",
                result = true,
                count = 0,
                targetCount = 2,
            },
            {
                isStageClearCondition = false,
                type = 14,
                text = "禁区之狐打进2次",
                result = false,
                count = 0,
                targetCount = 2,
            },
            {
                isStageClearCondition = false,
                type = 25,
                text = "接过顶凌空抽射进球1次",
                result = false,
                count = 0,
                passSkillId = "C02",
                shootSkillId = "D04",
                targetCount = 1,
            },
            {
                isStageClearCondition = false,
                type = 23,
                text = "直接和间接任意球至少打进2球",
                result = false,
                count = 0,
                targetCount = 2,
            },
            {
                isStageClearCondition = false,
                type = 8,
                goalWayType = 4,
                text = "接角球至少打进1球",
                result = false,
                count = 0,
                targetCount = 1,
            },
        },
    },
    opponent = {
        athletes = {
            {
                abilities = {
                    dribble = 2133,
                    intercept = 6312,
                    pass = 1667,
                    goalkeeping = 1830,
                    shoot = 7182,
                    steal = 5744,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    2,
                    3,
                    4,
                },
                role = 4,
                skills = {
                    D05 = 6,
                    F02_1 = 6,
                    F03_1 = 6,
                    F05 = 6,
                    F06 = 6,
                    D01_1 = 6,
                    D06 = 6,
                    D07 = 6,
                    A03 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    G01 = 6,
                },
            },
            {
                abilities = {
                    dribble = 1017,
                    intercept = 3993,
                    pass = 8742,
                    goalkeeping = 1701,
                    shoot = 1712,
                    steal = 1604,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    12,
                    13,
                    14,
                    17,
                    18,
                    19,
                    22,
                    23,
                    24,
                },
                role = 14,
                skills = {
                    G01 = 6,
                    B01_1 = 6,
                    F01 = 6,
                    C04_1 = 6,
                    C01 = 6,
                    C02 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 1619,
                    intercept = 2809,
                    pass = 2319,
                    goalkeeping = 2782,
                    shoot = 1154,
                    steal = 8866,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    11,
                    15,
                    12,
                    13,
                    14,
                    16,
                    21,
                    20,
                    25,
                    22,
                    23,
                    24,
                    17,
                    18,
                    19,
                    2,
                    3,
                    4,
                },
                role = 21,
                skills = {
                    A07 = 6,
                    C03 = 6,
                    F06 = 6,
                    A06 = 6,
                    A04 = 6,
                    A08 = 6,
                    A01 = 6,
                    A02_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 924,
                    intercept = 2669,
                    pass = 8984,
                    goalkeeping = 1804,
                    shoot = 8761,
                    steal = 20771,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    20,
                    25,
                    22,
                    23,
                    24,
                    5,
                    10,
                    2,
                    3,
                    4,
                },
                role = 24,
                skills = {
                    A07 = 6,
                    F06 = 6,
                    A06 = 6,
                    A05 = 6,
                    A04 = 6,
                    A01 = 6,
                    A02_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 5254,
                    intercept = 6229,
                    pass = 4642,
                    goalkeeping = 3059,
                    shoot = 2939,
                    steal = 6229,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    2,
                    3,
                    4,
                    5,
                    10,
                    7,
                    8,
                    9,
                    12,
                    13,
                    14,
                    15,
                },
                role = 15,
                skills = {
                    G01 = 6,
                    B01_1 = 6,
                    C04_1 = 6,
                    C01 = 6,
                    C02 = 6,
                    C03 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 4532,
                    intercept = 5979,
                    pass = 6429,
                    goalkeeping = 1638,
                    shoot = 5786,
                    steal = 1704,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    22,
                    23,
                    24,
                },
                role = 22,
                skills = {
                    A07 = 6,
                    F06 = 6,
                    A04 = 6,
                    A08 = 6,
                    A01 = 6,
                    A02_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 3275,
                    intercept = 2408,
                    pass = 19700,
                    goalkeeping = 1602,
                    shoot = 2277,
                    steal = 2731,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    1,
                    6,
                    5,
                    10,
                    11,
                    15,
                    7,
                    8,
                    9,
                    2,
                    3,
                    4,
                },
                role = 11,
                skills = {
                    G01 = 6,
                    B01_1 = 6,
                    C04_1 = 6,
                    C02 = 6,
                    C03 = 6,
                    F06 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 8203,
                    intercept = 2210,
                    pass = 8531,
                    goalkeeping = 1564,
                    shoot = 1234,
                    steal = 2965,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    17,
                    18,
                    19,
                    12,
                    13,
                    14,
                },
                role = 12,
                skills = {
                    G01 = 6,
                    B01_1 = 6,
                    C04_1 = 6,
                    C01 = 6,
                    D07 = 6,
                    G02 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 9391,
                    intercept = 6266,
                    pass = 2269,
                    goalkeeping = 1774,
                    shoot = 6438,
                    steal = 6266,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    2,
                    3,
                    4,
                },
                role = 2,
                skills = {
                    D05 = 6,
                    F04_1 = 6,
                    F06_1 = 6,
                    D01_1 = 6,
                    D02 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    G01 = 6,
                },
            },
            {
                abilities = {
                    dribble = 11359,
                    intercept = 3062,
                    pass = 9100,
                    goalkeeping = 2000,
                    shoot = 3062,
                    steal = 3062,
                    anticipation = 2000,
                    commanding = 2000,
                    composure = 20000,
                    launching = 2000,
                },
                adeptRole = {
                    26,
                },
                role = 26,
                skills = {
                    E09 = 6,
                    E10 = 6,
                    E02_1 = 6,
                    E03_1 = 6,
                    E05 = 6,
                },
            },
            {
                abilities = {
                    dribble = 1175,
                    intercept = 1858,
                    pass = 8773,
                    goalkeeping = 1716,
                    shoot = 1716,
                    steal = 3677,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    20,
                    25,
                },
                role = 25,
                skills = {
                    A07 = 6,
                    C03 = 6,
                    F06 = 6,
                    A04 = 6,
                    A08 = 6,
                    A01 = 6,
                    A02_1 = 6,
                },
            },
        },
        captain = 24,
        freeKickShooter = 4,
        freeKickPasser = 4,
        field = "south",
        formation = 10,
        cornerKicker = 2,
        name = "opponent",
        penaltyKicker = 4,
        power = 883120,
        role = "Defend",
        tactics = {
            attackEmphasis = 3,
            attackMentality = 3,
            defenseMentality = 3,
            passTactic = 3,
            attackRhythm = 3,
            sideTactic = {
                left = 0,
                right = 0,
            },
            sideGuardTactic = {
                left = 0,
                right = 0,
            }
        },
    },
    ops = {
    },
    player = {
        athletes = {
            {
                abilities = {
                    dribble = 21303,
                    intercept = 6312,
                    pass = 16676,
                    goalkeeping = 1830,
                    shoot = 71582,
                    steal = 5744,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    2,
                    3,
                    4,
                },
                role = 4,
                skills = {
                    D05_1 = 6,
                    F02 = 6,
                    F03 = 6,
                    F05 = 6,
                    F06 = 6,
                    D01_1 = 6,
                    D02 = 60,
                    D03 = 60,
                    D04 = 60,
                    D06_1 = 60,
                    D07 = 6,
                    A03 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    G01_1 = 6,
                    Z07_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 10170,
                    intercept = 39393,
                    pass = 8742,
                    goalkeeping = 1701,
                    shoot = 1712,
                    steal = 16404,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    12,
                    13,
                    14,
                    17,
                    18,
                    19,
                    22,
                    23,
                    24,
                },
                role = 14,
                skills = {
                    G01_1 = 6,
                    D02_1 = 60,
                    B01_1 = 6,
                    F01_1 = 6,
                    C04_1 = 6,
                    C01 = 6,
                    C02 = 6,
                    D03 = 60,
                    F06 = 6,
                    D07 = 6,
                    G03_1 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                    Z07_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 16199,
                    intercept = 28509,
                    pass = 23149,
                    goalkeeping = 2782,
                    shoot = 11574,
                    steal = 58866,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    11,
                    15,
                    12,
                    13,
                    14,
                    16,
                    21,
                    20,
                    25,
                    22,
                    23,
                    24,
                    17,
                    18,
                    19,
                    2,
                    3,
                    4,
                },
                role = 21,
                skills = {
                    A07_1 = 6,
                    C03_1 = 6,
                    F06 = 6,
                    A06 = 6,
                    A05 = 6,
                    A04 = 6,
                    A08 = 6,
                    A01 = 6,
                    D03 = 60,
                    A02_1 = 6,
                    Z07_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 9246,
                    intercept = 24669,
                    pass = 8984,
                    goalkeeping = 1804,
                    shoot = 8761,
                    steal = 20771,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    20,
                    25,
                    22,
                    23,
                    24,
                    5,
                    10,
                    2,
                    3,
                    4,
                },
                role = 24,
                skills = {
                    A07_1 = 6,
                    F06 = 6,
                    A06 = 6,
                    A05 = 6,
                    A04 = 6,
                    D03 = 60,
                    A08 = 6,
                    A01 = 6,
                    A02_1 = 6,
                    Z07_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 52354,
                    intercept = 6229,
                    pass = 46482,
                    goalkeeping = 3059,
                    shoot = 22939,
                    steal = 6229,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    2,
                    3,
                    4,
                    5,
                    10,
                    7,
                    8,
                    9,
                    12,
                    13,
                    14,
                    15,
                },
                role = 15,
                skills = {
                    G01_1 = 6,
                    B01_1 = 6,
                    C04_1 = 6,
                    D02_1 = 60,
                    C01 = 6,
                    C02 = 6,
                    C03_1 = 6,
                    F06 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                    D03 = 60,
                    C05 = 6,
                },
            },
            {
                abilities = {
                    dribble = 4532,
                    intercept = 59979,
                    pass = 6429,
                    goalkeeping = 1638,
                    shoot = 5786,
                    steal = 17304,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    22,
                    23,
                    24,
                },
                role = 22,
                skills = {
                    A07_1 = 6,
                    F06 = 6,
                    A06 = 6,
                    D02_1 = 60,
                    A05 = 6,
                    A04 = 6,
                    D03 = 60,
                    A08 = 6,
                    A01 = 6,
                    A02_1 = 6,
                    C05 = 6,
                },
            },
            {
                abilities = {
                    dribble = 32775,
                    intercept = 2408,
                    pass = 19700,
                    goalkeeping = 1602,
                    shoot = 22747,
                    steal = 2731,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    1,
                    6,
                    5,
                    10,
                    11,
                    15,
                    7,
                    8,
                    9,
                    2,
                    3,
                    4,
                },
                role = 11,
                skills = {
                    G01_1 = 6,
                    B01_1 = 6,
                    C04_1 = 6,
                    C01 = 6,
                    C02 = 6,
                    D02_1 = 60,
                    C03_1 = 6,
                    C05 = 6,
                    D03 = 60,
                    F06 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 8203,
                    intercept = 22810,
                    pass = 8531,
                    goalkeeping = 1564,
                    shoot = 1234,
                    steal = 29625,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    17,
                    18,
                    19,
                    12,
                    13,
                    14,
                },
                role = 12,
                skills = {
                    G01_1 = 6,
                    B01_1 = 6,
                    C04_1 = 6,
                    D03 = 60,
                    C01 = 6,
                    C02 = 6,
                    F06 = 6,
                    D07 = 6,
                    G02_1 = 6,
                    D02_1 = 60,
                    B01_1 = 6,
                    B02 = 6,
                    B03_1 = 6,
                    Z26_1 = 6,
                    C05 = 6,
                },
            },
            {
                abilities = {
                    dribble = 9391,
                    intercept = 6266,
                    pass = 22609,
                    goalkeeping = 1774,
                    shoot = 64398,
                    steal = 6266,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    2,
                    3,
                    4,
                },
                role = 2,
                skills = {
                    D05_1 = 6,
                    F04 = 6,
                    F06 = 6,
                    D01_1 = 6,
                    D03 = 60,
                    D02_1 = 60,
                    D04 = 6,
                    D06_1 = 6,
                    D07 = 6,
                    A03 = 6,
                    B01_1 = 6,
                    B02 = 6,
                    G01 = 6,
                    Z26_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 11359,
                    intercept = 3062,
                    pass = 9100,
                    goalkeeping = 20000,
                    shoot = 3062,
                    steal = 3062,
                    anticipation = 20000,
                    commanding = 20000,
                    composure = 20000,
                    launching = 20000,
                },
                adeptRole = {
                    26,
                },
                role = 26,
                skills = {
                    E09 = 6,
                    E10 = 6,
                    E04 = 6,
                    E06_1 = 6,
                    E07_1 = 6,
                    E08_1 = 6,
                    E01 = 6,
                    E02_1 = 6,
                    E03_1 = 6,
                    E05 = 6,
                    Z26_1 = 6,
                },
            },
            {
                abilities = {
                    dribble = 11752,
                    intercept = 18158,
                    pass = 8773,
                    goalkeeping = 1716,
                    shoot = 1716,
                    steal = 36777,
                    anticipation = 1,
                    commanding = 1,
                    composure = 1,
                    launching = 1,
                },
                adeptRole = {
                    20,
                    25,
                },
                role = 25,
                skills = {
                    A07_1 = 6,
                    C03_1 = 6,
                    F06 = 6,
                    D02_1 = 60,
                    D03 = 60,
                    A06 = 6,
                    A05 = 6,
                    A04 = 6,
                    A08 = 6,
                    A01 = 6,
                    A02_1 = 6,
                    Z26_1 = 6,
                },
            },
        },
        captain = 14,
        freeKickShooter = 4,
        freeKickPasser = 4,
        field = "north",
        formation = 10,
        cornerKicker = 2,
        name = "player",
        penaltyKicker = 4,
        power = 883120,
        role = "Attack",
        tactics = {
            attackEmphasis = 3,
            attackMentality = 3,
            defenseMentality = 3,
            passTactic = 3,
            attackRhythm = 3,
            sideTactic = {
                left = 0,
                right = 0,
            },
            sideGuardTactic = {
                left = 0,
                right = 0,
            }
        },
    },
}