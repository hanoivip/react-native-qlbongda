local Skills = import("./skills/Skills")

local AIConfig = {}

AIConfig.WithBallSkillNames = {
    Skills.HeavyGunner.__cname,
    Skills.ThroughBall.__cname,
    Skills.OverHeadBall.__cname,
    Skills.CrossLowEx1.__cname,
    Skills.CrossLow.__cname,
    Skills.Diving.__cname,
    Skills.BreakThrough.__cname,
    Skills.Metronome.__cname,
}

AIConfig.NotEnterManualOperationSkills = {
    Skills.HeavyGunner,
    Skills.CalmShoot,
    Skills.BreakThrough,
    Skills.Metronome,
    Skills.HighSpeedDribble,
}

AIConfig.SkillType = {
    BreakThroughSkills = 1,
    NormalDribbleSkills = 2,
    ShootSkills = 3,
    PassSkills = 4,
    DribbleSkills = 5,
}

AIConfig.SkillsByType = {
    [AIConfig.SkillType.BreakThroughSkills] = {
        Skills.BreakThrough,
    },
    [AIConfig.SkillType.NormalDribbleSkills] = {
        Skills.BreakThrough,
        Skills.Diving,
        Skills.Metronome,
    },
    [AIConfig.SkillType.ShootSkills] = {
        Skills.CalmShoot,
        Skills.FoxInTheBox,
        Skills.VolleyShoot,
        Skills.PowerfulHeader,
        Skills.HeavyGunner,
    },
    [AIConfig.SkillType.PassSkills] = {
        Skills.ThroughBall,
        Skills.OverHeadBall,
        Skills.CrossLow,
        Skills.CorePlayMaker,
        Skills.LongPassDispatch,
    },
    [AIConfig.SkillType.DribbleSkills] = {
        Skills.BreakThrough,
        Skills.Metronome,
    },
}

AIConfig.positionNames = {
    FL = "FL",
    FC = "FC",
    FR = "FR",
    AMC = "AMC",
    ML = "ML",
    MC = "MC",
    MR = "MR",
    DMC = "DMC",
    DL = "DL",
    DR = "DR",
    DC = "DC",
    GK = "GK",
}

AIConfig.posIndex = {
    [1] = AIConfig.positionNames.FL,
    [2] = AIConfig.positionNames.FC,
    [3] = AIConfig.positionNames.FC,
    [4] = AIConfig.positionNames.FC,
    [5] = AIConfig.positionNames.FR,
    [6] = AIConfig.positionNames.FL,
    [7] = AIConfig.positionNames.AMC,
    [8] = AIConfig.positionNames.AMC,
    [9] = AIConfig.positionNames.AMC,
    [10] = AIConfig.positionNames.FR,
    [11] = AIConfig.positionNames.ML,
    [12] = AIConfig.positionNames.MC,
    [13] = AIConfig.positionNames.MC,
    [14] = AIConfig.positionNames.MC,
    [15] = AIConfig.positionNames.MR,
    [16] = AIConfig.positionNames.DL,
    [17] = AIConfig.positionNames.DMC,
    [18] = AIConfig.positionNames.DMC,
    [19] = AIConfig.positionNames.DMC,
    [20] = AIConfig.positionNames.DR,
    [21] = AIConfig.positionNames.DL,
    [22] = AIConfig.positionNames.DC,
    [23] = AIConfig.positionNames.DC,
    [24] = AIConfig.positionNames.DC,
    [25] = AIConfig.positionNames.DR,
    [26] = AIConfig.positionNames.GK,
}
return AIConfig
