CREATE TABLE cdm_observable_asset.CreditRatingDebt (
    CreditRatingDebt_id INT UNIQUE NOT NULL,
    debtType VARCHAR(255) %DESCRIPTION 'Specifies when there is only one debt type. FpML doesn''t specify values in relation to the associated scheme, which is hence not specified as an enumeration as part of the CDM.',
    debtTypes VARCHAR(255) %DESCRIPTION 'Specifies if there are several debt types, alongside an ''any'' or ''all'' or all condition. As an example, Baa1 rating is required for any long term debt and deposit.'
);

CREATE TABLE cdm_product_asset.PriceReturnTerms (
    PriceReturnTerms_id INT UNIQUE NOT NULL,
    valuationPriceInitial VARCHAR(255) %DESCRIPTION 'Specifies the initial valuation price(s) of the underlier. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    valuationPriceFinal VARCHAR(255) %DESCRIPTION '2018 ISDA CDM Equity Confirmation for Security Equity Swap: Final Price | Specifies the final valuation price of the underlier. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    returnType VARCHAR(255) NOT NULL %DESCRIPTION 'The type of return associated with the equity swap.',
    conversionFactor FLOAT %DESCRIPTION 'Defines the conversion applied if the quantity unit on contract is different from unit on referenced underlier.',
    performance VARCHAR(255) %DESCRIPTION 'Performance calculation, in accordance with Part 1 Section 12 of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap, Para 75. ''Equity Performance''. Cumulative performance is used as a notional multiplier factor on both legs of an Equity Swap.'
);

CREATE TABLE cdm_event_common.ValuationSourceEnum (
    ValuationSourceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_workflow.Velocity (
    Velocity_id INT UNIQUE NOT NULL,
    periodMultiplier INT,
    period VARCHAR(255)
);

CREATE TABLE cdm_product_template.Asian (
    Asian_id INT UNIQUE NOT NULL,
    averagingInOut VARCHAR(255) NOT NULL,
    strikeFactor FLOAT %DESCRIPTION 'The factor of strike.',
    averagingPeriodIn VARCHAR(255) %DESCRIPTION 'The averaging in period.',
    averagingPeriodOut VARCHAR(255) %DESCRIPTION 'The averaging out period.'
);

CREATE TABLE cdm_base_staticdata_asset_common.AssetPool (
    AssetPool_id INT UNIQUE NOT NULL,
    version VARCHAR(255) %DESCRIPTION 'The asset pool version.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'Optionally it is possible to specify a version effective date when a version is supplied.',
    initialFactor FLOAT NOT NULL %DESCRIPTION 'The part of the mortgage that is outstanding on trade inception, i.e. has not been repaid yet as principal. It is expressed as a multiplier factor to the mortgage: 1 means that the whole mortgage amount is outstanding, 0.8 means that 20% has been repaid.',
    currentFactor FLOAT %DESCRIPTION 'The part of the mortgage that is currently outstanding. It is expressed similarly to the initial factor, as factor multiplier to the mortgage. This term is formally defined as part of the ''ISDA Standard Terms Supplement for use with credit derivatives transactions on mortgage-backed security with pas-as-you-go or physical settlement''.'
);

CREATE TABLE cdm_observable_asset.OptionReferenceTypeEnum (
    OptionReferenceTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.DebtInterestEnum (
    DebtInterestEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_workflow.FieldWithMetaLimitLevelEnum (
    FieldWithMetaLimitLevelEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_event_workflow_metafields.ReferenceWithMetaWorkflowStep (
    ReferenceWithMetaWorkflowStep_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_math.NumberRange (
    NumberRange_id INT UNIQUE NOT NULL,
    lowerBound VARCHAR(255) %DESCRIPTION 'The lower bound of a number range, e.g. greater than or equal to 5.',
    upperBound VARCHAR(255) %DESCRIPTION 'The upper bound of a number range, e.g. less than 10.'
);

CREATE TABLE cdm_legaldocumentation_common.LengthUnitEnum (
    LengthUnitEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_schedule.FxLinkedNotionalAmount (
    FxLinkedNotionalAmount_id INT UNIQUE NOT NULL,
    resetDate VARCHAR(255) %DESCRIPTION 'The reset date.',
    adjustedFxSpotFixingDate VARCHAR(255) %DESCRIPTION 'The date on which the FX spot rate is observed. This date should already be adjusted for any applicable business day convention.',
    observedFxSpotRate FLOAT %DESCRIPTION 'The actual observed FX spot rate.',
    notionalAmount FLOAT %DESCRIPTION 'The calculation period notional amount.'
);

CREATE TABLE cdm_product_collateral.ListingType (
    ListingType_id INT UNIQUE NOT NULL,
    exchange VARCHAR(255) %DESCRIPTION 'Represents a filter based on the Primary Stock Exchange facilitating the listing of companies, exchange of Stocks, Exchange traded Derivatives, Bonds, and other Securities expressed in ISO standard 10383.',
    sector VARCHAR(255) %DESCRIPTION 'Represents a filter based on an industry sector defined under a system for classifying industry types such as Global Industry Classification Standard (GICS) and North American Industry Classification System (NAICS)',
    index VARCHAR(255) %DESCRIPTION 'Represents a filter based on an index that measures a stock market, or a subset of a stock market.'
);

CREATE TABLE cdm_regulation.RefRate (
    RefRate_id INT UNIQUE NOT NULL,
    indx VARCHAR(255) NOT NULL,
    nm VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_asset.VolatilityCapFloor (
    VolatilityCapFloor_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the volatility cap is applicable in accordance with the ISDA 2011 Equity Derivatives Definitions. Setting the element ''applicable'' to ''False'' - means No Volatility Cap and no ''totalVolatilityCap'' or ''volatilityCapFactor'' should be provided. Setting the element ''applicable'' to ''True'' - means Volatility Cap election, then ''totalVolatilityCap'' or ''volatilityCapFactor'' should be provided, otherwise it defaults to volatilityCapFactor=2.5.',
    totalVolatilityCap FLOAT %DESCRIPTION 'Volatility Cap Amount in accordance with the ISDA 2011 Equity Derivatives Definitions. This means the Volatility Cap Amount election is a number.',
    volatilityCapFactor FLOAT %DESCRIPTION 'Volatility Cap Amount in accordance with the ISDA 2011 Equity Derivatives Definitions. The Calculated VolCapAmt can be optionally provided.'
);

CREATE TABLE cdm_product_asset.FixedAmountCalculationDetails (
    FixedAmountCalculationDetails_id INT UNIQUE NOT NULL,
    calculationPeriod VARCHAR(255) NOT NULL %DESCRIPTION 'The calculation period for which the floating calculation was performed.',
    calculationPeriodNotionalAmount VARCHAR(255) NOT NULL %DESCRIPTION 'The notional in effect during the calculation period.',
    fixedRate FLOAT NOT NULL %DESCRIPTION 'The value of the fixed rate that was used.',
    yearFraction FLOAT NOT NULL %DESCRIPTION 'The fraction of a year that this calculation represents, according to the day count fraction method.',
    calculatedAmount FLOAT NOT NULL %DESCRIPTION 'The amount of the cash flow that was computed, including any spreads and other processing.'
);

CREATE TABLE cdm_base_staticdata_party.BuyerSeller (
    BuyerSeller_id INT UNIQUE NOT NULL,
    buyer VARCHAR(255) NOT NULL %DESCRIPTION 'Buyer party that can be resolved as one of the two principal parties to the transaction. The party that buys this instrument, i.e. pays for this instrument and receives the rights defined by it. ISDA 2002 Equity Definitions section 1.18: `Buyer` means the party specified as such in the related Confirmation. | ISDA 2006 Definitions article 12.1 (b)(i) relating to a Swaption: ''Buyer'' means the party that will, on each Premium Payment Date, pay to Seller the Premium | ISDA 2006 Definitions article 12.1 (b)(ii) relating to Swap Transactions with applicable Early Termination: the party specified as such in the related Confirmation, or the Exercising Party if neither party is specified | ISDA 2006 Definitions article 12.1 (b)(iii) relating to any other Option Transaction: the party specified as such in the related Confirmation. | ISDA 2014 Credit Definition article 1.4: `Buyer` means the Fixed Rate Payer.',
    seller VARCHAR(255) NOT NULL %DESCRIPTION 'Seller party that can be resolved as one of the two principal parties to the transaction. The party that sells (''writes'') this instrument, i.e. that grants the rights defined by this instrument and in return receives a payment for it. ISDA 2002 Equity Definitions section 1.19: `Seller` means the party specified as such in the related Confirmation. | ISDA 2006 Definitions article 12.1 (a)(i) relating to a Swaption: ''Seller'' means the party the party specified as such or as writer in the related Confirmation | ISDA 2006 Definitions article 12.1 (a)(ii) relating to Swap Transactions with applicable Early Termination: the party specified as such or as writer in the related Confirmation or, if neither party is specified as such, the Non-exercising Party | ISDA 2006 Definitions article 12.1 (a)(iii) relating to any other Option Transaction: the party specified as such in the related Confirmation. | ISDA 2014 Credit Definition article 1.4: `Seller` means the Floating Rate Payer.'
);

CREATE TABLE cdm_product_asset.SettledEntityMatrix (
    SettledEntityMatrix_id INT UNIQUE NOT NULL,
    matrixSource VARCHAR(255) NOT NULL %DESCRIPTION 'Relevant settled entity matrix source.',
    publicationDate VARCHAR(255) %DESCRIPTION 'Specifies the publication date of the applicable version of the matrix. When this element is omitted, the Standard Terms Supplement defines rules for which version of the matrix is applicable.'
);

CREATE TABLE cdm_observable_asset.PriceExpressionEnum (
    PriceExpressionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.MarginCallExposure_party (
    MarginCallExposure_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallExposure_partyRole (
    MarginCallExposure_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallExposure (
    MarginCallExposure_id INT UNIQUE NOT NULL,
    overallExposure VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the whole overall mark to market value or IM calculation value of the trade portfolio as recorded by the principle (in base currency).',
    simmIMExposure VARCHAR(255) %DESCRIPTION 'Represents Initial Margin (IM) exposure derived from ISDA SIMM calculation.',
    scheduleGridIMExposure VARCHAR(255) %DESCRIPTION 'Represents Initial Margin (IM) exposure derived from schedule or Grid calculation.',
    instructionType VARCHAR(255) %DESCRIPTION 'Identifies the enumeration values to specify the call notification type, direction, specific action type.',
    party INT NOT NULL %DESCRIPTION 'Represents the parties to the margin call. The cardinality is optional to address the case where both parties of the event are specified and a third party if applicable.',
    partyRole INT NOT NULL %DESCRIPTION 'Represents the role each specified party takes in the margin call. further to the principal roles, payer and receiver.',
    clearingBroker VARCHAR(255) %DESCRIPTION 'Indicates the name of the Clearing Broker FCM/DCM.',
    callIdentifier VARCHAR(255) %DESCRIPTION 'Represents a unique Identifier for a margin call message, that can be referenced throughout all points of the process.',
    callAgreementType VARCHAR(255) %DESCRIPTION 'Specifies the legal agreement type the margin call is generated from and governed by.',
    agreementMinimumTransferAmount VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement minimum transfer amount in base currency.',
    agreementThreshold VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement threshold amount in base currency.',
    agreementRounding VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement rounding in base currency.',
    regMarginType VARCHAR(255) %DESCRIPTION 'Identifies margin type and if related regulatory mandate',
    regIMRole VARCHAR(255) %DESCRIPTION 'Indicates the role of the party in an regulatory initial margin call instruction (i.e Pledgor party or Secured party).',
    baseCurrencyExposure VARCHAR(255) %DESCRIPTION 'Represents the current mark to market value or IM calculation value of the trade portfolio as recorded by the principle (in base currency), to be referenced in a margin call.',
    collateralPortfolio VARCHAR(255) %DESCRIPTION 'Represents attributes to define the details of collateral assets within a collateral portfolio to be used in margin call messaging and contribute to collateral balances e.g securities in a collateral account recorded by the principal as held or posted.',
    independentAmountBalance VARCHAR(255) %DESCRIPTION 'Represents additional credit support amount over and above mark to market value.'
);

CREATE TABLE cdm_product_asset.NonCashDividendTreatmentEnum (
    NonCashDividendTreatmentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.CreditNotations (
    CreditNotations_id INT UNIQUE NOT NULL,
    creditNotation VARCHAR(255) %DESCRIPTION 'Specifies only one credit notation is determined.',
    creditNotations VARCHAR(255) %DESCRIPTION 'Specifies if several credit notations exist, alongside an ''any'' or ''all'' or all condition.'
);

CREATE TABLE cdm_product_common_settlement.QuantityMultiplier (
    QuantityMultiplier_id INT UNIQUE NOT NULL,
    fxLinkedNotionalSchedule VARCHAR(255) %DESCRIPTION 'Multiplier specified as an FX-linked schedule, e.g. for a resetting cross-currency swap..',
    multiplierValue FLOAT
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateDetails_weightedRates (
    CalculatedRateDetails_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateDetails_growthFactor (
    CalculatedRateDetails_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateDetails_compoundedGrowth (
    CalculatedRateDetails_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateDetails (
    CalculatedRateDetails_id INT UNIQUE NOT NULL,
    observations VARCHAR(255) %DESCRIPTION 'The observation dates and weights for each observation date.',
    weightedRates INT NOT NULL %DESCRIPTION 'The weighted value of each observation.',
    growthFactor INT NOT NULL %DESCRIPTION 'The daily growth factors, showing the weighted rates divided by the day count basis plus one, giving how much the value grows for each step in the calculation.',
    compoundedGrowth INT NOT NULL %DESCRIPTION 'The compounding curve, showing how the initial value grew during the calculation period.',
    aggregateValue FLOAT %DESCRIPTION 'The total sum or product of all the individual terms that went into the calculated rate.',
    aggregateWeight FLOAT %DESCRIPTION 'The total weight of all the terms that went into the calculated rate.',
    calculatedRate FLOAT %DESCRIPTION 'The resulting calculated weight.'
);

CREATE TABLE cdm_base_staticdata_asset_common.Taxonomy (
    Taxonomy_id INT UNIQUE NOT NULL,
    source VARCHAR(255) %DESCRIPTION 'The source of the taxonomy that defines the rules for classifying the object. The taxonomy source is taken from a enumerated list of taxonomy names. Optional as the taxonomy source may not be provided.',
    value VARCHAR(255) %DESCRIPTION 'The value according to that taxonomy. Optional as it may not be possible to classify the object in that taxonomy.'
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralIssuerType (
    CollateralIssuerType_id INT UNIQUE NOT NULL,
    issuerType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the origin of entity issuing the collateral.',
    supraNationalType VARCHAR(255) %DESCRIPTION 'Specifies debt issued by international organisations and multilateral banks.',
    quasiGovernmentType VARCHAR(255) %DESCRIPTION 'Specifies debt issues by institutions or bodies, typically constituted by statute, with a function mandated by the government and subject to government supervision inclusive of profit- and non-profit making bodies. Includes the US Agencies and GSEs and the EU concept of public sector entities. Excluding any entities which are also Regional Government.',
    regionalGovernmentType VARCHAR(255) %DESCRIPTION 'Specifies Regional government, local authority or municipal.',
    specialPurposeVehicleType VARCHAR(255) %DESCRIPTION 'Specifies a subsidiary company that is formed to undertake a specific business purpose of acquisition and financing of specific assets on a potentially limited recourse basis dependent of how it is designed. E.g. asset backed securities, including securitisations.'
);

CREATE TABLE cdm_product_template_metafields.ReferenceWithMetaOptionPayout (
    ReferenceWithMetaOptionPayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.PartyDeterminationEnum (
    PartyDeterminationEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_workflow.EventTimestampQualificationEnum (
    EventTimestampQualificationEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_workflow.Workflow_steps (
    Workflow_id INT NOT NULL,
    WorkflowStep_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.Workflow (
    Workflow_id INT UNIQUE NOT NULL,
    steps INT NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.EntityTypeEnum (
    EntityTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.CreditSupportProviderTermsEnum (
    CreditSupportProviderTermsEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.InitialMarginCalculation_marginRatioThreshold (
    InitialMarginCalculation_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.InitialMarginCalculation_haircutThreshold (
    InitialMarginCalculation_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.InitialMarginCalculation (
    InitialMarginCalculation_id INT UNIQUE NOT NULL,
    marginRatio FLOAT %DESCRIPTION 'An element defining an initial margin expressed as a ratio of the Market Value of the collateral to the Purchase Price. A default value of initial margin ratio of 1.00 means there is no margin and thus no risk related with the collateral. See GMRA 2000 paragraph 2(z) and GMRA 2011 paragraph 2(bb).',
    marginRatioThreshold INT NOT NULL %DESCRIPTION 'An element defining a margin ratio threshold which is the value above (when it''s lower than initial margin ratio) or below (when it''s higher than initial margin ratio) which parties agree they will not call a margin from each other.',
    haircut FLOAT %DESCRIPTION 'An element defining a haircut expressed as the percentage difference between the Market Value of the collateral and the Purchase Price of the repo and calculated as 100 multiplied by a ratio of the difference between the Market Value of the collateral and the Purchase Price of the repo to the Market Value of the collateral. Haircut is alternative way to adjust the value of collateral sold in a repurchase agreement to initial margin ratio. Because an initial margin is a percentage of the Purchase Price, while a haircut is a percentage of the Market Value of collateral, the arithmetic of initial margins and haircuts is slightly different. For example, an initial margin of 102% is not equivalent to a haircut of 2%, but to 1.961% (ie 100/102%). See GMRA 2011 paragraph 2(aa).',
    haircutThreshold INT NOT NULL %DESCRIPTION 'An element defining a haircut percentage threshold which is the value above (when it''s lower than initial haircut) or below (when it''s higher than initial haircut) which parties agree they will not call a margin from each other.'
);

CREATE TABLE cdm_product_common_schedule.ParametricDates_dayOfWeek (
    ParametricDates_id INT NOT NULL,
    DayOfWeekEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.ParametricDates (
    ParametricDates_id INT UNIQUE NOT NULL,
    dayType VARCHAR(255) NOT NULL %DESCRIPTION 'Denotes the enumerated values to specify the day type classification used in counting the number of days between two dates.',
    dayDistribution VARCHAR(255) %DESCRIPTION 'Denotes the method by which the pricing days are distributed across the pricing period.',
    dayOfWeek INT NOT NULL %DESCRIPTION 'Indicates the days of the week on which the price will be determined.',
    dayFrequency FLOAT %DESCRIPTION 'Defines the occurrence of the dayOfWeek within the pricing period on which pricing will take place, e.g. the 3rd Friday within each Calculation Period. If omitted, every dayOfWeek will be a pricing day.',
    lag VARCHAR(255) %DESCRIPTION 'The pricing period per calculation period if the pricing days do not wholly fall within the respective calculation period.',
    businessCenters VARCHAR(255) NOT NULL %DESCRIPTION 'The enumerated values to specify the business centers.'
);

CREATE TABLE cdm_legaldocumentation_master.FieldWithMetaMasterConfirmationTypeEnum (
    FieldWithMetaMasterConfirmationTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_common_settlement.StandardSettlementStyleEnum (
    StandardSettlementStyleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.OptionTypeEnum (
    OptionTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.LegalAgreementIdentification (
    LegalAgreementIdentification_id INT UNIQUE NOT NULL,
    governingLaw VARCHAR(255) %DESCRIPTION 'The law governing the legal agreement, e.g. English Law, New York Law or Japanese Law.',
    agreementName VARCHAR(255) NOT NULL %DESCRIPTION 'The legal agreement name, e.g. Credit Support Annex for Variation Margin.',
    publisher VARCHAR(255) %DESCRIPTION 'The legal agreement publisher, e.g. ISDA.',
    vintage INT %DESCRIPTION 'In the case where successive definitions of the legal agreement have been developed, the vintage identification. This is typically (but not necessarily) done by referencing the year, e.g. 2013 in the case of the ISDA 2013 Standard Credit Support Annex.'
);

CREATE TABLE cdm_product_collateral.CollateralAgreementFloatingRate (
    CollateralAgreementFloatingRate_id INT UNIQUE NOT NULL,
    negativeInterest INT NOT NULL %DESCRIPTION 'Specifies how negative rates should be applied.  If rates go negative, should the payment be reversed (true) or zeroed out (false)?',
    compressibleSpread INT NOT NULL %DESCRIPTION 'Specifies how spreads should be applied in a low/negative rate environment.  If true, spread is applied only if rate is positive.',
    rateOption VARCHAR(255),
    spreadSchedule VARCHAR(255) %DESCRIPTION 'The ISDA Spread or a Spread schedule expressed as explicit spreads and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    capRateSchedule VARCHAR(255) %DESCRIPTION 'The cap rate or cap rate schedule, if any, which applies to the floating rate. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain level. A cap rate schedule is expressed as explicit cap rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRateSchedule VARCHAR(255) %DESCRIPTION 'The floor rate or floor rate schedule, if any, which applies to the floating rate. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. A floor rate schedule is expressed as explicit floor rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_observable_asset.PriceTypeEnum (
    PriceTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.GeneralTerms_additionalTerm (
    GeneralTerms_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.GeneralTerms (
    GeneralTerms_id INT UNIQUE NOT NULL,
    referenceInformation VARCHAR(255) %DESCRIPTION 'This attribute contains all the terms relevant to defining the reference entity and reference obligation(s).',
    indexReferenceInformation VARCHAR(255) %DESCRIPTION 'This attribute contains all the terms relevant to the underlying Index.',
    basketReferenceInformation VARCHAR(255) %DESCRIPTION 'This attribute contains all the terms relevant to defining the Credit Default Swap Basket.',
    additionalTerm INT NOT NULL %DESCRIPTION 'This attribute is used for representing information contained in the Additional Terms field of the 2003 Master Credit Derivatives confirm.',
    substitution INT %DESCRIPTION 'Value of this attribute set to ''true'' indicates that substitution is applicable.',
    modifiedEquityDelivery INT %DESCRIPTION 'Value of this attribute set to ''true'' indicates that modified equity delivery is applicable.'
);

CREATE TABLE cdm_base_math.FieldWithMetaNonNegativeQuantitySchedule (
    FieldWithMetaNonNegativeQuantitySchedule_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_event_common.PositionEventIntentEnum (
    PositionEventIntentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.AveragingCalculationMethodEnum (
    AveragingCalculationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_master.IndexAdjustmentEvents (
    IndexAdjustmentEvents_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.SubstitutionProvisions (
    SubstitutionProvisions_id INT UNIQUE NOT NULL,
    numberOfSubstitutionsAllowed INT %DESCRIPTION 'Specifies if 1 or more substitutions are allowed.',
    noticeDeadlinePeriod VARCHAR(255) %DESCRIPTION 'Defines the min period for notify of a substitution.',
    noticeDeadlineDateTime VARCHAR(255) %DESCRIPTION 'A specific date and time for the notice deadline'
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralTaxonomy (
    CollateralTaxonomy_id INT UNIQUE NOT NULL,
    taxonomyValue VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the taxonomy value.',
    taxonomySource VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the taxonomy source.'
);

CREATE TABLE cdm_base_staticdata_asset_common.DeliveryNearbyTypeEnum (
    DeliveryNearbyTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.AveragingStrikeFeature (
    AveragingStrikeFeature_id INT UNIQUE NOT NULL,
    averagingCalculation VARCHAR(255) NOT NULL %DESCRIPTION 'Defines parameters for use in cases when a valuation or other term is based on an average of market observations.',
    observationTerms VARCHAR(255) NOT NULL %DESCRIPTION 'Class containing terms that are associated with observing a price/benchmark/index across either single or multple observations. '
);

CREATE TABLE cdm_product_template.ExtensionEvent (
    ExtensionEvent_id INT UNIQUE NOT NULL,
    adjustedExerciseDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which option exercise takes place. This date should already be adjusted for any applicable business day convention.',
    adjustedExtendedTerminationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The termination date if an extendible provision is exercised. This date should already be adjusted for any applicable business day convention.'
);

CREATE TABLE cdm_event_common.AssetTransferTypeEnum (
    AssetTransferTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.ActionEnum (
    ActionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_master.FxAdditionalTerms (
    FxAdditionalTerms_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.ConstituentWeight (
    ConstituentWeight_id INT UNIQUE NOT NULL,
    openUnits FLOAT %DESCRIPTION 'The number of units (index or securities) that constitute the underlier of the swap. In the case of a basket swap, this element is used to reference both the number of basket units, and the number of each asset components of the basket when these are expressed in absolute terms.',
    basketPercentage FLOAT %DESCRIPTION 'The relative weight of each respective basket constituent, expressed in percentage. A basket percentage of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_collateral.CollateralProvisions_eligibleCollateral (
    CollateralProvisions_id INT NOT NULL,
    EligibleCollateralCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralProvisions (
    CollateralProvisions_id INT UNIQUE NOT NULL,
    collateralType VARCHAR(255) NOT NULL %DESCRIPTION 'Enumerates the collateral types which are accepted by the Seller.',
    eligibleCollateral INT NOT NULL %DESCRIPTION 'The eligible collateral as specified in relation to the transaction.',
    substitutionProvisions VARCHAR(255) %DESCRIPTION 'The provisions for collateral substitutions such as how many and when they are allowed.'
);

CREATE TABLE cdm_base_datetime.CalculationFrequency_businessCenter (
    CalculationFrequency_id INT NOT NULL,
    BusinessCenterEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.CalculationFrequency (
    CalculationFrequency_id INT UNIQUE NOT NULL,
    period VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the time period at which calculation is performed, e.g. 1 month.',
    monthOfYear FLOAT %DESCRIPTION 'Specifies the month of the year if used.',
    dayOfMonth FLOAT %DESCRIPTION 'Specifies the day of the month if used.',
    dayOfWeek VARCHAR(255) %DESCRIPTION 'Specifies the day of the week if used.',
    weekOfMonth FLOAT %DESCRIPTION 'Specifies the week of the month if used.',
    offsetDays FLOAT NOT NULL %DESCRIPTION 'Specifies how many days from the trigger event should the payment occur.',
    dateLocation VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies where is the time measured.',
    businessCenter INT NOT NULL %DESCRIPTION 'Specifies the business center for adjustment of calculation period.'
);

CREATE TABLE com_rosetta_model_lib_meta.Key (
    Key_id INT UNIQUE NOT NULL,
    scope VARCHAR(255),
    value VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.RegionalGovernmentIssuerType (
    RegionalGovernmentIssuerType_id INT UNIQUE NOT NULL,
    sovereignRecourse INT NOT NULL %DESCRIPTION 'Applies to regional governments, local authorities or municipals.  True if entity has recourse to sovereign (e.g. debt guaranteed by government).  False if entity does not have recourse to sovereign.'
);

CREATE TABLE cdm_product_common_settlement.PriceQuantity_price (
    PriceQuantity_id INT NOT NULL,
    FieldWithMetaPriceSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.PriceQuantity_quantity (
    PriceQuantity_id INT NOT NULL,
    FieldWithMetaNonNegativeQuantitySchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.PriceQuantity (
    PriceQuantity_id INT UNIQUE NOT NULL,
    price INT NOT NULL %DESCRIPTION 'Specifies a price to be used for trade amounts and other purposes.',
    quantity INT NOT NULL %DESCRIPTION 'Specifies a quantity to be associated with an event, for example a trade amount.',
    observable VARCHAR(255) %DESCRIPTION 'Specifies the object to be observed for a price, it could be an asset or a reference. The cardinality is optional as some quantity / price cases have no observable (e.g. a notional and a fixed rate in a given currency).',
    buyerSeller VARCHAR(255) %DESCRIPTION 'Defines the direction of the exchange. The convention is that the buyer receives the quantity / pays the price, whereas the seller receives the price / pays the quantity. Attribute is optional in case the price/quantity settlement is defined as part of the product mechanics.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Whether the settlement is cash or physical and the corresponding terms. Attribute is optional in case the price/quantity settlement is defined as part of the product mechanics.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'Specifies the date at which the price and quantity become effective. This day may be subject to adjustment in accordance with a business day convention, or could be specified as relative to a trade date, for instance. Optional cardinality, as the effective date is usually specified in the product definition, so it may only need to be specified as part of the PriceQuantity in an increase/decrease scenario for an existing trade.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClauseIdentifierEnum (
    MasterAgreementClauseIdentifierEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_identifier.CommodityLocationIdentifierTypeEnum (
    CommodityLocationIdentifierTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.MultipleExercise (
    MultipleExercise_id INT UNIQUE NOT NULL,
    maximumNotionalAmount FLOAT %DESCRIPTION 'The maximum notional amount that can be exercised on a given exercise date.',
    maximumNumberOfOptions INT %DESCRIPTION 'The maximum number of options that can be exercised on a given exercise date. If the number is not specified, it means that the maximum number of options corresponds to the remaining unexercised options.',
    notionaReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to the associated notional schedule defined elsewhere in the document. This element has been made optional as part of its integration in the OptionBaseExtended, because not required for the options on securities.',
    integralMultipleAmount FLOAT %DESCRIPTION 'A notional amount which restricts the amount of notional that can be exercised when partial exercise or multiple exercise is applicable. The integral multiple amount defines a lower limit of notional that can be exercised and also defines a unit multiple of notional that can be exercised, i.e. only integer multiples of this amount can be exercised.',
    minimumNotionalAmount FLOAT %DESCRIPTION 'The minimum notional amount that can be exercised on a given exercise date. See multipleExercise.',
    minimumNumberOfOptions INT %DESCRIPTION 'The minimum number of options that can be exercised on a given exercise date.'
);

CREATE TABLE cdm_observable_asset.CreditNotation (
    CreditNotation_id INT UNIQUE NOT NULL,
    agency VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies The credit agency to which the other variables (notation, scale, debt type) refer to.',
    notation VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies The credit rating notation. As it varies among credit rating agencies, FpML doesn''t specify a default scheme.',
    scale VARCHAR(255) %DESCRIPTION 'Specifies the credit rating scale, with a typical distinction between short term, long term. FpML doesn''t specify a default scheme, which is hence not specified as an enumeration as part of the CDM.',
    debt VARCHAR(255) %DESCRIPTION 'Specifies the credit rating debt type (e.g. long term, high yield, deposits, ...) associated with the credit rating notation and scale.',
    outlook VARCHAR(255) %DESCRIPTION 'Assesses the potential direction of a long-term credit rating over the intermediate term, which is generally up to two years for investment grade and generally up to one year for speculative grade.',
    creditWatch VARCHAR(255) %DESCRIPTION 'Indicates the potential direction of a short-term or long-term rating. It focuses on identifiable events and short-term trends that cause ratings to be placed under special surveillance.'
);

CREATE TABLE cdm_observable_event.TriggerTypeEnum (
    TriggerTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.CancelableProvisionAdjustedDates_cancellationEvent (
    CancelableProvisionAdjustedDates_id INT NOT NULL,
    CancellationEvent_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.CancelableProvisionAdjustedDates (
    CancelableProvisionAdjustedDates_id INT UNIQUE NOT NULL,
    cancellationEvent INT NOT NULL %DESCRIPTION 'The adjusted dates for an individual cancellation date.'
);

CREATE TABLE cdm_base_staticdata_party_metafields.ReferenceWithMetaLegalEntity (
    ReferenceWithMetaLegalEntity_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.EU_EMIR_EligibleCollateralEnum (
    EU_EMIR_EligibleCollateralEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.ResourceTypeEnum (
    ResourceTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.AssetPayout_assetLeg (
    AssetPayout_id INT NOT NULL,
    AssetLeg_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.AssetPayout (
    AssetPayout_id INT UNIQUE NOT NULL,
    assetLeg INT NOT NULL %DESCRIPTION 'Defines each asset movement as a buy/sell at different dates, typically 1 near leg and 1 far leg in a securities financing transaction.',
    securityInformation VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the Purchased Security.  Within SecurityPayout we include a condition which validates that the product must be a Security (see below condition ''ProductMustBeSecurity'').',
    durationType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the Duration Terms of the Security Finance transaction. e.g. Open or Term.',
    minimumFee VARCHAR(255) %DESCRIPTION 'A contractual minimum amount which the borrower will pay, regardless of the duration of the loan. A mechanism for making sure that a trade generates enough income.',
    dividendTerms VARCHAR(255) %DESCRIPTION 'Specifies the terms under which dividends received by the borrower are passed through to the lender.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_product_template.StrategyFeature (
    StrategyFeature_id INT UNIQUE NOT NULL,
    strikeSpread VARCHAR(255) %DESCRIPTION 'Definition of the upper strike in a strike spread.',
    calendarSpread VARCHAR(255) %DESCRIPTION 'Definition of the later expiration date in a calendar spread.'
);

CREATE TABLE cdm_event_common_metafields.ReferenceWithMetaTradeState (
    ReferenceWithMetaTradeState_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_math.Schedule_datedValue (
    Schedule_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.Schedule (
    Schedule_id INT UNIQUE NOT NULL,
    value FLOAT NOT NULL %DESCRIPTION 'The initial rate or amount, as the case may be. An initial rate of 5% would be represented as 0.05.',
    datedValue INT NOT NULL %DESCRIPTION 'The schedule of step date and value pairs. On each step date the associated step value becomes effective. A list of steps may be ordered in the document by ascending step date. An FpML document containing an unordered list of steps is still regarded as a conformant document.'
);

CREATE TABLE cdm_base_staticdata_asset_common.ConvertibleBond (
    ConvertibleBond_id INT UNIQUE NOT NULL,
    productIdentifier VARCHAR(255)
);

CREATE TABLE cdm_event_workflow.CreditLimitInformation_limitApplicable (
    CreditLimitInformation_id INT NOT NULL,
    LimitApplicableExtended_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.CreditLimitInformation (
    CreditLimitInformation_id INT UNIQUE NOT NULL,
    limitApplicable INT NOT NULL
);

CREATE TABLE cdm_event_common.CorporateActionTypeEnum (
    CorporateActionTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.AdjustableDates_unadjustedDate (
    AdjustableDates_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.AdjustableDates_adjustedDate (
    AdjustableDates_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.AdjustableDates (
    AdjustableDates_id INT UNIQUE NOT NULL,
    unadjustedDate INT NOT NULL %DESCRIPTION 'A date subject to adjustment.',
    dateAdjustments VARCHAR(255) %DESCRIPTION 'The business day convention and financial business centers used for adjusting the date if it would otherwise fall on a day that is not a business date in the specified business centers.',
    adjustedDate INT NOT NULL %DESCRIPTION 'The date(s) once the adjustment has been performed. (Note that this date may change if the business center holidays change).'
);

CREATE TABLE cdm_regulation.SchmeNm (
    SchmeNm_id INT UNIQUE NOT NULL,
    prtry VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_observable_asset_fro.FloatingRateIndexStyleEnum (
    FloatingRateIndexStyleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.PeriodTimeEnum (
    PeriodTimeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_collateral.Collateral_portfolioIdentifier (
    Collateral_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.Collateral_collateralPortfolio (
    Collateral_id INT NOT NULL,
    ReferenceWithMetaCollateralPortfolio_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.Collateral (
    Collateral_id INT UNIQUE NOT NULL,
    independentAmount VARCHAR(255) %DESCRIPTION 'Independent Amount is an amount that usually less creditworthy counterparties are asked to provide. It can either be a fixed amount or a percentage of the Transaction''s value. The Independent Amount can be: (i) transferred before any trading between the parties occurs (as a deposit at a third party''s account or with the counterparty) or (ii) callable after trading has occurred (typically because a downgrade has occurred). In situation (i), the Independent Amount is not included in the calculation of Exposure, but in situation (ii), it is included in the calculation of Exposure. Thus, for situation (ii), the Independent Amount may be transferred along with any collateral call. Independent Amount is a defined term in the ISDA Credit Support Annex. (''with respect to a party, the amount specified as such for that party in Paragraph 13; if no amount is specified, zero'').',
    portfolioIdentifier INT NOT NULL %DESCRIPTION 'A list of identifiers pointing to the collateral portfolios which contain the collateral which covers a trade.',
    collateralPortfolio INT NOT NULL %DESCRIPTION 'The collateral portfolios which contain the collateral which covers a trade. (NB: this can be provided by reference to a global key for each CollateralPortfolio object)',
    collateralProvisions VARCHAR(255) %DESCRIPTION 'specifies the collateral provisions of the product.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.ObservationShiftCalculation (
    ObservationShiftCalculation_id INT UNIQUE NOT NULL,
    offsetDays INT %DESCRIPTION 'The number of days of observation shift.',
    calculationBase VARCHAR(255) %DESCRIPTION 'Whether the rate is calculated in advance, in arrears, or relative to a reset date.',
    additionalBusinessDays VARCHAR(255) %DESCRIPTION 'Any additional business days that be applicable.'
);

CREATE TABLE cdm_event_common.BillingRecord (
    BillingRecord_id INT UNIQUE NOT NULL,
    tradeState VARCHAR(255) NOT NULL %DESCRIPTION 'The trade for the individual billing record.',
    recordTransfer VARCHAR(255) NOT NULL %DESCRIPTION 'The settlement terms for the billing record',
    recordStartDate VARCHAR(255) NOT NULL %DESCRIPTION 'The starting date of the period described by this record',
    recordEndDate VARCHAR(255) NOT NULL %DESCRIPTION 'The ending date of the period described by this record',
    minimumFee VARCHAR(255) %DESCRIPTION 'Indicates the minimum fee amount applied to the billing record, if any.'
);

CREATE TABLE cdm_product_asset.DayDistributionEnum (
    DayDistributionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.FieldWithMetaMatrixTermEnum (
    FieldWithMetaMatrixTermEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.CollateralMarginTypeEnum (
    CollateralMarginTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.DatedValue (
    DatedValue_id INT UNIQUE NOT NULL,
    date VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the associated step value becomes effective. This day may be subject to adjustment in accordance with a business day convention.',
    value FLOAT NOT NULL %DESCRIPTION 'The rate of amount which becomes effective on the associated step date. A rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_asset_floatingrate.FloatingRateIndexProcessingTypeEnum (
    FloatingRateIndexProcessingTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_master.MasterConfirmationTypeEnum (
    MasterConfirmationTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement_metafields.ReferenceWithMetaResolvablePriceQuantity (
    ReferenceWithMetaResolvablePriceQuantity_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_asset.DividendDateReference (
    DividendDateReference_id INT UNIQUE NOT NULL,
    dateReference VARCHAR(255) NOT NULL %DESCRIPTION 'Specification of the dividend date using an enumeration, with values such as the pay date, the ex-date or the record date.',
    paymentDateOffset VARCHAR(255) %DESCRIPTION 'Only to be used when SharePayment has been specified in the dividendDateReference element. The number of Currency Business Days following the day on which the Issuer of the Shares pays the relevant dividend to holders of record of the Shares.'
);

CREATE TABLE cdm_event_common_metafields.ReferenceWithMetaTrade (
    ReferenceWithMetaTrade_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.MultipleValuationDates (
    MultipleValuationDates_id INT UNIQUE NOT NULL,
    businessDaysThereafter INT %DESCRIPTION 'The number of business days between successive valuation dates when multiple valuation dates are applicable for cash settlement. ISDA 2003 Term: Business Days thereafter.',
    numberValuationDates INT %DESCRIPTION 'Where multiple valuation dates are specified as being applicable for cash settlement, this element specifies (a) the number of applicable valuation dates, and (b) the number of business days after satisfaction of all conditions to settlement when the first such valuation date occurs, and (c) the number of business days thereafter of each successive valuation date. ISDA 2003 Term: Multiple Valuation Dates.',
    businessDays INT %DESCRIPTION 'A number of business days. Its precise meaning is dependant on the context in which this element is used. ISDA 2003 Term: Business Day.'
);

CREATE TABLE cdm_product_template.TerminationProvision (
    TerminationProvision_id INT UNIQUE NOT NULL,
    cancelableProvision VARCHAR(255) %DESCRIPTION 'A provision that allows the specification of an embedded option within a swap giving the buyer of the option the right to terminate the swap, in whole or in part, on the early termination date.',
    earlyTerminationProvision VARCHAR(255) %DESCRIPTION 'Parameters specifying provisions relating to the optional and mandatory early termination of a swap transaction.',
    evergreenProvision VARCHAR(255) %DESCRIPTION 'A data defining: the right of a party to exercise an Evergreen option',
    extendibleProvision VARCHAR(255) %DESCRIPTION 'A provision that allows the specification of an embedded option with a swap giving the buyer of the option the right to extend the swap, in whole or in part, to the extended termination date.'
);

CREATE TABLE cdm_event_common.ClearingInstruction (
    ClearingInstruction_id INT UNIQUE NOT NULL,
    alphaContract VARCHAR(255) NOT NULL %DESCRIPTION 'The contract that will be submitted to the clearing house for clearing. The contract should indicate that it should be cleared by assigning a clearing organisation as a party role.',
    clearingParty VARCHAR(255) NOT NULL %DESCRIPTION 'The Central Counter party (CCP) that the contract will be submitted to for clearing.',
    party1 VARCHAR(255) NOT NULL %DESCRIPTION 'First party facing the CCP if it is clearing for its own account.',
    party2 VARCHAR(255) NOT NULL %DESCRIPTION 'Second party facing the CCP if it is clearing for its own account.',
    clearerParty1 VARCHAR(255) %DESCRIPTION 'Optional party facing the CCP, acting as clearing member for party1.',
    clearerParty2 VARCHAR(255) %DESCRIPTION 'Optional party facing the CCP, acting as clearing member for party2.',
    isOpenOffer INT %DESCRIPTION 'Open Offer'
);

CREATE TABLE cdm_event_common.CounterpartyPositionBusinessEvent_after (
    CounterpartyPositionBusinessEvent_id INT NOT NULL,
    CounterpartyPositionState_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CounterpartyPositionBusinessEvent (
    CounterpartyPositionBusinessEvent_id INT UNIQUE NOT NULL,
    intent VARCHAR(255) NOT NULL %DESCRIPTION 'The intent attribute is meant to be specified when the event qualification cannot be programmatically inferred from the event features. As a result it is only associated with those primitives that can give way to such ambiguity, the quantityChange being one of those.',
    corporateActionIntent VARCHAR(255) %DESCRIPTION 'The intent of a corporate action on the position.',
    eventDate VARCHAR(255) %DESCRIPTION 'Specifies the date on which the event is taking place. This date is equal to the trade date in the case of a simple execution.  However it can be different from the trade date, for example in the case of a partial termination.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date on which the event contractually takes effect, when different from the event date.',
    packageInformation VARCHAR(255) %DESCRIPTION 'Specifies the package information in case the business event represents several trades executed as a package (hence this attribute is optional). The package information is only instantiated once at the business event level to preserve referential integrity, whereas individual trades make reference to it to identify that they are part of a package.',
    after INT NOT NULL %DESCRIPTION 'Specifies the after position state(s) created.'
);

CREATE TABLE cdm_product_template.OptionStrike (
    OptionStrike_id INT UNIQUE NOT NULL,
    strikePrice VARCHAR(255) %DESCRIPTION 'Defines the strike of an option in the form of a price that could be a cash price, interestRate, or other types.',
    strikeReference VARCHAR(255) %DESCRIPTION 'Defines the strike of an option in reference to the spread of the underlying swap (typical practice in the case of an option on a credit single name swaps).',
    referenceSwapCurve VARCHAR(255) %DESCRIPTION 'Defines the strike of an option when expressed by reference to a swap curve (Typically the case for a convertible bond option).',
    averagingStrikeFeature VARCHAR(255) %DESCRIPTION 'Defines an  option strike that is calculated from an average of observed market prices.'
);

CREATE TABLE cdm_base_staticdata_party.PayerReceiver (
    PayerReceiver_id INT UNIQUE NOT NULL,
    payer VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the counterparty responsible for making the payments defined by this structure.  The party is one of the two principal parties to the transaction.',
    receiver VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the party that receives the payments corresponding to this structure.  The party is one of the two counterparties to the transaction.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.InflationCalculationStyleEnum (
    InflationCalculationStyleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.NaturalPerson_personId (
    NaturalPerson_id INT NOT NULL,
    FieldWithMetaPersonIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.NaturalPerson_middleName (
    NaturalPerson_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.NaturalPerson_initial (
    NaturalPerson_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.NaturalPerson_personRole (
    NaturalPerson_id INT NOT NULL,
    NaturalPersonRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.NaturalPerson (
    NaturalPerson_id INT UNIQUE NOT NULL,
    personId INT NOT NULL %DESCRIPTION 'The identifier associated with a person, e.g. the internal identification code.',
    honorific VARCHAR(255) %DESCRIPTION 'An honorific title, such as Mr., Ms., Dr. etc.',
    firstName VARCHAR(255) %DESCRIPTION 'The natural person''s first name. It is optional in FpML.',
    middleName INT NOT NULL %DESCRIPTION 'The natural person''s middle name(s). If a middle name is provided then an initial should be absent.',
    initial INT NOT NULL %DESCRIPTION 'The natural person''s middle initial(s). If a middle initial is provided then a name should be absent.',
    surname VARCHAR(255) %DESCRIPTION 'The natural person''s surname.',
    suffix VARCHAR(255) %DESCRIPTION 'Name suffix, such as Jr., III, etc.',
    dateOfBirth VARCHAR(255) %DESCRIPTION 'The natural person''s date of birth.',
    contactInformation VARCHAR(255) %DESCRIPTION 'The contact information for such person, when different from the contact information associated with the party.',
    personRole INT NOT NULL %DESCRIPTION 'The role of the person(s) '
);

CREATE TABLE cdm_base_staticdata_party.PartyReferencePayerReceiver (
    PartyReferencePayerReceiver_id INT UNIQUE NOT NULL,
    payerPartyReference VARCHAR(255) NOT NULL %DESCRIPTION 'The party responsible for making the payments defined by this structure.',
    payerAccountReference VARCHAR(255) %DESCRIPTION 'A reference to the account responsible for making the payments defined by this structure.',
    receiverPartyReference VARCHAR(255) NOT NULL %DESCRIPTION 'The party that receives the payments corresponding to this structure.',
    receiverAccountReference VARCHAR(255) %DESCRIPTION 'A reference to the account that receives the payments corresponding to this structure.'
);

CREATE TABLE cdm_base_staticdata_party.Counterparty (
    Counterparty_id INT UNIQUE NOT NULL,
    role VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the CounterpartyEnum, e.g. either Party1 or Party2, that is associated to the partyReference.',
    partyReference VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the party that is associated to the counterparty.'
);

CREATE TABLE cdm_base_staticdata_asset_common.AssetClassEnum (
    AssetClassEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.FloatingAmountEvents (
    FloatingAmountEvents_id INT UNIQUE NOT NULL,
    failureToPayPrincipal INT %DESCRIPTION 'A floating rate payment event. Corresponds to the failure by the Reference Entity to pay an expected principal amount or the payment of an actual principal amount that is less than the expected principal amount. ISDA 2003 Term: Failure to Pay Principal.',
    interestShortfall VARCHAR(255) %DESCRIPTION 'A floating rate payment event. With respect to any Reference Obligation Payment Date, either (a) the non-payment of an Expected Interest Amount or (b) the payment of an Actual Interest Amount that is less than the Expected Interest Amount. ISDA 2003 Term: Interest Shortfall.',
    writedown INT %DESCRIPTION 'A floating rate payment event. Results from the fact that the underlier writes down its outstanding principal amount. ISDA 2003 Term: Writedown.',
    impliedWritedown INT %DESCRIPTION 'A floating rate payment event. Results from the fact that losses occur to the underlying instruments that do not result in reductions of the outstanding principal of the reference obligation.',
    floatingAmountProvisions VARCHAR(255) %DESCRIPTION 'Specifies the floating amount provisions associated with the floatingAmountEvents.',
    additionalFixedPayments VARCHAR(255) %DESCRIPTION 'Specifies the events that will give rise to the payment additional fixed payments.'
);

CREATE TABLE cdm_observable_asset.FeeTypeEnum (
    FeeTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.MultipleDebtTypes_debtType (
    MultipleDebtTypes_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.MultipleDebtTypes (
    MultipleDebtTypes_id INT UNIQUE NOT NULL,
    condition VARCHAR(255) NOT NULL %DESCRIPTION 'An enumerated attribute, to qualify whether All or Any debt type applies.',
    debtType INT NOT NULL %DESCRIPTION 'The type of debt, e.g. long term debt, deposit, ... FpML doesn''t specific a scheme value, hence no enumeration is specified as part of the CDM. At least two debt types much be specified.'
);

CREATE TABLE cdm_observable_asset.FxInformationSource (
    FxInformationSource_id INT UNIQUE NOT NULL,
    fixingTime VARCHAR(255) %DESCRIPTION 'The time that the fixing will be taken along with a business center to define the time zone.',
    sourceProvider VARCHAR(255) %DESCRIPTION 'An information source for obtaining a market data point. For example Bloomberg, Reuters, Telerate, etc.',
    sourcePage VARCHAR(255) %DESCRIPTION 'A specific page for the source for obtaining a market data point. In FpML, this is specified as a scheme, rateSourcePageScheme, for which no coding Scheme or URI is specified.',
    sourcePageHeading VARCHAR(255) %DESCRIPTION 'The heading for the source on a given source page.'
);

CREATE TABLE cdm_product_collateral.CollateralInterestHandlingEnum (
    CollateralInterestHandlingEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_regulation.FinInstrmRptgTxRpt (
    FinInstrmRptgTxRpt_id INT UNIQUE NOT NULL,
    tx VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_regulation.Nm (
    Nm_id INT UNIQUE NOT NULL,
    refRate VARCHAR(255) NOT NULL,
    term VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_asset_metafields.ReferenceWithMetaProtectionTerms (
    ReferenceWithMetaProtectionTerms_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_identifier.AssignedIdentifier (
    AssignedIdentifier_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) NOT NULL %DESCRIPTION 'The identifier value.',
    version INT %DESCRIPTION 'The identifier version, which is specified as an integer and is meant to be incremented each time the transaction terms (whether contract or event) change. This version is made option to support the use case where the identifier is referenced without the version. The constraint that a contract and a lifecycle event need to have an associated version is enforced through data rules.'
);

CREATE TABLE cdm_observable_event.TriggerTimeTypeEnum (
    TriggerTimeTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_credit.NotDomesticCurrency (
    NotDomesticCurrency_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the Not Domestic Currency provision is applicable.',
    currency VARCHAR(255) %DESCRIPTION 'An explicit specification of the domestic currency. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.'
);

CREATE TABLE cdm_event_common.CreditEvent_publiclyAvailableInformation (
    CreditEvent_id INT NOT NULL,
    Resource_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CreditEvent (
    CreditEvent_id INT UNIQUE NOT NULL,
    creditEventType VARCHAR(255) NOT NULL %DESCRIPTION 'The type of credit event taking place.',
    eventDeterminationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date in which the credit event is determined by the Credit Derivatives Determinations Comitee.',
    auctionDate VARCHAR(255) %DESCRIPTION 'The date on which the auction is scheduled to occur.',
    finalPrice VARCHAR(255) %DESCRIPTION 'The final price resulting from the auction.',
    recoveryPercent FLOAT %DESCRIPTION 'The percentage of the original value of the asset affected by the credit event that can be recovered.',
    publiclyAvailableInformation INT NOT NULL %DESCRIPTION 'A public information source, e.g. a particular newspaper or electronic news service, that may publish relevant information used in the determination of whether or not a credit event has occurred.',
    referenceInformation VARCHAR(255) NOT NULL %DESCRIPTION 'The reference entity, part of a credit basket, impacted by the credit event.'
);

CREATE TABLE cdm_observable_event.Trigger (
    Trigger_id INT UNIQUE NOT NULL,
    level FLOAT %DESCRIPTION 'The trigger level.',
    levelPercentage FLOAT %DESCRIPTION 'The trigger level percentage.',
    creditEvents VARCHAR(255),
    creditEventsReference VARCHAR(255),
    triggerType VARCHAR(255) %DESCRIPTION 'The Triggering condition.',
    triggerTimeType VARCHAR(255) %DESCRIPTION 'The valuation time type of knock condition.'
);

CREATE TABLE cdm_base_datetime.PeriodicDates (
    PeriodicDates_id INT UNIQUE NOT NULL,
    startDate VARCHAR(255) %DESCRIPTION 'The start date of the calculation period. FpML specifies that for interest rate swaps this date must only be specified if it is not equal to the effective date. It is always specified in the case of equity swaps and credit default swaps with periodic payments. This date may be subject to adjustment in accordance with a business day convention.',
    endDate VARCHAR(255) %DESCRIPTION 'The end date of the calculation period. FpML specifies that for interest rate swaps this date must only be specified if it is not equal to the termination date. It is always specified in the case of equity swaps with periodic payments. This date may be subject to adjustment in accordance with a business day convention.',
    periodFrequency VARCHAR(255) %DESCRIPTION 'The frequency at which calculation period end dates occur with the regular part of the calculation period schedule and their roll date convention.',
    periodDatesAdjustments VARCHAR(255) %DESCRIPTION 'The specification of the business day convention and financial business centers used for adjusting any calculation period date if it would otherwise fall on a day that is not a business day in the specified business center.',
    dayType VARCHAR(255) %DESCRIPTION 'Denotes the enumerated values to specify the day type classification used in counting the number of days between two dates.'
);

CREATE TABLE cdm_observable_asset.PriceComposite (
    PriceComposite_id INT UNIQUE NOT NULL,
    baseValue FLOAT NOT NULL %DESCRIPTION 'The 1st value in the arithmetic operation, which may be non-commutative in some cases: Subtract, Divide). This 1st operand is called ''baseValue'' as it refers to the price anchor in the arithmetic operation: e.g. the clean price (Bond) or the spot rate (FX).',
    operand FLOAT NOT NULL %DESCRIPTION 'The 2nd value in the arithmetic operation, which may be non-commutative in some cases: Subtract, Divide). The 2nd operand is called ''operand'' to distinguish it from the 1st one which is the price anchor.',
    arithmeticOperator VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the arithmetic operator via an enumeration.',
    operandType VARCHAR(255) %DESCRIPTION 'Optionally qualifies the type of operand: e.g. accrued or forward point.'
);

CREATE TABLE cdm_legaldocumentation_common.OtherAgreement (
    OtherAgreement_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) %DESCRIPTION 'An identifier that has been created to identify the agreement.',
    otherAgreementType VARCHAR(255) NOT NULL %DESCRIPTION 'The agreement executed between the parties and intended to govern product-specific derivatives transactions between those parties.',
    version VARCHAR(255) %DESCRIPTION 'The version of the agreement.',
    date VARCHAR(255) %DESCRIPTION 'The date on which the agreement was signed.'
);

CREATE TABLE cdm_regulation.FinInstrm (
    FinInstrm_id INT UNIQUE NOT NULL,
    othr VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_common_schedule.CalculationPeriodBase (
    CalculationPeriodBase_id INT UNIQUE NOT NULL,
    adjustedStartDate VARCHAR(255) %DESCRIPTION 'The calculation period start date, adjusted according to any relevant business day convention.',
    adjustedEndDate VARCHAR(255) %DESCRIPTION 'The calculation period end date, adjusted according to any relevant business day convention.'
);

CREATE TABLE cdm_base_datetime.AdjustableOrRelativeDate (
    AdjustableOrRelativeDate_id INT UNIQUE NOT NULL,
    adjustableDate VARCHAR(255) %DESCRIPTION 'A date that shall be subject to adjustment if it would otherwise fall on a day that is not a business day in the specified business centers, together with the convention for adjusting the date.',
    relativeDate VARCHAR(255) %DESCRIPTION 'A date specified as some offset to another date (the anchor date).'
);

CREATE TABLE cdm_product_asset.DividendPeriodEnum (
    DividendPeriodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.ComputedAmount (
    ComputedAmount_id INT UNIQUE NOT NULL,
    callFunction VARCHAR(255) NOT NULL,
    amount FLOAT NOT NULL,
    currency VARCHAR(255) %DESCRIPTION 'The currency in which the computed amount is denominated. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.'
);

CREATE TABLE cdm_product_collateral.ContactElection_partyElection (
    ContactElection_id INT NOT NULL,
    PartyContactInformation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.ContactElection (
    ContactElection_id INT UNIQUE NOT NULL,
    partyElection INT NOT NULL %DESCRIPTION 'The parties'' contact information election.'
);

CREATE TABLE cdm_product_template.TradableProduct_tradeLot (
    TradableProduct_id INT NOT NULL,
    TradeLot_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.TradableProduct_counterparty (
    TradableProduct_id INT NOT NULL,
    Counterparty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.TradableProduct_ancillaryParty (
    TradableProduct_id INT NOT NULL,
    AncillaryParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.TradableProduct (
    TradableProduct_id INT UNIQUE NOT NULL,
    product VARCHAR(255) NOT NULL %DESCRIPTION 'The underlying product to be included in a contract or execution.',
    tradeLot INT NOT NULL %DESCRIPTION 'Specifies the price, quantity and effective date of each trade lot, when the same product may be traded multiple times in different lots with the same counterparty. In a trade increase, a new trade lot is added to the list, with the corresponding effective date. In a trade decrease, the existing trade lot(s) are decreased of the corresponding quantity (and an unwind fee may have to be settled). The multiple cardinality and the ability to increase existing trades is used for Equity Swaps in particular.',
    counterparty INT NOT NULL %DESCRIPTION 'Specifies the parties which are the two counterparties to the transaction.  The product is agnostic to the actual parties to the transaction, with the party references abstracted away from the product definition and replaced by the counterparty enum (e.g. CounterpartyEnum values Party1 or Party2). The counterparty enum can then be positioned in the product (e.g. to specify which counterparty is the payer, receiver etc) and this counterparties attribute, which is positioned outside of the product definition, allows the counterparty enum to be associated with an actual party reference.',
    ancillaryParty INT NOT NULL %DESCRIPTION 'Specifies the parties with ancillary roles in the transaction. The product is agnostic to the actual parties involved in the transaction, with the party references abstracted away from the product definition and replaced by the AncillaryRoleEnum. The AncillaryRoleEnum can then be positioned in the product and this AncillaryParty type, which is positioned outside of the product definition, allows the AncillaryRoleEnum to be associated with an actual party reference.',
    adjustment VARCHAR(255) %DESCRIPTION 'Specifies the conditions that govern the adjustment to the quantity of a product being traded: e.g. execution, portfolio rebalancing etc. It is typically used in the context of Equity Swaps.'
);

CREATE TABLE cdm_event_common.ScheduledTransfer (
    ScheduledTransfer_id INT UNIQUE NOT NULL,
    transferType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies a transfer created from a scheduled or contingent event on a contract, e.g. Exercise, Performance, Credit Event',
    corporateActionTransferType VARCHAR(255)
);

CREATE TABLE cdm_product_template.ExercisePeriod (
    ExercisePeriod_id INT UNIQUE NOT NULL,
    earliestExerciseDateTenor VARCHAR(255) NOT NULL %DESCRIPTION 'The time interval to the first (and possibly only) exercise date in the exercise period.',
    exerciseFrequency VARCHAR(255) %DESCRIPTION 'The frequency of subsequent exercise dates in the exercise period following the earliest exercise date. An interval of 1 day should be used to indicate an American style exercise period.'
);

CREATE TABLE cdm_observable_asset.Price_datedValue (
    Price_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.Price (
    Price_id INT UNIQUE NOT NULL,
    perUnitOf VARCHAR(255) %DESCRIPTION 'Provides an attribute to define the unit of the thing being priced. For example, {amount, unitOfAmount, PerUnitOfAmount} = [10, EUR, Shares] = (10.00 EUR/SHARE) * (300,000 SHARES) = EUR 3,000,000.00 (Shares cancel out in the calculation).',
    priceType VARCHAR(255) %DESCRIPTION 'Specifies the price type as an enumeration: interest rate, exchange rate, asset price etc. This attribute is mandatory so that prices can always be clasiffied according to their type. The price type implies some constraints on the price''s units.',
    priceExpression VARCHAR(255) %DESCRIPTION '(Optionally) Specifies whether the price is expressed in absolute or percentage terms.',
    composite VARCHAR(255) %DESCRIPTION '(Optionally) Specifies the underlying price components if the price can be expressed as a composite: e.g. dirty price = clean price + accrued.',
    arithmeticOperator VARCHAR(255) %DESCRIPTION '(Optionally) When the price is to be understood as an operator to apply to an observable, i.e. a spread, multiplier or min/max.',
    cashPrice VARCHAR(255) %DESCRIPTION '(Optionally when the price type is cash) Additional attributes that further define a cash price, e.g. what type of fee it is.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_legaldocumentation_common.ClosedState (
    ClosedState_id INT UNIQUE NOT NULL,
    state VARCHAR(255) NOT NULL %DESCRIPTION 'The qualification of what gave way to the contract or execution closure, e.g. allocation, termination, ...',
    activityDate VARCHAR(255) NOT NULL %DESCRIPTION 'The activity date on which the closing state took place, i.e. either the event date of the closing event (e.g. option exercise, contract early termination) or the contractual termination date.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date on which the closing event contractually takes effect, when different from the activity date. When an explicit event effective date attribute is associated with the closing event, it will be that date. In the case of a cancellation event, it will be the date on which the cancelled event took place.',
    lastPaymentDate VARCHAR(255) %DESCRIPTION 'The date associated with the last payment in relation to the artefact (e.g. contract) to which this closed state applies. As an example, in the case of an early termination event, it would be the settlement date of the associated fee, if applicable.'
);

CREATE TABLE cdm_observable_asset.PriceSourceDisruption (
    PriceSourceDisruption_id INT UNIQUE NOT NULL,
    fallbackReferencePrice VARCHAR(255) NOT NULL %DESCRIPTION 'The method, prioritised by the order it is listed in this element, to get a replacement rate for the disrupted settlement rate option.'
);

CREATE TABLE cdm_observable_asset.BondPriceAndYieldModel (
    BondPriceAndYieldModel_id INT UNIQUE NOT NULL,
    cleanOrDirtyPrice VARCHAR(255) %DESCRIPTION 'Either the clean or dirty price of the bond.',
    relativePrice VARCHAR(255) %DESCRIPTION 'Bond price relative to a Benchmark.',
    yieldToMaturity FLOAT %DESCRIPTION 'Price specified as a yield to maturity.',
    inflationFactor FLOAT %DESCRIPTION 'The inflation factor is specified for inflation-linked products which require some additional elements to calculate prices correctly.',
    allInPrice FLOAT %DESCRIPTION 'Bond all-in-price which is a price that includes all relevant price adjustments (i.e. accrued interest, haircut or margin ratio, inflation factor,etc.). It expresses a price in terms of percentage of nominal amount.'
);

CREATE TABLE cdm_base_staticdata_asset_common.PriceSource (
    PriceSource_id INT UNIQUE NOT NULL,
    pricePublisher VARCHAR(255) NOT NULL %DESCRIPTION 'Defines a publication in which the price can be found. (e.g Gas Daily, Platts Bloomberg. Commodity publishers can be found at this URL:  http://www.fpml.org/coding-scheme/commodity-information-provider>',
    priceSourceLocation VARCHAR(255) %DESCRIPTION 'Specifies the location of the price which may be a specific page, electornic screen name, or a code (e.g. a RIC code) where the price can be found.',
    priceSourceHeading VARCHAR(255) %DESCRIPTION 'Specifies the heading or field name for the price  on a given page or screen, where applicable.',
    priceSourceTime VARCHAR(255) %DESCRIPTION 'Specifies the time at which the price should be observed.'
);

CREATE TABLE cdm_event_common.CollateralPosition_priceQuantity (
    CollateralPosition_id INT NOT NULL,
    PriceQuantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CollateralPosition (
    CollateralPosition_id INT UNIQUE NOT NULL,
    treatment VARCHAR(255) %DESCRIPTION 'Specifies if there is any treatment to be applied to collateral, such as percentage discount which will impact collateral value.',
    collateralPositionStatus VARCHAR(255) %DESCRIPTION 'Indicates the collateral positions settlement status.',
    priceQuantity INT NOT NULL %DESCRIPTION 'Position with many price quantities.',
    product VARCHAR(255) %DESCRIPTION 'The product underlying the position.',
    cashBalance VARCHAR(255) %DESCRIPTION 'The aggregate cost of proceeds',
    tradeReference VARCHAR(255) %DESCRIPTION 'Reference to the Contract, in case product is contractual and the contract has been formed'
);

CREATE TABLE cdm_base_staticdata_party.BusinessUnit (
    BusinessUnit_id INT UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL %DESCRIPTION 'A name used to describe the organizational unit',
    identifier VARCHAR(255) %DESCRIPTION 'An identifier used to uniquely identify the organizational unit',
    contactInformation VARCHAR(255) %DESCRIPTION 'The contact information for such business unit, when different from the contact information associated with the party.'
);

CREATE TABLE cdm_product_common_settlement.PaymentDiscounting (
    PaymentDiscounting_id INT UNIQUE NOT NULL,
    discountFactor FLOAT %DESCRIPTION 'The value representing the discount factor used to calculate the present value of the cash flow.',
    presentValueAmount VARCHAR(255) %DESCRIPTION 'The amount representing the present value of the forecast payment.'
);

CREATE TABLE cdm_base_staticdata_party.NaturalPersonRoleEnum (
    NaturalPersonRoleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.StockSplitInstruction (
    StockSplitInstruction_id INT UNIQUE NOT NULL,
    adjustmentRatio FLOAT NOT NULL %DESCRIPTION 'The number that denotes the cumulative quantity of post-split shares issued to shareholders versus the quantity of pre-split shares previously issued to shareholders.  This number will be multiplied by existing shares in an equity derivative contract or other positions to determine the post-split number of shares.  With regard to any reference to price, the pre-split reference price will be divided by this number to determine the post-split reference price.',
    effectiveDate VARCHAR(255) NOT NULL %DESCRIPTION 'The effective date of the stock split, also known as the ex-date. This is the date on which the additional shares are paid to the shareholders, or in the case of a reverse stock split, the number shares held by each shareholder is proportionally reduced.  Equity derivative transactions can be amended in firms'' internal systems on such date.   In most markets, the listed stock price is reduced (or increased for a reverse stock split) to account for the split on the same date, but in some markets the price adjustment occurs on a later date.  In either case, equity derivative transactions should be amended on the date that the stocks are paid to the shareholders (or consolidated).'
);

CREATE TABLE cdm_product_asset.ReferenceObligation (
    ReferenceObligation_id INT UNIQUE NOT NULL,
    security VARCHAR(255) %DESCRIPTION 'Identifies the underlying asset when it is a security, such as a bond or convertible bond. The security data type requires one or more productIdentifiers, specificaiton of the security type (e.g. debt), and includes optional attributes to specify a debt class, such as asset-backed, as well as seniority.',
    loan VARCHAR(255) %DESCRIPTION 'Identifies the underlying asset when it is a loan.',
    primaryObligor VARCHAR(255) %DESCRIPTION 'The entity primarily responsible for repaying debt to a creditor as a result of borrowing or issuing bonds. ISDA 2003 Term: Primary Obligor.',
    primaryObligorReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to a reference entity defined elsewhere in the document. Used when the reference entity is the primary obligor.',
    guarantor VARCHAR(255) %DESCRIPTION 'The party that guarantees by way of a contractual arrangement to pay the debts of an obligor if the obligor is unable to make the required payments itself. ISDA 2003 Term: Guarantor.',
    guarantorReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to a reference entity defined elsewhere in the document. Used when the reference entity is the guarantor.',
    standardReferenceObligation INT %DESCRIPTION 'Indicates if the reference obligation is a Standard Reference Obligation. ISDA 2014 Term: Standard Reference Obligation.'
);

CREATE TABLE cdm_base_datetime.FieldWithMetaCommodityBusinessCalendarEnum (
    FieldWithMetaCommodityBusinessCalendarEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_common.ClosedStateEnum (
    ClosedStateEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.CommodityBusinessCalendarEnum (
    CommodityBusinessCalendarEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.AncillaryEntity (
    AncillaryEntity_id INT UNIQUE NOT NULL,
    ancillaryParty VARCHAR(255) %DESCRIPTION 'Identifies a party via its ancillary role on a transaction (e.g. CCP or DCO through which the trade should be cleared.)',
    legalEntity VARCHAR(255)
);

CREATE TABLE cdm_base_datetime.TimeUnitEnum (
    TimeUnitEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.SpreadCalculationMethodEnum (
    SpreadCalculationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.ValuationDate (
    ValuationDate_id INT UNIQUE NOT NULL,
    singleValuationDate VARCHAR(255) %DESCRIPTION 'Where single valuation date is specified as being applicable for cash settlement, this element specifies the number of business days after satisfaction of all conditions to settlement when such valuation date occurs. ISDA 2003 Term: Single Valuation Date.',
    multipleValuationDates VARCHAR(255) %DESCRIPTION 'Where multiple valuation dates are specified as being applicable for cash settlement, this element specifies (a) the number of applicable valuation dates, and (b) the number of business days after satisfaction of all conditions to settlement when the first such valuation date occurs, and (c) the number of business days thereafter of each successive valuation date. ISDA 2003 Term: Multiple Valuation Dates.',
    valuationDate VARCHAR(255) %DESCRIPTION 'The date on which the cash settlement amount will be determined according to the cash settlement method if the parties have not otherwise been able to agree the cash settlement amount. This attribute was formerly part of ''OptionCashSettlement'', which is now being harmonised into a common ''CashSettlementTerms'' that includes a ''ValuationDate''.',
    fxFixingDate VARCHAR(255) %DESCRIPTION 'The date on which the currency rate will be determined for the purpose of specifying the amount in deliverable currency. This attribute was formerly part of ''NonDeliverableSettlement'', which is now being harmonised into a common ''CashSettlementTerms'' that includes a ''ValuationDate''.',
    fxFixingSchedule VARCHAR(255) %DESCRIPTION 'The date, when expressed as a schedule of date(s), on which the currency rate will be determined for the purpose of specifying the amount in deliverable currency. This attribute was formerly part of ''NonDeliverableSettlement'', which is now being harmonised into a common ''CashSettlementTerms'' that includes a ''ValuationDate''.'
);

CREATE TABLE cdm_event_common.BusinessEvent_after (
    BusinessEvent_id INT NOT NULL,
    TradeState_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.BusinessEvent_instruction (
    BusinessEvent_id INT NOT NULL,
    Instruction_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.BusinessEvent (
    BusinessEvent_id INT UNIQUE NOT NULL,
    eventQualifier VARCHAR(255) %DESCRIPTION 'The CDM event qualifier, which corresponds to the outcome of the isEvent qualification logic which qualifies the lifecycle event as a function of its features (e.g. PartialTermination, ClearingSubmission, Novation, ...).',
    after INT NOT NULL %DESCRIPTION 'Specifies the after trade state(s) created.',
    intent VARCHAR(255) %DESCRIPTION 'The intent attribute is meant to be specified when the event qualification cannot be programmatically inferred from the event features. As a result it is only associated with those primitives that can give way to such ambiguity, the quantityChange being one of those. An example of such is a reduction in the trade notional, which could be interpreted as either a trade correction (unless a maximum period of time post-event is specified as part of the qualification), a partial termination or a portfolio rebalancing in the case of an equity swap. On the other hand, an event such as the exercise is not expected to have an associated intent as there should not be ambiguity.',
    corporateActionIntent VARCHAR(255),
    eventDate VARCHAR(255) %DESCRIPTION 'Specifies the date on which the event is taking place. This date is equal to the trade date in the case of a simple execution.  However it can be different from the trade date, for example in the case of a partial termination.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date on which the event contractually takes effect, when different from the event date.',
    packageInformation VARCHAR(255) %DESCRIPTION 'Specifies the package information in case the business event represents several trades executed as a package (hence this attribute is optional). The package information is only instantiated once at the business event level to preserve referential integrity, whereas individual trades make reference to it to identify that they are part of a package.',
    instruction INT NOT NULL %DESCRIPTION 'Specifies the instructions to create the Business Event.'
);

CREATE TABLE cdm_base_staticdata_party.PartyIdentifier (
    PartyIdentifier_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) NOT NULL %DESCRIPTION 'Provides an identifier associated with a party. The identifier is unique within the public source specified in the source attribute.',
    identifierType VARCHAR(255) %DESCRIPTION 'Defines the source of the identifier.'
);

CREATE TABLE cdm_event_workflow.FieldWithMetaCreditLimitTypeEnum (
    FieldWithMetaCreditLimitTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_math.QuantityChangeDirectionEnum (
    QuantityChangeDirectionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.CommodityReferenceFramework (
    CommodityReferenceFramework_id INT UNIQUE NOT NULL,
    commodityName VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the commodity more specifically. Where possible, this should follow the naming convention used in the 2005 ISDA Commodity Definitions SubAnnex A, including the subCommodity and additional qualifiers, but should be limited to 256 characters or less.',
    capacityUnit VARCHAR(255) %DESCRIPTION 'Provides an enumerated value for a capacity unit, generally used in the context of defining quantities for commodities.',
    weatherUnit VARCHAR(255) %DESCRIPTION 'Provides an enumerated values for a weather unit, generally used in the context of defining quantities for commodities.',
    currency VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the currency in which the commodity is priced.'
);

CREATE TABLE cdm_base_staticdata_party.Party_partyId (
    Party_id INT NOT NULL,
    PartyIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.Party_businessUnit (
    Party_id INT NOT NULL,
    BusinessUnit_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.Party_person (
    Party_id INT NOT NULL,
    NaturalPerson_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.Party_personRole (
    Party_id INT NOT NULL,
    NaturalPersonRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.Party (
    Party_id INT UNIQUE NOT NULL,
    partyId INT NOT NULL %DESCRIPTION 'The identifier associated with a party, e.g. the 20 digits LEI code.',
    name VARCHAR(255) %DESCRIPTION 'The party name.',
    businessUnit INT NOT NULL %DESCRIPTION 'Optional organization unit information used to describe the organization units (e.g. trading desks) involved in a transaction or business process, incl. the contact information (when relevant).',
    person INT NOT NULL %DESCRIPTION 'The person(s) who might be associated with the party as part of the execution, contract or legal document.',
    personRole INT NOT NULL %DESCRIPTION 'The role of the person(s) ',
    account VARCHAR(255) %DESCRIPTION 'The account that might be associated with the party. At most one account can be specified, as it is expected that this information is used in the context of a contract or legal document where only one account per party can be associated with such object.',
    contactInformation VARCHAR(255) %DESCRIPTION 'The postal/street address, telephone number, email address and/or web page. If the contact information is specific to the associated business unit(s) or person (s), it should be associated with those.'
);

CREATE TABLE cdm_base_staticdata_asset_common.CommodityProductDefinition (
    CommodityProductDefinition_id INT UNIQUE NOT NULL,
    referenceFramework VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the type of commodity.',
    priceSource VARCHAR(255) %DESCRIPTION 'Specifies a publication that provides the commodity price, including, where applicable the details of where in the publication the price is published.  Applicable when the commodity reference price is not a futures contract',
    commodityInfoPublisher VARCHAR(255) %DESCRIPTION 'Specifies the publication where the commodity prices can be found.',
    exchangeId VARCHAR(255) NOT NULL %DESCRIPTION ' Identifies the exchange from which the reference price should be sourced, using the scheme at the following url: http://www.fpml.org/coding-scheme/external/exchange-id-MIC-1-0'
);

CREATE TABLE cdm_event_common.HaircutIndicatorEnum (
    HaircutIndicatorEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.Knock (
    Knock_id INT UNIQUE NOT NULL,
    knockIn VARCHAR(255) %DESCRIPTION 'The knock in.',
    knockOut VARCHAR(255) %DESCRIPTION 'The knock out.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementTypeEnum (
    MasterAgreementTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_regulation.Id (
    Id_id INT UNIQUE NOT NULL,
    lei VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_template.RepoDurationEnum (
    RepoDurationEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.SupraNationalIssuerTypeEnum (
    SupraNationalIssuerTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.MeasureBase (
    MeasureBase_id INT UNIQUE NOT NULL,
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_product_asset.RateTreatmentEnum (
    RateTreatmentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.SplitInstruction_breakdown (
    SplitInstruction_id INT NOT NULL,
    PrimitiveInstruction_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.SplitInstruction (
    SplitInstruction_id INT UNIQUE NOT NULL,
    breakdown INT NOT NULL %DESCRIPTION 'Each split breakdown specifies the set of primitive instructions to be applied to a single branch of that split. N split breakdowns result in N output trades, which include the original trade. Instructions for how to handle the original trade (e.g. if it must be closed) must be specified in one of the breakdowns.'
);

CREATE TABLE cdm_regulation.Prsn (
    Prsn_id INT UNIQUE NOT NULL,
    ctryOfBrnch VARCHAR(255) NOT NULL,
    othr VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_event_common.RecordAmountTypeEnum (
    RecordAmountTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.MarginTypeEnum (
    MarginTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.PrimitiveInstruction (
    PrimitiveInstruction_id INT UNIQUE NOT NULL,
    contractFormation VARCHAR(255) %DESCRIPTION 'Specifies instructions describing an contract formation primitive event.',
    execution VARCHAR(255) %DESCRIPTION 'Specifies instructions describing an execution primitive event.',
    exercise VARCHAR(255) %DESCRIPTION 'Specifies instructions describing an exercise primitive event.',
    partyChange VARCHAR(255) %DESCRIPTION 'Specifies instructions describing a party change primitive event.',
    quantityChange VARCHAR(255) %DESCRIPTION 'Specifies instructions describing an quantity change primitive event.',
    reset VARCHAR(255) %DESCRIPTION 'Specifies instructions describing a reset event.',
    split VARCHAR(255) %DESCRIPTION 'Specifies instructions to split a trade into multiple branches.',
    termsChange VARCHAR(255) %DESCRIPTION 'Specifies instructions describing a terms change primitive event.',
    transfer VARCHAR(255) %DESCRIPTION 'Specifies instructions describing a transfer primitive event.',
    indexTransition VARCHAR(255) %DESCRIPTION 'Specifies inputs needed to process a Index Transition business event.',
    stockSplit VARCHAR(255) %DESCRIPTION 'Specifies inputs needed to process a Stock Split business event.',
    observation VARCHAR(255) %DESCRIPTION 'Specifies inputs needed to process an observation.',
    valuation VARCHAR(255) %DESCRIPTION 'Specifies inputs needed to process an update of a valuation.'
);

CREATE TABLE cdm_event_common.MarginCallInstructionType (
    MarginCallInstructionType_id INT UNIQUE NOT NULL,
    callType VARCHAR(255) NOT NULL %DESCRIPTION 'Indicates the status of the call message type, such as expected call, notification of a call or an actionable margin call.',
    visibilityIndicator INT %DESCRIPTION 'Indicates the choice if the call instruction is visible or not to the other party.'
);

CREATE TABLE cdm_product_asset.SettledEntityMatrixSourceEnum (
    SettledEntityMatrixSourceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.SwapCurveValuation (
    SwapCurveValuation_id INT UNIQUE NOT NULL,
    floatingRateIndex VARCHAR(255) NOT NULL,
    indexTenor VARCHAR(255) %DESCRIPTION 'The ISDA Designated Maturity, i.e. the tenor of the floating rate.',
    spread FLOAT NOT NULL %DESCRIPTION 'Spread in basis points over the floating rate index.',
    side VARCHAR(255) %DESCRIPTION 'The side (bid/mid/ask) of the measure.'
);

CREATE TABLE cdm_product_asset_floatingrate.FloatingAmountCalculationDetails (
    FloatingAmountCalculationDetails_id INT UNIQUE NOT NULL,
    calculationPeriod VARCHAR(255) NOT NULL %DESCRIPTION 'The calculation period for which the floating calculation was performed.',
    calculationPeriodNotionalAmount VARCHAR(255) NOT NULL %DESCRIPTION 'The notional in effect during the calculation period.',
    floatingRate VARCHAR(255) %DESCRIPTION 'The details of the floating rate setting.  (If it is a calculated rate, details of that calculation will be inside that.',
    processingDetails VARCHAR(255) %DESCRIPTION 'Details fo the floating rate treatment after the rate is observed or calculated.  This will include details of things like multipliers, spreads, caps and floors, and the raw and treated rates.',
    appliedRate FLOAT NOT NULL %DESCRIPTION 'The rate that was actually applied, after all calculations and treatments.',
    yearFraction FLOAT NOT NULL %DESCRIPTION 'The fraction of a year that this calculation represents, according to the day count fraction method.',
    calculatedAmount FLOAT NOT NULL %DESCRIPTION 'The amount of the cash flow that was computed, including any spreads and other processing.',
    spreadExclusiveCalculatedAMount FLOAT NOT NULL %DESCRIPTION 'The amount of the cash flow excluding any spread, for subsequent processing.'
);

CREATE TABLE cdm_base_staticdata_asset_common.MaturityTypeEnum (
    MaturityTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.Basket_basketConstituent (
    Basket_id INT NOT NULL,
    Product_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Basket_portfolioBasketConstituent (
    Basket_id INT NOT NULL,
    BasketConstituent_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Basket_productTaxonomy (
    Basket_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Basket_productIdentifier (
    Basket_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Basket (
    Basket_id INT UNIQUE NOT NULL,
    basketConstituent INT NOT NULL %DESCRIPTION 'Identifies the constituents of the basket',
    portfolioBasketConstituent INT NOT NULL %DESCRIPTION 'Identifies the constituents of the basket',
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_product_template.CancelableProvision_finalCalculationPeriodDateAdjustment (
    CancelableProvision_id INT NOT NULL,
    FinalCalculationPeriodDateAdjustment_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.CancelableProvision (
    CancelableProvision_id INT UNIQUE NOT NULL,
    americanExercise VARCHAR(255) %DESCRIPTION 'American exercise. FpML implementations consists in an exercise substitution group.',
    bermudaExercise VARCHAR(255) %DESCRIPTION 'Bermuda exercise. FpML implementations consists in an exercise substitution group.',
    europeanExercise VARCHAR(255) %DESCRIPTION 'European exercise. FpML implementations consists in an exercise substitution group.',
    exerciseNotice VARCHAR(255) %DESCRIPTION 'Definition of the party to whom notice of exercise should be given.',
    followUpConfirmation INT NOT NULL %DESCRIPTION 'A flag to indicate whether follow-up confirmation of exercise (written or electronic) is required following telephonic notice by the buyer to the seller or seller''s agent.',
    cancelableProvisionAdjustedDates VARCHAR(255) %DESCRIPTION 'The adjusted dates associated with a cancelable provision. These dates have been adjusted for any applicable business day convention.',
    finalCalculationPeriodDateAdjustment INT NOT NULL %DESCRIPTION 'Business date convention adjustment to final payment period per leg (swapStream) upon exercise event. The adjustments can be made in-line with leg level BDC''s or they can be specified separately.',
    initialFee VARCHAR(255) %DESCRIPTION 'An initial fee for the cancelable option.',
    callingParty VARCHAR(255) %DESCRIPTION 'The party with right to exercise a cancellation. Allows for buyer, seller or either.',
    earliestDate VARCHAR(255) %DESCRIPTION 'The first day when cancelation is permitted to take effect. A party may give notice prior to this date and taken together with the effective period would be necessary to cancel on this date.',
    expirationDate VARCHAR(255) %DESCRIPTION 'The last day within the term of the contract that cancelation is allowed.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The effective date if cancelation is invoked otherwise the cancellation period defines the cancellation date.',
    effectivePeriod VARCHAR(255) %DESCRIPTION 'Effective period for cancelation when notice is given. This is the period after notice is given that cancellation becomes effecticve.',
    earliestCancellationTime VARCHAR(255) %DESCRIPTION 'The earliest time in a business day that notice of cancelation can be given.',
    latestCancelationTime VARCHAR(255) %DESCRIPTION 'The latest time at which notice of cancelation can be given.',
    buyer VARCHAR(255) %DESCRIPTION 'Buyer party that can be resolved as one of the two principal parties to the transaction. The party that buys this instrument, i.e. pays for this instrument and receives the rights defined by it. ISDA 2002 Equity Definitions section 1.18: `Buyer` means the party specified as such in the related Confirmation. | ISDA 2006 Definitions article 12.1 (b)(i) relating to a Swaption: ''Buyer'' means the party that will, on each Premium Payment Date, pay to Seller the Premium | ISDA 2006 Definitions article 12.1 (b)(ii) relating to Swap Transactions with applicable Early Termination: the party specified as such in the related Confirmation, or the Exercising Party if neither party is specified | ISDA 2006 Definitions article 12.1 (b)(iii) relating to any other Option Transaction: the party specified as such in the related Confirmation. | ISDA 2014 Credit Definition article 1.4: `Buyer` means the Fixed Rate Payer.',
    seller VARCHAR(255) %DESCRIPTION 'Seller party that can be resolved as one of the two principal parties to the transaction. The party that sells (''writes'') this instrument, i.e. that grants the rights defined by this instrument and in return receives a payment for it. ISDA 2002 Equity Definitions section 1.19: `Seller` means the party specified as such in the related Confirmation. | ISDA 2006 Definitions article 12.1 (a)(i) relating to a Swaption: ''Seller'' means the party the party specified as such or as writer in the related Confirmation | ISDA 2006 Definitions article 12.1 (a)(ii) relating to Swap Transactions with applicable Early Termination: the party specified as such or as writer in the related Confirmation or, if neither party is specified as such, the Non-exercising Party | ISDA 2006 Definitions article 12.1 (a)(iii) relating to any other Option Transaction: the party specified as such in the related Confirmation. | ISDA 2014 Credit Definition article 1.4: `Seller` means the Floating Rate Payer.'
);

CREATE TABLE cdm_product_asset.RealisedVarianceMethodEnum (
    RealisedVarianceMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_event.DeterminationMethodology (
    DeterminationMethodology_id INT UNIQUE NOT NULL,
    determinationMethod VARCHAR(255) %DESCRIPTION 'Represents a more granular dimention of observation. Typically relevent for resolving a unique equity price, which can be expressed as trade-weighted or volume-weighted averages.',
    averagingMethod VARCHAR(255) %DESCRIPTION 'Specifies enumerations for the type of averaging calculation.'
);

CREATE TABLE cdm_event_position.CounterpartyPosition_positionIdentifier (
    CounterpartyPosition_id INT NOT NULL,
    PositionIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.CounterpartyPosition_tradeReference (
    CounterpartyPosition_id INT NOT NULL,
    ReferenceWithMetaTradeState_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.CounterpartyPosition_party (
    CounterpartyPosition_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.CounterpartyPosition_partyRole (
    CounterpartyPosition_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.CounterpartyPosition (
    CounterpartyPosition_id INT UNIQUE NOT NULL,
    positionIdentifier INT NOT NULL %DESCRIPTION 'Represents the identifier(s) that uniquely identify a position for an identity issuer. A position can include multiple identifiers, for example an internal position identifer and a UTI (Unique Trade Identifier).',
    openDateTime VARCHAR(255) %DESCRIPTION 'The date and time when the position was opened.',
    tradeReference INT NOT NULL %DESCRIPTION 'Reference to all the trades that constitute the position.',
    party INT NOT NULL %DESCRIPTION 'The parties involved in the position, including the Clearing Organization.',
    partyRole INT NOT NULL %DESCRIPTION 'Represents the role each specified party takes in the position.',
    positionBase VARCHAR(255) NOT NULL %DESCRIPTION 'Encapsulates the core constituents that characterize a position.',
    contractDetails VARCHAR(255) %DESCRIPTION 'Represents information specific to trades or positions involving contractual products.',
    executionDetails VARCHAR(255) %DESCRIPTION 'Defines specific attributes that relate to trade or position executions.',
    collateral VARCHAR(255) %DESCRIPTION 'Represents the collateral obligations of a party.'
);

CREATE TABLE cdm_product_asset.ReturnTypeEnum (
    ReturnTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.ResolvablePriceQuantity_quantityCumulation (
    ResolvablePriceQuantity_id INT NOT NULL,
    CumulationFeature_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.ResolvablePriceQuantity_priceSchedule (
    ResolvablePriceQuantity_id INT NOT NULL,
    ReferenceWithMetaPriceSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.ResolvablePriceQuantity (
    ResolvablePriceQuantity_id INT UNIQUE NOT NULL,
    quantityCumulation INT NOT NULL %DESCRIPTION 'Describe provisions which define how the quantity is incremented over time.',
    resolvedQuantity VARCHAR(255) %DESCRIPTION 'A product''s quantity as a single, non-negative amount.  When specified as part of a product definition, this quantity attribute would not be set.  Instead it is specified on the quantity notation along with an asset identifier matching this payout''s asset identifier.  This allows the quantity to be resolved for a payout leg, which can then be specified here for convenience during data processing.  There needs to be at least one resolvable quantity across payout legs of a product to define an anchor that other payout quantities can refer to.  This attribute is ignored when mapping existing FpML messages.',
    quantitySchedule VARCHAR(255) %DESCRIPTION 'A payout''s quantity specified as a schedule, which may also contain a single value if that quantity is constant. There can only be a single quantity schedule applicable to a payout: e.g. the notional for an interest rate leg. The quantity must be specified outside of the payout in a PriceQuantity object and only referenced inside the payout using an address.',
    quantityReference VARCHAR(255) %DESCRIPTION 'Reference quantity when resolvable quantity is defined as relative to another (resolvable) quantity. A resolvable quantity needs to contain either an absolute quantity or a reference to another (resolvable) quantity. This requirement is captured by a choice rule on the class.',
    quantityMultiplier VARCHAR(255) %DESCRIPTION 'Quantity multiplier is specified on top of a reference quantity and is used as a multiplying factor when resolving the quantity. A quantity multiplier can only exist when the resolvable quantity specifies a reference quantity.',
    reset INT %DESCRIPTION 'Whether the quantity is resettable',
    futureValueNotional VARCHAR(255) %DESCRIPTION 'The future value notional is specific to BRL CDI swaps, and is specified alongside the notional amount. The value is calculated as follows: Future Value Notional = Notional Amount * (1 + Fixed Rate) ^ (Fixed Rate Day Count Fraction). The currency should always match that expressed in the notional schedule. The value date should match the adjusted termination date.',
    priceSchedule INT NOT NULL %DESCRIPTION 'A payout''s price specified as a schedule, which may also contain a single value if that price is constant. There may be multiple prices specified for a single payout: e.g. a floating interest rate leg may specify a spread, a cap and/or floor and a multiplier. The price must be specified outside of the payout in a PriceQuantity object and only referenced inside the payout using an address.'
);

CREATE TABLE cdm_base_datetime.CustomisableOffset (
    CustomisableOffset_id INT UNIQUE NOT NULL,
    offset VARCHAR(255),
    customProvision VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.ProductIdentifier (
    ProductIdentifier_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) NOT NULL %DESCRIPTION 'Provides an identifier associated with a specific product.  The identifier is unique within the public source specified in the source attribute.',
    source VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the source of the identifier.'
);

CREATE TABLE cdm_event_common.BillingSummaryInstruction (
    BillingSummaryInstruction_id INT UNIQUE NOT NULL,
    summaryAmountType VARCHAR(255) NOT NULL %DESCRIPTION 'The account level for the billing summary.'
);

CREATE TABLE cdm_event_common.PriceTimingEnum (
    PriceTimingEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.CurrencyCodeEnum (
    CurrencyCodeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.MandatoryEarlyTermination (
    MandatoryEarlyTermination_id INT UNIQUE NOT NULL,
    mandatoryEarlyTerminationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The early termination date associated with a mandatory early termination of a swap.',
    calculationAgent VARCHAR(255) NOT NULL %DESCRIPTION 'The ISDA Calculation Agent responsible for performing duties associated with an optional early termination.',
    cashSettlement VARCHAR(255) NOT NULL %DESCRIPTION 'If specified, this means that cash settlement is applicable to the transaction and defines the parameters associated with the cash settlement procedure. If not specified, then physical settlement is applicable.',
    mandatoryEarlyTerminationAdjustedDates VARCHAR(255) %DESCRIPTION 'The adjusted dates associated with a mandatory early termination provision. These dates have been adjusted for any applicable business day convention.'
);

CREATE TABLE cdm_base_staticdata_party.ReferenceBanks_referenceBank (
    ReferenceBanks_id INT NOT NULL,
    ReferenceBank_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.ReferenceBanks (
    ReferenceBanks_id INT UNIQUE NOT NULL,
    referenceBank INT NOT NULL %DESCRIPTION 'An institution (party) identified by means of a coding scheme and an optional name.'
);

CREATE TABLE com_rosetta_model_metafields.MetaFields_key (
    MetaFields_id INT NOT NULL,
    Key_id INT UNIQUE NOT NULL
);

CREATE TABLE com_rosetta_model_metafields.MetaFields (
    MetaFields_id INT UNIQUE NOT NULL,
    scheme VARCHAR(255),
    globalKey VARCHAR(255),
    externalKey VARCHAR(255),
    key INT NOT NULL
);

CREATE TABLE cdm_product_template.ExtendibleProvision (
    ExtendibleProvision_id INT UNIQUE NOT NULL,
    americanExercise VARCHAR(255) %DESCRIPTION 'American exercise. FpML implementations consists in an exercise substitution group.',
    bermudaExercise VARCHAR(255) %DESCRIPTION 'Bermuda exercise. FpML implementations consists in an exercise substitution group.',
    europeanExercise VARCHAR(255) %DESCRIPTION 'European exercise. FpML implementations consists in an exercise substitution group.',
    exerciseNotice VARCHAR(255) %DESCRIPTION 'Definition of the party to whom notice of exercise should be given.',
    followUpConfirmation INT %DESCRIPTION 'A flag to indicate whether follow-up confirmation of exercise (written or electronic) is required following telephonic notice by the buyer to the seller or seller''s agent.',
    extendibleProvisionAdjustedDates VARCHAR(255) %DESCRIPTION 'The adjusted dates associated with an extendible provision. These dates have been adjusted for any applicable business day convention.',
    callingParty VARCHAR(255),
    singlePartyOption VARCHAR(255) %DESCRIPTION 'If the ability to extend the contract is not available to both parties then this component specifies the buyer and seller of the option.',
    noticeDeadlinePeriod VARCHAR(255) %DESCRIPTION 'Defines the minimum period before a contract is scheduled to terminate that notice can be given that it will terminate beyond the scheduled termination date.',
    noticeDeadlineDateTime VARCHAR(255) %DESCRIPTION 'A specific date and time for the notice deadline',
    extensionTerm VARCHAR(255) %DESCRIPTION 'The length of each extension period relative to the effective date of the preceding contract.',
    extensionPeriod VARCHAR(255) %DESCRIPTION 'The period within which notice can be given that the contract will be extended.',
    buyer VARCHAR(255) %DESCRIPTION 'Buyer party that can be resolved as one of the two principal parties to the transaction. The party that buys this instrument, i.e. pays for this instrument and receives the rights defined by it. ISDA 2002 Equity Definitions section 1.18: `Buyer` means the party specified as such in the related Confirmation. | ISDA 2006 Definitions article 12.1 (b)(i) relating to a Swaption: ''Buyer'' means the party that will, on each Premium Payment Date, pay to Seller the Premium | ISDA 2006 Definitions article 12.1 (b)(ii) relating to Swap Transactions with applicable Early Termination: the party specified as such in the related Confirmation, or the Exercising Party if neither party is specified | ISDA 2006 Definitions article 12.1 (b)(iii) relating to any other Option Transaction: the party specified as such in the related Confirmation. | ISDA 2014 Credit Definition article 1.4: `Buyer` means the Fixed Rate Payer.',
    seller VARCHAR(255) %DESCRIPTION 'Seller party that can be resolved as one of the two principal parties to the transaction. The party that sells (''writes'') this instrument, i.e. that grants the rights defined by this instrument and in return receives a payment for it. ISDA 2002 Equity Definitions section 1.19: `Seller` means the party specified as such in the related Confirmation. | ISDA 2006 Definitions article 12.1 (a)(i) relating to a Swaption: ''Seller'' means the party the party specified as such or as writer in the related Confirmation | ISDA 2006 Definitions article 12.1 (a)(ii) relating to Swap Transactions with applicable Early Termination: the party specified as such or as writer in the related Confirmation or, if neither party is specified as such, the Non-exercising Party | ISDA 2006 Definitions article 12.1 (a)(iii) relating to any other Option Transaction: the party specified as such in the related Confirmation. | ISDA 2014 Credit Definition article 1.4: `Seller` means the Floating Rate Payer.'
);

CREATE TABLE cdm_base_staticdata_party.TelephoneTypeEnum (
    TelephoneTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset_metafields.ReferenceWithMetaCreditDefaultPayout (
    ReferenceWithMetaCreditDefaultPayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_asset.CorrelationReturnTerms (
    CorrelationReturnTerms_id INT UNIQUE NOT NULL,
    correlationStrikePrice VARCHAR(255) NOT NULL %DESCRIPTION 'Correlation Strike Price in accordance with the ISDA 2011 Equity Derivatives Definitions.',
    boundedCorrelation VARCHAR(255) %DESCRIPTION 'Describes correlation bounds, which form a cap and a floor on the realized correlation.',
    numberOfDataSeries INT %DESCRIPTION 'Number of data series, normal market practice is that correlation data sets are drawn from geographic market areas, such as America, Europe and Asia Pacific, each of these geographic areas will have its own data series to avoid contagion.',
    valuationTerms VARCHAR(255) %DESCRIPTION 'Contains all non-date valuation information.',
    annualizationFactor INT %DESCRIPTION 'This specifies the numerator of an annualization factor. Frequently this number is equal to the number of observations of prices in a year e.g. 252.',
    dividendApplicability VARCHAR(255) %DESCRIPTION 'The parameters which define whether dividends are applicable',
    equityUnderlierProvisions VARCHAR(255) %DESCRIPTION 'Contains Equity underlier provisions regarding jurisdiction and fallbacks.',
    sharePriceDividendAdjustment INT %DESCRIPTION 'Indicates whether the price of shares is adjusted for dividends or not.',
    expectedN INT %DESCRIPTION 'Expected number of trading days.',
    initialLevel FLOAT %DESCRIPTION 'Contract will strike off this initial level. Providing just the initialLevel without initialLevelSource, infers that this is AgreedInitialPrice - a specified Initial Index Level.',
    initialLevelSource VARCHAR(255) %DESCRIPTION 'In this context, this is AgreedInitialPrice - a specified Initial Index Level.',
    meanAdjustment INT %DESCRIPTION 'Specifies whether Mean Adjustment is applicable or not in the calculation of the Realized Volatility, Variance or Correlation',
    performance VARCHAR(255) %DESCRIPTION 'Performance calculation, in accordance with Part 1 Section 12 of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap, Para 75. ''Equity Performance''. Cumulative performance is used as a notional multiplier factor on both legs of an Equity Swap.'
);

CREATE TABLE cdm_event_common.BillingRecordInstruction_observation (
    BillingRecordInstruction_id INT NOT NULL,
    Observation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.BillingRecordInstruction (
    BillingRecordInstruction_id INT UNIQUE NOT NULL,
    tradeState VARCHAR(255) NOT NULL %DESCRIPTION 'The trade for the individual billing record.',
    observation INT NOT NULL %DESCRIPTION 'The observations used to calculate the billing amount.',
    recordStartDate VARCHAR(255) NOT NULL %DESCRIPTION 'The starting date of the period described by this record',
    recordEndDate VARCHAR(255) NOT NULL %DESCRIPTION 'The ending date of the period described by this record',
    settlementDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date for settlement of the transfer.'
);

CREATE TABLE cdm_base_datetime_metafields.ReferenceWithMetaAdjustableOrRelativeDate (
    ReferenceWithMetaAdjustableOrRelativeDate_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_math.MoneyRange (
    MoneyRange_id INT UNIQUE NOT NULL,
    lowerBound VARCHAR(255) %DESCRIPTION 'The lower bound of a money range, e.g. greater than or equal to 1,000 USD.',
    upperBound VARCHAR(255) %DESCRIPTION 'The upper bound of a money range, e.g. less than 10,000 USD.'
);

CREATE TABLE cdm_observable_asset.FxRate (
    FxRate_id INT UNIQUE NOT NULL,
    quotedCurrencyPair VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the two currencies for an FX trade and the quotation relationship between the two currencies.',
    rate FLOAT %DESCRIPTION 'The rate of exchange between the two currencies of the leg of a deal. Must be specified with a quote basis.'
);

CREATE TABLE cdm_product_common_settlement.SettlementProvision (
    SettlementProvision_id INT UNIQUE NOT NULL,
    shapingProvisions VARCHAR(255) %DESCRIPTION 'Defines the parameters that are necessary to ''shape'' a settlement, i.e. break it down into smaller amounts.'
);

CREATE TABLE cdm_event_common.Valuation (
    Valuation_id INT UNIQUE NOT NULL,
    amount VARCHAR(255) NOT NULL %DESCRIPTION 'Current value of the outstanding contract',
    timestamp VARCHAR(255) NOT NULL %DESCRIPTION 'Date and time of the last valuation marked to market, provided by the central counterparty (CCP) or calculated using the current or last available market price of the inputs.',
    method VARCHAR(255) %DESCRIPTION 'Method used for the valuation of the transaction by the valuation party.',
    source VARCHAR(255) %DESCRIPTION 'Source of the valuation of the transaction by the valuation party.',
    delta FLOAT %DESCRIPTION 'The ratio of the change in the price of a derivative transaction to the change in the price of the underlying. This field is applicable only to options and swaptions.',
    valuationTiming VARCHAR(255) %DESCRIPTION 'Denotes when the valuation was sourced during a business day.',
    priceComponent VARCHAR(255) %DESCRIPTION 'Denotes the price used to compute the valuation.'
);

CREATE TABLE cdm_product_common_schedule.AveragingObservationList_averagingObservation (
    AveragingObservationList_id INT NOT NULL,
    WeightedAveragingObservation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.AveragingObservationList (
    AveragingObservationList_id INT UNIQUE NOT NULL,
    averagingObservation INT NOT NULL %DESCRIPTION 'A single weighted averaging observation.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculationShiftMethodEnum (
    CalculationShiftMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.FinancialUnitEnum (
    FinancialUnitEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.MeasureSchedule_datedValue (
    MeasureSchedule_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.MeasureSchedule (
    MeasureSchedule_id INT UNIQUE NOT NULL,
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_product_common_schedule.ObservationDates (
    ObservationDates_id INT UNIQUE NOT NULL,
    observationSchedule VARCHAR(255) %DESCRIPTION 'Specifies a schedule of dates (non-parametric) on which market observations take place, and allows for the optional definition of weights where applicable.  When no weight is specified, then weight of each date is assumed to be 1.0',
    periodicSchedule VARCHAR(255) %DESCRIPTION 'Specifies the date range and frequency on which market observations take place.  Weights can be assigned to dates in the schedule by assigning the weight and corresponding observationReference in the observationSchedule.',
    parametricDates VARCHAR(255) %DESCRIPTION 'Specifies parametric terms to determine which days within a given calculation period the price would be observed. Typically associated with Commodities. '
);

CREATE TABLE cdm_product_template.CalculationAgentModel (
    CalculationAgentModel_id INT UNIQUE NOT NULL,
    calculationAgent VARCHAR(255) %DESCRIPTION 'The ISDA calculation agent responsible for performing duties as defined in the applicable product definitions.',
    calculationAgentBusinessCenter VARCHAR(255) %DESCRIPTION 'The city in which the office through which ISDA Calculation Agent is acting for purposes of the transaction is located. The short-form confirm for a trade that is executed under a Sovereign or Asia-Pacific Master Confirmation Agreement (MCA), does not need to specify the Calculation Agent. However, the confirm does need to specify the Calculation Agent city. This is due to the fact that the MCA sets the value for Calculation Agent but does not set the value for Calculation Agent city.'
);

CREATE TABLE cdm_product_template.AveragingInOutEnum (
    AveragingInOutEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template_metafields.ReferenceWithMetaPayout (
    ReferenceWithMetaPayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_template.ExerciseProcedure (
    ExerciseProcedure_id INT UNIQUE NOT NULL,
    manualExercise VARCHAR(255) %DESCRIPTION 'Specifies that the notice of exercise must be given by the buyer to the seller or seller''s agent.',
    automaticExercise VARCHAR(255) %DESCRIPTION 'If automatic is specified, then the notional amount of the underlying swap not previously exercised under the swaption will be automatically exercised at the expiration time on the expiration date if at such time the buyer is in-the-money, provided that the difference between the settlement rate and the fixed rate under the relevant underlying swap is not less than the specified threshold rate. The term in-the-money is assumed to have the meaning defining in the 2000 ISDA Definitions, Section 17.4 In-the-money.',
    followUpConfirmation INT NOT NULL %DESCRIPTION 'A flag to indicate whether follow-up confirmation of exercise (written or electronic) is required following telephonic notice by the buyer to the seller or seller''s agent.',
    limitedRightToConfirm INT %DESCRIPTION 'Has the meaning defined as part of the 1997 ISDA Government Bond Option Definitions, section 4.5 Limited Right to Confirm Exercise. If present, (i) the Seller may request the Buyer to confirm its intent if not done on or before the expiration time on the Expiration date (ii) specific rules will apply in relation to the settlement mode.',
    splitTicket INT %DESCRIPTION 'Typically applicable to the physical settlement of bond and convertible bond options. If present, means that the party required to deliver the bonds will divide those to be delivered as notifying party desires to facilitate delivery obligations.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClause_counterparty (
    MasterAgreementClause_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClause_otherParty (
    MasterAgreementClause_id INT NOT NULL,
    PartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClause_variant (
    MasterAgreementClause_id INT NOT NULL,
    MasterAgreementClauseVariant_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClause (
    MasterAgreementClause_id INT UNIQUE NOT NULL,
    identifer VARCHAR(255) NOT NULL %DESCRIPTION 'Unique identifier for the clause',
    name VARCHAR(255) %DESCRIPTION 'Optional textual description of the clause.',
    counterparty INT NOT NULL %DESCRIPTION 'Optional counterparty role. This can be used where a clause needs to be assigned to a specific party on the agreement based upon their role i.e. Party A or Party B.',
    otherParty INT NOT NULL %DESCRIPTION 'Optional party. This can be required for umbrella agreements where a clause may need to be assigned to a specific party who may or may not be on the agreement.',
    variant INT NOT NULL %DESCRIPTION 'Allows multiple variants to be defined for a clause. This needs to be an array as some clauses can specify different variants for different parties. At least one variant must be specified for a clause.'
);

CREATE TABLE cdm_base_math.NonNegativeQuantity_datedValue (
    NonNegativeQuantity_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.NonNegativeQuantity (
    NonNegativeQuantity_id INT UNIQUE NOT NULL,
    multiplier VARCHAR(255) %DESCRIPTION 'Defines an optional number that the quantity should be multiplied by to derive a total quantity. This number is associated to a unit. For example in the case of the Coal (API2) CIF ARA (ARGUS-McCloskey) Futures Contract on the CME, where the unit would be contracts, the multiplier value would 1,000 and the mulitiplier unit would be 1,000 MT (Metric Tons).',
    frequency VARCHAR(255) %DESCRIPTION 'Defines the frequency to be used when defining a quantity. For example a quantity may be specified as a number of barrels of oil per day, which needs multiplying by the number of days in the relevant period to get the total quantity as a number of barrels.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_legaldocumentation_master.FieldWithMetaMasterConfirmationAnnexTypeEnum (
    FieldWithMetaMasterConfirmationAnnexTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.CreditRiskEnum (
    CreditRiskEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.PeriodEnum (
    PeriodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_credit.SpecifiedCurrency (
    SpecifiedCurrency_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the specified currency provision is applicable.',
    currency VARCHAR(255) %DESCRIPTION 'The currency in which the specified currency is denominated. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.'
);

CREATE TABLE cdm_product_template.Barrier (
    Barrier_id INT UNIQUE NOT NULL,
    barrierCap VARCHAR(255) %DESCRIPTION 'A trigger level approached from beneath.',
    barrierFloor VARCHAR(255) %DESCRIPTION 'A trigger level approached from above.'
);

CREATE TABLE cdm_product_template.OptionExercise (
    OptionExercise_id INT UNIQUE NOT NULL,
    optionStyle VARCHAR(255) NOT NULL %DESCRIPTION 'The option exercise can be of American style, Bermuda style or European style. The FpML implementation makes use of a substitution group.',
    strike VARCHAR(255) %DESCRIPTION 'Specifies the strike of the option on credit default swap.',
    exerciseProcedure VARCHAR(255) %DESCRIPTION 'The set of parameters defining the procedure associated with the exercise, e.g. manual exercise.'
);

CREATE TABLE cdm_observable_event.FailureToPay (
    FailureToPay_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the failure to pay provision is applicable.',
    gracePeriodExtension VARCHAR(255) %DESCRIPTION 'If this element is specified, indicates whether or not a grace period extension is applicable. ISDA 2003 Term: Grace Period Extension Applicable.',
    paymentRequirement VARCHAR(255) %DESCRIPTION 'Specifies a threshold for the failure to pay credit event. Market standard is USD 1,000,000 (JPY 100,000,000 for Japanese Yen trades) or its equivalent in the relevant obligation currency. This is applied on an aggregate basis across all Obligations of the Reference Entity. Intended to prevent technical/operational errors from triggering credit events. ISDA 2003 Term: Payment Requirement'
);

CREATE TABLE cdm_base_staticdata_asset_common.Commodity_productTaxonomy (
    Commodity_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Commodity_productIdentifier (
    Commodity_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Commodity (
    Commodity_id INT UNIQUE NOT NULL,
    commodityProductDefinition VARCHAR(255) %DESCRIPTION 'Specifies the commodity underlier in the event that no ISDA Commodity Reference Benchmark exists.',
    priceQuoteType VARCHAR(255) NOT NULL %DESCRIPTION 'Describes the required quote type of the underlying price that will be observed. Example values include ''Bid, ''Ask'', ''Settlement'' (for a futures contract) and ''WeightedAverage'' (for some published prices and indices).',
    deliveryDateReference VARCHAR(255) %DESCRIPTION 'Specifies the parameters for identifying the relevant contract date when the commodity reference price is a futures contract.',
    description VARCHAR(255) %DESCRIPTION 'Provides additional information about the commodity underlier.',
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_observable_asset.CalculationAgent (
    CalculationAgent_id INT UNIQUE NOT NULL,
    calculationAgentParty VARCHAR(255) %DESCRIPTION 'Specifies the party which is the ISDA Calculation Agent for the trade. If more than one party is referenced then the parties are assumed to be co-calculation agents, i.e. they have joint responsibility.',
    calculationAgentPartyEnum VARCHAR(255) %DESCRIPTION 'Specifies the ISDA calculation agent responsible for performing duties as defined in the applicable product definitions. For example, the Calculation Agent may be defined as being the Non-exercising Party.',
    calculationAgentBusinessCenter VARCHAR(255) %DESCRIPTION 'The city in which the office through which ISDA Calculation Agent is acting for purposes of the transaction is located The short-form confirm for a trade that is executed under a Sovereign or Asia Pacific Master Confirmation Agreement ( MCA ), does not need to specify the Calculation Agent. However, the confirm does need to specify the Calculation Agent City. This is due to the fact that the MCA sets the value for Calculation Agent but does not set the value for Calculation Agent City.'
);

CREATE TABLE cdm_base_staticdata_asset_rates.FieldWithMetaFloatingRateIndexEnum (
    FieldWithMetaFloatingRateIndexEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_master.UnderlierSubstitutionProvision_whoMaySubstitute (
    UnderlierSubstitutionProvision_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.UnderlierSubstitutionProvision_substitutionBeSpokeTerms (
    UnderlierSubstitutionProvision_id INT NOT NULL,
    Clause_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.UnderlierSubstitutionProvision_substitutionTriggerEvents (
    UnderlierSubstitutionProvision_id INT NOT NULL,
    ExtraordinaryEvents_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.UnderlierSubstitutionProvision (
    UnderlierSubstitutionProvision_id INT UNIQUE NOT NULL,
    whoMaySubstitute INT NOT NULL %DESCRIPTION 'Designates which Counterparty to the transaction who has the right to trigger a substitution or to provide related determination e.g. for instance to qualify the effectiveness of an Event which may be a trigger for substitution, determine the replacement Share to substitute, etc. ; cardinality of this object is 2, in case parties jointly have this role.',
    substitutionBeSpokeTerms INT NOT NULL %DESCRIPTION 'Where parties describe any substitution terms e.g. for instance the election criteria for an Asset to be eligible as the Substitute Asset to the prior Affected Asset in terms of sector of activity, currency, market capitalisation, liquidity, volatility, or any additional features that parties would agree to take into considerations, etc.',
    substitutionTriggerEvents INT NOT NULL %DESCRIPTION 'Where the parties may optionnally explictly specify the list of Events to be considered as a trigger for a Substitution.',
    disputingParty VARCHAR(255) %DESCRIPTION 'Where the party who is not granted with the substitution role at least has a right to dispute the determination given by the counterparty with such role. As an example, a given PartyA is the unique Counterparty with the Role of WhoMaySubstitute, yet PartyB could be Disputing Party in regard of such Role.'
);

CREATE TABLE cdm_observable_asset.CleanPrice (
    CleanPrice_id INT UNIQUE NOT NULL,
    cleanPrice FLOAT NOT NULL %DESCRIPTION 'The clean price as a number.',
    accruals FLOAT %DESCRIPTION 'The accruals as a number.',
    dirtyPrice VARCHAR(255) %DESCRIPTION 'Placeholder for a calculation of dirtyPrice based on cleanPrice and accruals.'
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecification_identifier (
    EligibleCollateralSpecification_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecification_party (
    EligibleCollateralSpecification_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecification_counterparty (
    EligibleCollateralSpecification_id INT NOT NULL,
    Counterparty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecification_criteria (
    EligibleCollateralSpecification_id INT NOT NULL,
    EligibleCollateralCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecification (
    EligibleCollateralSpecification_id INT UNIQUE NOT NULL,
    identifier INT NOT NULL %DESCRIPTION 'Specifies the identifier(s) to uniquely identify eligible collateral or a set of eligible collateral, such as a schedule or equivalant for an identity issuer.',
    party INT NOT NULL %DESCRIPTION 'The parties associated with the specification.',
    counterparty INT NOT NULL %DESCRIPTION 'Specification of the roles of the counterparties to the specification.',
    criteria INT NOT NULL %DESCRIPTION 'Represents a set of criteria used to specify eligible collateral.'
);

CREATE TABLE cdm_base_datetime.PeriodRange (
    PeriodRange_id INT UNIQUE NOT NULL,
    lowerBound VARCHAR(255) %DESCRIPTION 'Specifies the lower bound of a period range, e.g. greater than or equal to 5Y.',
    upperBound VARCHAR(255) %DESCRIPTION 'Specifies the upper bound of a period range, e.g. less than to 10Y.'
);

CREATE TABLE cdm_observable_common.DeterminationMethodEnum (
    DeterminationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.DateTimeList_dateTime (
    DateTimeList_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.DateTimeList (
    DateTimeList_id INT UNIQUE NOT NULL,
    dateTime INT NOT NULL %DESCRIPTION 'The CDM specifies that the zoned date time is to be expressed in accordance with ISO 8601, either as UTC as an offset to UTC.'
);

CREATE TABLE cdm_event_common.CollateralStatusEnum (
    CollateralStatusEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_regulation.UndrlygInstrm (
    UndrlygInstrm_id INT UNIQUE NOT NULL,
    swp VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_event_workflow.EventInstruction_instruction (
    EventInstruction_id INT NOT NULL,
    Instruction_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.EventInstruction (
    EventInstruction_id INT UNIQUE NOT NULL,
    intent VARCHAR(255) %DESCRIPTION 'The intent attribute is meant to be specified when the event qualification cannot be programmatically inferred from the event features. As a result it is only associated with those primitives that can give way to such ambiguity, the quantityChange being one of those. An example of such is a reduction in the trade notional, which could be interpreted as either a trade correction (unless a maximum period of time post-event is specified as part of the qualification), a partial termination or a portfolio rebalancing in the case of an equity swap. On the other hand, an event such as the exercise is not expected to have an associated intent as there should not be ambiguity.',
    corporateActionIntent VARCHAR(255),
    eventDate VARCHAR(255) %DESCRIPTION 'Specifies the date on which the event is taking place. This date is equal to the trade date in the case of a simple execution.  However it can be different from the trade date, for example in the case of a partial termination.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date on which the event contractually takes effect, when different from the event date.',
    packageInformation VARCHAR(255) %DESCRIPTION 'Specifies the package information in case the business event represents several trades executed as a package (hence this attribute is optional). The package information is only instantiated once at the business event level to preserve referential integrity, whereas individual trades make reference to it to identify that they are part of a package.',
    instruction INT NOT NULL %DESCRIPTION 'Specifies the instructions to create the Business Event.'
);

CREATE TABLE cdm_product_collateral.ConcentrationLimitTypeEnum (
    ConcentrationLimitTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.ReferencePool_referencePoolItem (
    ReferencePool_id INT NOT NULL,
    ReferencePoolItem_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.ReferencePool (
    ReferencePool_id INT UNIQUE NOT NULL,
    referencePoolItem INT NOT NULL %DESCRIPTION 'This type contains all the constituent weight and reference information.'
);

CREATE TABLE cdm_observable_asset.ValuationMethod (
    ValuationMethod_id INT UNIQUE NOT NULL,
    valuationSource VARCHAR(255) NOT NULL %DESCRIPTION 'The source for obtaining a valuation. This may come from some information source (e.g. Reuters), from a rate option fixing (e.g. FX fixing for cross-currency settlement), or from a set of reference banks. This is a mandatory attribute as the valuation method relies on one of those sources to be specified.',
    quotationMethod VARCHAR(255) %DESCRIPTION 'The type of price quotations to be requested from dealers when determining the market value of the reference obligation for purposes of cash settlement, or which rate quote is to be observed for a fixing. For example, Bid, Offer, Mid-market or Exercising Party Pays. ISDA 2003 Term: Quotation Method. The meaning of Exercising Party Pays is defined in the 2000 ISDA Definitions, Section 17.2. Certain Definitions Relating to Cash Settlement, paragraph (j).',
    valuationMethod VARCHAR(255) %DESCRIPTION 'The ISDA defined methodology for determining the final price of the reference obligation for purposes of cash settlement. (ISDA 2003 Term: Valuation Method). For example, Market, Highest etc.',
    quotationAmount VARCHAR(255) %DESCRIPTION 'In the determination of a cash settlement amount, if weighted average quotations are to be obtained, the quotation amount specifies an upper limit to the outstanding principal balance of the reference obligation for which the quote should be obtained. If not specified, the ISDA definitions provide for a fallback amount equal to the floating rate payer calculation amount. ISDA 2003 Term: Quotation Amount.',
    minimumQuotationAmount VARCHAR(255) %DESCRIPTION 'In the determination of a cash settlement amount, if weighted average quotations are to be obtained, the minimum quotation amount specifies a minimum intended threshold amount of outstanding principal balance of the reference obligation for which the quote should be obtained. If not specified, the ISDA definitions provide for a fallback amount of the lower of either USD 1,000,000 (or its equivalent in the relevant obligation currency) or the quotation amount. ISDA 2003 Term: Minimum Quotation Amount.',
    cashCollateralValuationMethod VARCHAR(255) %DESCRIPTION 'Specifies the parameters representing several mid-market valuation and replacement value methods.'
);

CREATE TABLE cdm_product_asset.InterestShortfallCapEnum (
    InterestShortfallCapEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_csa.CreditSupportAgreementElections (
    CreditSupportAgreementElections_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime_daycount.FieldWithMetaDayCountFractionEnum (
    FieldWithMetaDayCountFractionEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_party.AccountTypeEnum (
    AccountTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.InterpolationMethodEnum (
    InterpolationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_collateral.CollateralInterestCalculationParameters_compoundingBusinessCenter (
    CollateralInterestCalculationParameters_id INT NOT NULL,
    BusinessCenterEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralInterestCalculationParameters (
    CollateralInterestCalculationParameters_id INT UNIQUE NOT NULL,
    fixedRate FLOAT %DESCRIPTION 'Specifies the applicable fixed rate  if used.',
    floatingRate VARCHAR(255) %DESCRIPTION 'Specifies the floating interest rate to be used.',
    inBaseCurrency INT NOT NULL %DESCRIPTION 'If True, specifies that the interest transfers should be converted to base currency equivalent, or if False specifies that the transfer should be in the currency of the collateral.',
    compoundingType VARCHAR(255) %DESCRIPTION 'Specifies the type of compounding to be applied (None, Business, Calendar).',
    compoundingBusinessCenter INT NOT NULL %DESCRIPTION 'Specifies the applicable business centers for compounding.',
    dayCountFraction VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the day count fraction to use for that currency.',
    rounding VARCHAR(255) %DESCRIPTION 'Specifies the rounding rules for settling in that currency.',
    roundingFrequency VARCHAR(255) %DESCRIPTION 'Specifies when/how often is rounding applied?',
    withholdingTaxRate FLOAT %DESCRIPTION 'Specifies the withholding tax rate if a withholding tax is applicable.'
);

CREATE TABLE cdm_product_asset.CalculationScheduleDeliveryPeriods_profile (
    CalculationScheduleDeliveryPeriods_id INT NOT NULL,
    AssetDeliveryProfile_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.CalculationScheduleDeliveryPeriods (
    CalculationScheduleDeliveryPeriods_id INT UNIQUE NOT NULL,
    deliveryCapacity VARCHAR(255) %DESCRIPTION 'The number of units included in the transaction for each delivery interval',
    priceTimeIntervalQuantity VARCHAR(255) %DESCRIPTION 'Price per quantity per delivery time interval.',
    profile INT NOT NULL %DESCRIPTION 'Defines the delivery profile of the asset, including the load type and the delivery intervals.',
    startDate VARCHAR(255) %DESCRIPTION 'Delivery start date',
    endDate VARCHAR(255) %DESCRIPTION 'Delivery end date'
);

CREATE TABLE cdm_product_common_settlement.PrincipalPayment (
    PrincipalPayment_id INT UNIQUE NOT NULL,
    principalPaymentDate VARCHAR(255) %DESCRIPTION 'The date where the PrincipalPayment shall be settled.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Specifies the parties responsible for making and receiving payments defined by this structure.',
    principalAmount VARCHAR(255) %DESCRIPTION 'When known at the time the transaction is made, the cash amount to be paid.',
    discountFactor FLOAT %DESCRIPTION 'The value representing the discount factor used to calculate the present value of the principal payment amount.',
    presentValuePrincipalAmount VARCHAR(255) %DESCRIPTION 'The amount representing the present value of the principal payment.'
);

CREATE TABLE cdm_product_template.CalendarSpread (
    CalendarSpread_id INT UNIQUE NOT NULL,
    expirationDateTwo VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_observable_asset.FxSettlementRateSource (
    FxSettlementRateSource_id INT UNIQUE NOT NULL,
    settlementRateOption VARCHAR(255) %DESCRIPTION 'Indicates that an officially defined rate settlement rate option will be the used for the fixing.',
    nonstandardSettlementRate VARCHAR(255) %DESCRIPTION 'Indicates that a non-standard rate source will be used for the fixing.'
);

CREATE TABLE cdm_product_common_settlement.RollFeature (
    RollFeature_id INT UNIQUE NOT NULL,
    rollSourceCalendar VARCHAR(255) %DESCRIPTION 'Used in conjunction with an exchange-based pricing source. Identifies a date source calendar from which the pricing dates and thus roll to the next contract will be based off (e.g. pricing is based on the NYMEX WTI First Nearby Futures Contract, if Future is chosen, the pricing will roll to the next futures contract on expiration, if ListedOption is chosen, the pricing will roll to the next futures contract on the Option expiration date which is three business days before the expiration of the NYMEX WTI futures contract.) Omitting this element will result in the default behavior expected with the pricing source described within the commodity element.',
    deliveryDateRollConvention VARCHAR(255) %DESCRIPTION 'Specifies, for a Commodity Transaction that references a delivery date for a listed future, the day on which the specified future will roll to the next nearby month prior to the expiration of the referenced future. If the future will not roll at all - i.e. the price will be taken from the expiring contract, 0 should be specified here. If the future will roll to the next nearby on the last trading day - i.e. the price will be taken from the next nearby on the last trading day, then 1 should be specified and so on.'
);

CREATE TABLE cdm_legaldocumentation_master.EquitySwapMasterConfirmation2018 (
    EquitySwapMasterConfirmation2018_id INT UNIQUE NOT NULL,
    typeOfSwapElection VARCHAR(255) NOT NULL %DESCRIPTION 'Per Part 1 Section 4, ''Dividend Obligations'', of the 2018 ISDA CDM Equity Confirmation, Para 4.2 ''Dividend Returns''',
    pricingMethodElection VARCHAR(255) NOT NULL %DESCRIPTION 'Per Part 1 Section 5, ''Pricing'', of the 2018 ISDA CDM Equity Confirmation, Para 5.1',
    linearInterpolationElection VARCHAR(255) NOT NULL %DESCRIPTION 'Per Part 1 Section 3, ''Floating Obligations'', of the 2018 ISDA CDM Equity Confirmation. Para 3.3',
    settlementTerms VARCHAR(255) NOT NULL %DESCRIPTION 'Per Part 1 Section 8, ''Settlement'', of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap',
    valuationDates VARCHAR(255) NOT NULL %DESCRIPTION 'The parameters used to generate the ''Equity Valuation Dates'' schedule, including the Effective Date and Termination Date for the Swap.',
    equityCashSettlementDates VARCHAR(255) NOT NULL %DESCRIPTION 'The parameters used to generate the payment date schedule, relative to the equityCalculationPeriod. Per Part 1 Section 12, ''Definitions'', of the 2018 ISDA CDM Equity Confirmation. Para 73'
);

CREATE TABLE cdm_product_asset.AssetDeliveryProfile_block (
    AssetDeliveryProfile_id INT NOT NULL,
    AssetDeliveryProfileBlock_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.AssetDeliveryProfile (
    AssetDeliveryProfile_id INT UNIQUE NOT NULL,
    loadType VARCHAR(255) %DESCRIPTION 'Identification of the delivery profile.',
    block INT NOT NULL %DESCRIPTION 'Defines a delivery profile block, including start and end time, days of the week, duration, delivery capacity and price time interval quantity.',
    bankHolidaysTreatment VARCHAR(255) %DESCRIPTION 'Specifies whether the dates defined include holidays or not.'
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecificationInstruction_variable (
    EligibleCollateralSpecificationInstruction_id INT NOT NULL,
    EligibleCollateralCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralSpecificationInstruction (
    EligibleCollateralSpecificationInstruction_id INT UNIQUE NOT NULL,
    common VARCHAR(255) NOT NULL,
    variable INT NOT NULL
);

CREATE TABLE cdm_product_template_metafields.ReferenceWithMetaFixedPricePayout (
    ReferenceWithMetaFixedPricePayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.CommodityInformationPublisherEnum (
    CommodityInformationPublisherEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.CollateralPortfolio_collateralPosition (
    CollateralPortfolio_id INT NOT NULL,
    CollateralPosition_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CollateralPortfolio_collateralBalance (
    CollateralPortfolio_id INT NOT NULL,
    CollateralBalance_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CollateralPortfolio (
    CollateralPortfolio_id INT UNIQUE NOT NULL,
    portfolioIdentifier VARCHAR(255) %DESCRIPTION 'Specifies a unique identifier for a set of collateral positions in a portfolio.',
    collateralPosition INT NOT NULL %DESCRIPTION 'Specifies the individual components of the collateral positions in the collateral portfolio.',
    collateralBalance INT NOT NULL %DESCRIPTION 'Represents the populated or calculated collateral aggregate balance amount for the collateral portfolio.',
    legalAgreement VARCHAR(255) %DESCRIPTION ' The specification of a legal agreement between two parties governing the collateral relationship such as Credit Support Agreement or Collateral Transfer Agreement etc. (NB: this can be provided by reference to a global key for each LegalAgreement object).'
);

CREATE TABLE cdm_product_common_schedule.WeeklyRollConventionEnum (
    WeeklyRollConventionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.DividendCurrency (
    DividendCurrency_id INT UNIQUE NOT NULL,
    currency VARCHAR(255) %DESCRIPTION 'The currency in which the dividend is denominated. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    determinationMethod VARCHAR(255) %DESCRIPTION 'Specifies the method according to which the dividend is determined, e.g. the dividend currency.',
    currencyReference VARCHAR(255) %DESCRIPTION 'Reference to a currency specified elsewhere in the document'
);

CREATE TABLE cdm_product_collateral.ConcentrationLimit_concentrationLimitCriteria (
    ConcentrationLimit_id INT NOT NULL,
    ConcentrationLimitCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.ConcentrationLimit (
    ConcentrationLimit_id INT UNIQUE NOT NULL,
    concentrationLimitCriteria INT NOT NULL %DESCRIPTION 'Specifies a set of criteria to describe the assets that the concentration limits apply to.',
    valueLimit VARCHAR(255) %DESCRIPTION 'Specifies the value of collateral limit represented as a range.',
    percentageLimit VARCHAR(255) %DESCRIPTION 'Specifies the perecentage of collateral limit represented as a decimal number - example 25% is 0.25.'
);

CREATE TABLE cdm_base_staticdata_asset_credit.ObligationCategoryEnum (
    ObligationCategoryEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.ExpirationTimeTypeEnum (
    ExpirationTimeTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.FieldWithMetaGoverningLawEnum (
    FieldWithMetaGoverningLawEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_party.CounterpartyRoleEnum (
    CounterpartyRoleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.AdjustableOrRelativeDates (
    AdjustableOrRelativeDates_id INT UNIQUE NOT NULL,
    adjustableDates VARCHAR(255) %DESCRIPTION 'A series of dates that shall be subject to adjustment if they would otherwise fall on a day that is not a business day in the specified business centers, together with the convention for adjusting the date.',
    relativeDates VARCHAR(255) %DESCRIPTION 'A series of dates specified as some offset to another series of dates (the anchor dates).'
);

CREATE TABLE cdm_event_common.MarginCallActionEnum (
    MarginCallActionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.ExerciseNotice (
    ExerciseNotice_id INT UNIQUE NOT NULL,
    exerciseNoticeGiver VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the principal party of the trade that has the right to exercise.',
    exerciseNoticeReceiver VARCHAR(255) %DESCRIPTION 'Specifies the party to which notice of exercise should be given, e.g. by the buyer of the option. Although in many cases it is the buyer of the option who sends the exercise notice to the seller of the option, this component is reused, e.g. in case of OptionEarlyTermination, either or both parties have the right to exercise.',
    businessCenter VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the location where the exercise must be reported, e.g. where the exercise notice receiver is based.'
);

CREATE TABLE cdm_observable_asset.BondEquityModel (
    BondEquityModel_id INT UNIQUE NOT NULL,
    bondchoiceModel VARCHAR(255) %DESCRIPTION 'Either the bond or convertible bond.',
    equity VARCHAR(255) %DESCRIPTION 'The equity.'
);

CREATE TABLE cdm_product_asset.DividendCompositionEnum (
    DividendCompositionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.FieldWithMetaSpreadScheduleTypeEnum (
    FieldWithMetaSpreadScheduleTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.PerformanceValuationDates (
    PerformanceValuationDates_id INT UNIQUE NOT NULL,
    determinationMethod VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the method according to which an amount or a date is determined.',
    valuationDates VARCHAR(255) %DESCRIPTION '2018 ISDA CDM Equity Confirmation for Security Equity Swap: Pricing Date',
    valuationDate VARCHAR(255) %DESCRIPTION '2018 ISDA CDM Equity Confirmation for Security Equity Swap: Pricing Date',
    valuationTime VARCHAR(255) %DESCRIPTION 'The specific time of day at which the calculation agent values the underlying. The SpecificTime is the only case when the valuationTime (time + business center location  e.g. 10:00:00 USNY) should be provided. You should be able to provide just the valuationTime without valuationTimeType, which infer that this is a specific time.',
    valuationTimeType VARCHAR(255) %DESCRIPTION 'The time of day at which the calculation agent values the underlying, for example the official closing time of the exchange.'
);

CREATE TABLE cdm_observable_asset.CleanOrDirtyPrice (
    CleanOrDirtyPrice_id INT UNIQUE NOT NULL,
    cleanPrice VARCHAR(255) %DESCRIPTION 'The clean price and accruals presented separately.',
    dirtyPrice FLOAT %DESCRIPTION 'The dirty price presented as a single number.'
);

CREATE TABLE cdm_base_staticdata_asset_common.TaxonomyValue_classification (
    TaxonomyValue_id INT NOT NULL,
    TaxonomyClassification_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.TaxonomyValue (
    TaxonomyValue_id INT UNIQUE NOT NULL,
    name VARCHAR(255) %DESCRIPTION 'Specifies the taxonomy value as a simple string, which may be associated to an external scheme.',
    classification INT NOT NULL %DESCRIPTION 'Specifies the taxonomy value as a set of class names and values for each class.'
);

CREATE TABLE cdm_product_common_settlement.TransferSettlementEnum (
    TransferSettlementEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset_calculatedrate.ObservationPeriodDatesEnum (
    ObservationPeriodDatesEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_event.FieldWithMetaRestructuringEnum (
    FieldWithMetaRestructuringEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_event_common.TransferBase_identifier (
    TransferBase_id INT NOT NULL,
    FieldWithMetaIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TransferBase (
    TransferBase_id INT UNIQUE NOT NULL,
    identifier INT NOT NULL %DESCRIPTION 'Represents a unique reference to the transfer.',
    quantity VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the amount of the asset to be transferred.',
    observable VARCHAR(255) %DESCRIPTION 'Represents the object that is subject to the transfer, it could be an asset or a reference.',
    payerReceiver VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the parties to the transfer and their role.',
    settlementDate VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the date on which the transfer to due.'
);

CREATE TABLE cdm_product_common_settlement.Cashflow (
    Cashflow_id INT UNIQUE NOT NULL,
    cashflowType VARCHAR(255) NOT NULL %DESCRIPTION 'The qualification of the type of cashflow, e.g. brokerage fee, premium, upfront fee etc. Particularly relevant when it cannot be inferred directly through lineage.',
    paymentDiscounting VARCHAR(255) %DESCRIPTION 'FpML specifies the FpML PaymentDiscounting.model group for representing the discounting elements that can be associated with a payment.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_event_position.Position_priceQuantity (
    Position_id INT NOT NULL,
    PriceQuantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.Position (
    Position_id INT UNIQUE NOT NULL,
    priceQuantity INT NOT NULL %DESCRIPTION 'Position with many price quantities.',
    product VARCHAR(255) NOT NULL %DESCRIPTION 'The product underlying the position.',
    cashBalance VARCHAR(255) %DESCRIPTION 'The aggregate cost of proceeds',
    tradeReference VARCHAR(255) %DESCRIPTION 'Reference to the Contract, in case product is contractual and the contract has been formed'
);

CREATE TABLE cdm_base_staticdata_asset_common.Bond (
    Bond_id INT UNIQUE NOT NULL,
    productIdentifier VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.CashCollateralValuationMethod_protectedParty (
    CashCollateralValuationMethod_id INT NOT NULL,
    PartyDeterminationEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.CashCollateralValuationMethod (
    CashCollateralValuationMethod_id INT UNIQUE NOT NULL,
    applicableCsa VARCHAR(255) %DESCRIPTION 'This may be used to specify what type of CSA (credit support annex/agreement) is to be used for cash settlement purposes.',
    cashCollateralCurrency VARCHAR(255) %DESCRIPTION 'This may be used to indicate the currency of cash collateral for cash settlement purposes.',
    cashCollateralInterestRate VARCHAR(255) %DESCRIPTION 'This may be used to indicate the interest rate to be used for cash collateral for cash settlement purposes.',
    agreedDiscountRate VARCHAR(255) %DESCRIPTION 'This may be used to indicate the discount rate to be used for cash collateral for cash settlement purposes.',
    protectedParty INT NOT NULL %DESCRIPTION 'This may be used to specify which party is protected (e.g. under Replacement Value cash settlement methods).',
    prescribedDocumentationAdjustment INT %DESCRIPTION 'This may be used to indicate that ''prescribed documentation adjustment'' is applicable.'
);

CREATE TABLE cdm_observable_asset.ValuationPostponement (
    ValuationPostponement_id INT UNIQUE NOT NULL,
    maximumDaysOfPostponement INT NOT NULL %DESCRIPTION 'The maximum number of days to wait for a quote from the disrupted settlement rate option before proceeding to the next method.'
);

CREATE TABLE cdm_product_asset.DividendPaymentDate (
    DividendPaymentDate_id INT UNIQUE NOT NULL,
    dividendDateReference VARCHAR(255),
    dividendDate VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.PaymentDateSchedule_interimPaymentDates (
    PaymentDateSchedule_id INT NOT NULL,
    AdjustableRelativeOrPeriodicDates_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.PaymentDateSchedule (
    PaymentDateSchedule_id INT UNIQUE NOT NULL,
    interimPaymentDates INT NOT NULL,
    finalPaymentDate VARCHAR(255) %DESCRIPTION 'The last payment when specified as an adjustable or relative date, as in the FpML total return construct.'
);

CREATE TABLE cdm_legaldocumentation_common.FieldWithMetaContractualDefinitionsEnum (
    FieldWithMetaContractualDefinitionsEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.CollateralInterestParameters (
    CollateralInterestParameters_id INT UNIQUE NOT NULL,
    postingParty VARCHAR(255) %DESCRIPTION 'Represents the party to which these parameters apply (the applicable party).  In other words, if the parameters are different depending on which party is posting/holding the collateral, for which party to the Collateral Agreement (Party 1 or Party 2) that is posting the collateral do these parameters apply?',
    marginType VARCHAR(255) %DESCRIPTION 'Specifies the type of margin for which interest is being calculated, if the parameters are different depending on type of margin (initial or variation).',
    currency VARCHAR(255) %DESCRIPTION 'Specifies the currency for which the parameters are captured.',
    interestCalculationParameters VARCHAR(255) %DESCRIPTION 'Represents the basic interest calculation parameters.',
    interestCalculationFrequency VARCHAR(255) %DESCRIPTION 'Represents how often and when interest is calculated.',
    interestHandlingParameters VARCHAR(255) %DESCRIPTION 'Represents the parameters describing how and when interest transfer occurs.'
);

CREATE TABLE cdm_event_workflow.WorkflowStepApproval (
    WorkflowStepApproval_id INT UNIQUE NOT NULL,
    approved INT NOT NULL %DESCRIPTION 'Flag denoting whether the workflow step is approved or not',
    party VARCHAR(255) NOT NULL %DESCRIPTION 'Reference to the Party who is approving/rejecting this workflow step',
    rejectedReason VARCHAR(255) %DESCRIPTION 'Optional reason for rejecting the workflow step',
    timestamp VARCHAR(255) NOT NULL %DESCRIPTION 'Timestamp of the approval'
);

CREATE TABLE cdm_product_asset.BasketReferenceInformation_basketId (
    BasketReferenceInformation_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.BasketReferenceInformation (
    BasketReferenceInformation_id INT UNIQUE NOT NULL,
    basketName VARCHAR(255) %DESCRIPTION 'The name of the basket expressed as a free format string. FpML does not define usage rules for this element.',
    basketId INT NOT NULL %DESCRIPTION 'A CDS basket identifier.',
    referencePool VARCHAR(255) NOT NULL %DESCRIPTION 'This element contains all the reference pool items to define the reference entity and reference obligation(s) in the basket.',
    nthToDefault INT %DESCRIPTION 'N th reference obligation to default triggers payout.',
    mthToDefault INT %DESCRIPTION 'M th reference obligation to default to allow representation of N th to M th defaults.',
    tranche VARCHAR(255) %DESCRIPTION 'This element contains CDS tranche terms.'
);

CREATE TABLE cdm_base_datetime.DateList_date (
    DateList_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.DateList (
    DateList_id INT UNIQUE NOT NULL,
    date INT NOT NULL
);

CREATE TABLE cdm_regulation.Pric (
    Pric_id INT UNIQUE NOT NULL,
    pric VARCHAR(255) NOT NULL,
    bsisPts VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_event_position.AggregationParameters_party (
    AggregationParameters_id INT NOT NULL,
    ReferenceWithMetaParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AggregationParameters_product (
    AggregationParameters_id INT NOT NULL,
    Product_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AggregationParameters_productQualifier (
    AggregationParameters_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AggregationParameters_tradeReference (
    AggregationParameters_id INT NOT NULL,
    ReferenceWithMetaTrade_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AggregationParameters (
    AggregationParameters_id INT UNIQUE NOT NULL,
    dateTime VARCHAR(255) NOT NULL %DESCRIPTION 'To aggregate as of a particular date',
    totalPosition INT %DESCRIPTION 'Specifies whether to calculate total position to given date, or only daily position for the given date.',
    positionStatus VARCHAR(255) %DESCRIPTION 'To aggregate based on position status (EXECUTED, SETTLED etc)',
    party INT NOT NULL %DESCRIPTION 'To aggregate based on a selection of party(ies) / legal entity(ies).',
    product INT NOT NULL %DESCRIPTION 'To aggregate based on a selection of products.',
    productQualifier INT NOT NULL %DESCRIPTION 'To aggregate based on a selection of product type(s).',
    tradeReference INT NOT NULL
);

CREATE TABLE cdm_event_position.Inventory_inventoryRecord (
    Inventory_id INT NOT NULL,
    InventoryRecord_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.Inventory (
    Inventory_id INT UNIQUE NOT NULL,
    inventoryRecord INT NOT NULL %DESCRIPTION 'An array holding the list of inventory being described. Each element in the inventoryRecord array represents an individual piece of inventory i.e. a security.'
);

CREATE TABLE cdm_product_template.DurationTypeEnum (
    DurationTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset_metafields.ReferenceWithMetaCommodityPayout (
    ReferenceWithMetaCommodityPayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_common_settlement.LoanParticipation (
    LoanParticipation_id INT UNIQUE NOT NULL,
    qualifyingParticipationSeller VARCHAR(255) %DESCRIPTION 'If Direct Loan Participation is specified as a deliverable obligation characteristic, this specifies any requirements for the Qualifying Participation Seller. The requirements may be listed free-form. ISDA 2003 Term: Qualifying Participation Seller.',
    applicable INT %DESCRIPTION 'Indicates whether the provision is applicable.',
    partialCashSettlement INT %DESCRIPTION 'Specifies whether either ''Partial Cash Settlement of Assignable Loans'', ''Partial Cash Settlement of Consent Required Loans'' or ''Partial Cash Settlement of Participations'' is applicable. If this element is specified and Assignable Loan is a Deliverable Obligation Characteristic, any Assignable Loan that is deliverable, but where a non-receipt of Consent by the Physical Settlement Date has occurred, the Loan can be cash settled rather than physically delivered. If this element is specified and Consent Required Loan is a Deliverable Obligation Characteristic, any Consent Required Loan that is deliverable, but where a non-receipt of Consent by the Physical Settlement Date has occurred, the Loan can be cash settled rather than physically delivered. If this element is specified and Direct Loan Participation is a Deliverable Obligation Characteristic, any Participation that is deliverable, but where this participation has not been effected (has not come into effect) by the Physical Settlement Date, the participation can be cash settled rather than physically delivered.'
);

CREATE TABLE cdm_base_staticdata_identifier.TradeIdentifierTypeEnum (
    TradeIdentifierTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.FieldWithMetaCommodity (
    FieldWithMetaCommodity_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_common_settlement.DeliveryMethodEnum (
    DeliveryMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.EquityTypeEnum (
    EquityTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.CalculationSchedule_schedulePeriod (
    CalculationSchedule_id INT NOT NULL,
    SchedulePeriod_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.CalculationSchedule (
    CalculationSchedule_id INT UNIQUE NOT NULL,
    schedulePeriod INT NOT NULL %DESCRIPTION 'Defines a period of a calculation schedule structure.'
);

CREATE TABLE cdm_regulation.AddtlAttrbts (
    AddtlAttrbts_id INT UNIQUE NOT NULL,
    rskRdcgTx VARCHAR(255) NOT NULL,
    sctiesFincgTxInd VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_observable_asset.FieldWithMetaSettlementRateOptionEnum (
    FieldWithMetaSettlementRateOptionEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_common_settlement.FixedPrice (
    FixedPrice_id INT UNIQUE NOT NULL,
    price VARCHAR(255) %DESCRIPTION 'Fixed price step schedule, including an initial price specified as an absolute number.'
);

CREATE TABLE cdm_event_common.ConfirmationStatusEnum (
    ConfirmationStatusEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.QuotedCurrencyPair (
    QuotedCurrencyPair_id INT UNIQUE NOT NULL,
    currency1 VARCHAR(255) NOT NULL %DESCRIPTION 'The first currency specified when a pair of currencies is to be evaluated.',
    currency2 VARCHAR(255) NOT NULL %DESCRIPTION 'The second currency specified when a pair of currencies is to be evaluated.',
    quoteBasis VARCHAR(255) NOT NULL %DESCRIPTION 'The method by which the exchange rate is quoted.'
);

CREATE TABLE cdm_observable_asset.InformationSource (
    InformationSource_id INT UNIQUE NOT NULL,
    sourceProvider VARCHAR(255) NOT NULL %DESCRIPTION 'An information source for obtaining a market data point. For example Bloomberg, Reuters, Telerate, etc.',
    sourcePage VARCHAR(255) %DESCRIPTION 'A specific page for the source for obtaining a market data point. In FpML, this is specified as a scheme, rateSourcePageScheme, for which no coding Scheme or URI is specified.',
    sourcePageHeading VARCHAR(255) %DESCRIPTION 'The heading for the source on a given source page.'
);

CREATE TABLE cdm_base_math.QuantitySchedule_datedValue (
    QuantitySchedule_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.QuantitySchedule (
    QuantitySchedule_id INT UNIQUE NOT NULL,
    multiplier VARCHAR(255) %DESCRIPTION 'Defines an optional number that the quantity should be multiplied by to derive a total quantity. This number is associated to a unit. For example in the case of the Coal (API2) CIF ARA (ARGUS-McCloskey) Futures Contract on the CME, where the unit would be contracts, the multiplier value would 1,000 and the mulitiplier unit would be 1,000 MT (Metric Tons).',
    frequency VARCHAR(255) %DESCRIPTION 'Defines the frequency to be used when defining a quantity. For example a quantity may be specified as a number of barrels of oil per day, which needs multiplying by the number of days in the relevant period to get the total quantity as a number of barrels.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_base_staticdata_party.Account (
    Account_id INT UNIQUE NOT NULL,
    partyReference VARCHAR(255) %DESCRIPTION 'A reference to the party to which the account refers to.',
    accountNumber VARCHAR(255) NOT NULL %DESCRIPTION 'The account number.',
    accountName VARCHAR(255) %DESCRIPTION 'The name by which the account is known.',
    accountType VARCHAR(255) %DESCRIPTION 'The type of account, e.g. client, house.',
    accountBeneficiary VARCHAR(255) %DESCRIPTION 'A reference to the party beneficiary of the account.',
    servicingParty VARCHAR(255) %DESCRIPTION 'The reference to the legal entity that services the account, i.e. in the books of which the account is held.'
);

CREATE TABLE cdm_event_common.SecurityLendingInvoice_billingRecord (
    SecurityLendingInvoice_id INT NOT NULL,
    BillingRecord_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.SecurityLendingInvoice_billingSummary (
    SecurityLendingInvoice_id INT NOT NULL,
    BillingSummary_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.SecurityLendingInvoice (
    SecurityLendingInvoice_id INT UNIQUE NOT NULL,
    sendingParty VARCHAR(255) NOT NULL %DESCRIPTION 'The party issuing the invoice',
    receivingParty VARCHAR(255) NOT NULL %DESCRIPTION 'The party receiving the invoice',
    billingStartDate VARCHAR(255) NOT NULL %DESCRIPTION 'The starting date of the period described by this invoice',
    billingEndDate VARCHAR(255) NOT NULL %DESCRIPTION 'The ending date of the period described by this invoice',
    billingRecord INT NOT NULL %DESCRIPTION 'The billing records contained within the invoice',
    billingSummary INT NOT NULL %DESCRIPTION 'The billing summaries contained within the invoice'
);

CREATE TABLE cdm_event_common.RegMarginTypeEnum (
    RegMarginTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.IssuerTypeEnum (
    IssuerTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.NaturalPersonRole_role (
    NaturalPersonRole_id INT NOT NULL,
    FieldWithMetaNaturalPersonRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.NaturalPersonRole (
    NaturalPersonRole_id INT UNIQUE NOT NULL,
    personReference VARCHAR(255) NOT NULL %DESCRIPTION 'A reference to the natural person to whom the role refers to.',
    role INT NOT NULL %DESCRIPTION 'FpML specifies a person role that is distinct from the party role.'
);

CREATE TABLE cdm_product_asset.FinalPrincipalExchangeCalculationEnum (
    FinalPrincipalExchangeCalculationEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.PrincipalPayments_varyingLegNotionalCurrency (
    PrincipalPayments_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.PrincipalPayments (
    PrincipalPayments_id INT UNIQUE NOT NULL,
    initialPayment INT NOT NULL %DESCRIPTION 'A true/false flag to indicate whether there is an initial exchange of principal on the effective date.',
    finalPayment INT NOT NULL %DESCRIPTION 'A true/false flag to indicate whether there is a final exchange of principal on the termination date.',
    intermediatePayment INT NOT NULL %DESCRIPTION 'A true/false flag to indicate whether there are intermediate or interim exchanges of principal during the term of the swap.',
    varyingLegNotionalCurrency INT NOT NULL %DESCRIPTION 'Indicate the Payout legs which nominal amount may vary in regards of FX Fixing dates as determined in the product terms.',
    principalPaymentSchedule VARCHAR(255) %DESCRIPTION 'Describe dates schedules for Principal Exchanges and related role of the parties when known.'
);

CREATE TABLE cdm_product_template.DividendTerms (
    DividendTerms_id INT UNIQUE NOT NULL,
    manufacturedIncomeRequirement VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the proportion of the value of the dividend on the borrowed shares that the borrower is legally obligated to return to the lender.',
    dividendEntitlement VARCHAR(255) %DESCRIPTION 'Defines the date on which the receiver of the equity return is entitled to the dividend.',
    minimumBillingAmount VARCHAR(255) %DESCRIPTION 'daily fee increments accrue until a threshold is crossed, at which point payment becomes due)'
);

CREATE TABLE cdm_observable_asset.Curve (
    Curve_id INT UNIQUE NOT NULL,
    interestRateCurve VARCHAR(255),
    commodityCurve VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.CreditRatingCreditWatchEnum (
    CreditRatingCreditWatchEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_position.AvailableInventoryRecord_collateral (
    AvailableInventoryRecord_id INT NOT NULL,
    CollateralProvisions_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AvailableInventoryRecord_partyRole (
    AvailableInventoryRecord_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AvailableInventoryRecord (
    AvailableInventoryRecord_id INT UNIQUE NOT NULL,
    expirationDateTime VARCHAR(255) %DESCRIPTION 'There may be a set period/time restriction associated to the security.',
    collateral INT NOT NULL %DESCRIPTION 'The type of collateral can often be required when determining if the piece of availability being described is suitable for a party.',
    partyRole INT NOT NULL %DESCRIPTION 'An individual security may be held by several agents. Including the party role at this level allows us to reference the party holding this specific item.',
    availableQuantity VARCHAR(255) %DESCRIPTION 'The quantity of the security that is available',
    interestRate VARCHAR(255) %DESCRIPTION 'An optional element which can be used to hold a rate associated to this piece of availability.',
    identifer VARCHAR(255) %DESCRIPTION 'Unique identifier for this record. This can be used to uniquely identify a specific piece of inventory.',
    security VARCHAR(255) %DESCRIPTION 'The security details.'
);

CREATE TABLE cdm_product_template.EarlyTerminationEvent (
    EarlyTerminationEvent_id INT UNIQUE NOT NULL,
    adjustedExerciseDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which option exercise takes place. This date should already be adjusted for any applicable business day convention.',
    adjustedEarlyTerminationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The early termination date that is applicable if an early termination provision is exercised. This date should already be adjusted for any applicable business day convention.',
    adjustedCashSettlementValuationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date by which the cash settlement amount must be agreed. This date should already be adjusted for any applicable business day convention.',
    adjustedCashSettlementPaymentDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the cash settlement amount is paid. This date should already be adjusted for any applicable business date convention.',
    adjustedExerciseFeePaymentDate VARCHAR(255) %DESCRIPTION 'The date on which the exercise fee amount is paid. This date should already be adjusted for any applicable business day convention.'
);

CREATE TABLE cdm_event_workflow.WorkflowStatusEnum (
    WorkflowStatusEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.CallTypeEnum (
    CallTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_workflow.EventTimestamp (
    EventTimestamp_id INT UNIQUE NOT NULL,
    dateTime VARCHAR(255) NOT NULL %DESCRIPTION 'The CDM specifies that the zoned date time is to be expressed in accordance with ISO 8601, either as UTC as an offset to UTC.',
    qualification VARCHAR(255) NOT NULL %DESCRIPTION 'The timestamp qualifier is specified through an enumeration because the experience of integrating the DTCC and CME data representations suggests that a wide set of timestamps are currently utilized among service providers, while there is not at present an objective set of criteria that could help suggest a defined set of timestamps as part of the CDM. At some future point, one possible baseline could be developed from the review of the set of timestamps specified across regulatory regimes and regulations (incl. regulations such as high frequency trading). Also, the integration with a further set of implementations and the specification of business workflows such as clearing as part of the CDM development should help confirm the implementation approach in this respect.'
);

CREATE TABLE cdm_legaldocumentation_csa.SecurityAgreementElections (
    SecurityAgreementElections_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.PerformancePayout_fxFeature (
    PerformancePayout_id INT NOT NULL,
    FxFeature_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.PerformancePayout_portfolioReturnTerms (
    PerformancePayout_id INT NOT NULL,
    PortfolioReturnTerms_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.PerformancePayout (
    PerformancePayout_id INT UNIQUE NOT NULL,
    observationTerms VARCHAR(255) %DESCRIPTION 'Defines how and when a performance type option or performance type swap is to be observed.',
    valuationDates VARCHAR(255) NOT NULL %DESCRIPTION 'Defines how and when a performance type option or performance type swap is to be valued, including both interim and final valuation.',
    paymentDates VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the payment date schedule, as defined by the parameters that are needed to specify it, either in a parametric way or by reference to another schedule of dates (e.g. the valuation dates).',
    underlier VARCHAR(255) %DESCRIPTION 'Identifies the underlying product that is referenced for pricing of the applicable leg in a swap.  Referenced in the ''2018 ISDA CDM Equity Confirmation for Security Equity Swap'' as Security.',
    fxFeature INT NOT NULL %DESCRIPTION 'Defines quanto or composite FX features that are included in the swap leg.',
    returnTerms VARCHAR(255) %DESCRIPTION 'Specifies the type of return of a performance payout.',
    portfolioReturnTerms INT NOT NULL %DESCRIPTION 'Specifies an individual type of return of a Performance Payout, when such individual return is part of an aggregation of multiple similar returns, at Performance Payout level',
    initialValuationPrice VARCHAR(255) %DESCRIPTION 'Specifies the net initial valuation price(s) of the underlier at Performance Payout level. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    interimValuationPrice VARCHAR(255) %DESCRIPTION 'Specifies the net initial valuation price(s) of the underlier at Performance Payout level. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    finalValuationPrice VARCHAR(255) %DESCRIPTION 'Specifies the net final valuation price(s) of the underlier at Performance Payout level. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_regulation.Indx (
    Indx_id INT UNIQUE NOT NULL,
    nm VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_template.SecurityPayout_securityLeg (
    SecurityPayout_id INT NOT NULL,
    SecurityLeg_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.SecurityPayout_securityValuation (
    SecurityPayout_id INT NOT NULL,
    SecurityValuation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.SecurityPayout (
    SecurityPayout_id INT UNIQUE NOT NULL,
    securityLeg INT NOT NULL %DESCRIPTION 'Each SecurityLeg represent a buy/sell at different dates, typically 1 near leg and 1 far leg in a securities financing transaction.',
    initialMargin VARCHAR(255) %DESCRIPTION 'RepoDurationEnum.',
    repoDuration VARCHAR(255) %DESCRIPTION 'A duration code for the repo transaction. This defines a type of a repo transaction with fixed duration.',
    securityValuation INT NOT NULL %DESCRIPTION 'The underlying securities and their valuation for the security leg.'
);

CREATE TABLE cdm_product_common_schedule.AmountSchedule_currency (
    AmountSchedule_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.AmountSchedule_datedValue (
    AmountSchedule_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.AmountSchedule (
    AmountSchedule_id INT UNIQUE NOT NULL,
    currency INT NOT NULL %DESCRIPTION 'The currency in which the amount schedule is denominated. The currency is specified outside of the actual schedule in order to be applied uniformly to it. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    value FLOAT %DESCRIPTION 'The initial rate or amount, as the case may be. An initial rate of 5% would be represented as 0.05.',
    datedValue INT NOT NULL %DESCRIPTION 'The schedule of step date and value pairs. On each step date the associated step value becomes effective. A list of steps may be ordered in the document by ascending step date. An FpML document containing an unordered list of steps is still regarded as a conformant document.'
);

CREATE TABLE cdm_base_staticdata_asset_common.DebtClassEnum (
    DebtClassEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party_metafields.ReferenceWithMetaAccount (
    ReferenceWithMetaAccount_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.CollateralInterestHandlingParameters_paymentBusinessCenter (
    CollateralInterestHandlingParameters_id INT NOT NULL,
    BusinessCenterEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralInterestHandlingParameters (
    CollateralInterestHandlingParameters_id INT UNIQUE NOT NULL,
    interestPaymentHandling VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies how the collateral interest is to be handled.',
    paymentBusinessCenter INT NOT NULL %DESCRIPTION 'Specifies applicable business centers for payments.',
    netPostedAndHeldInterest INT NOT NULL %DESCRIPTION 'Indicates whether to net Held and Posted Interest Payments (i.e. whether interest payable for a period can be netted with interest receivable).',
    netInterestWithMarginCalls INT NOT NULL %DESCRIPTION 'Indicates whether the interest amount may be offset against any margin call deliver or return amounts?   (aka ''net payments'' indicator).',
    includeAccrualInMarginCalc INT NOT NULL %DESCRIPTION 'Indicates whether or not to include the open interest accrual in the margin calculation.',
    accrueInterestOnUnsettledInterest INT %DESCRIPTION 'Indicates whether interest accruing on unsettled interest amount is included (continues to be accrued) in the following period.',
    onFullReturn INT NOT NULL %DESCRIPTION 'Indicates the option that accrued interest should be calculated and distributed when a full return of collateral occurs.',
    onPartialReturn INT NOT NULL %DESCRIPTION 'Indicates the option that accrued interest should be calculated and distributed when a partial return collateral occurs.',
    interestAmountApplication VARCHAR(255) %DESCRIPTION 'The application of Interest Amount with respect to the Delivery Amount and the Return Amount.',
    interestRolloverLimit VARCHAR(255) %DESCRIPTION 'Specifies the level below which the interest will be rolled over.',
    writeoffLimit VARCHAR(255) %DESCRIPTION 'Specifies the level below which the interest will be written off; if omitted write-off is not applicable.',
    alternativeToInterestAmount VARCHAR(255) %DESCRIPTION 'Specifies the alternative to interest amounts.',
    alternativeProvision VARCHAR(255) %DESCRIPTION 'Specifies an alternative to interest amount, when the alternative provision clause is specified.',
    cutoffTime VARCHAR(255) %DESCRIPTION 'Specifies the time of day that interest needs to be confirmed by.',
    notification VARCHAR(255) %DESCRIPTION 'Specifies the terms describing notification requirements.'
);

CREATE TABLE cdm_base_staticdata_party.PartyContactInformation_businessUnit (
    PartyContactInformation_id INT NOT NULL,
    BusinessUnit_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.PartyContactInformation_person (
    PartyContactInformation_id INT NOT NULL,
    NaturalPerson_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.PartyContactInformation (
    PartyContactInformation_id INT UNIQUE NOT NULL,
    partyReference VARCHAR(255) %DESCRIPTION 'The reference to the party to which the contact information refers to.',
    contactInformation VARCHAR(255) %DESCRIPTION 'The postal/street address, telephone number, email address and/or web page. If the contact information is specific to the associated business unit(s), it should be associated with those.',
    businessUnit INT NOT NULL %DESCRIPTION 'Optional organization unit information used to describe the organization units (e.g. trading desks) involved in a transaction or business process, incl. the contact information (when relevant).',
    person INT NOT NULL %DESCRIPTION 'Optional information about people involved in a transaction or business process. (These are employees of the party.)',
    additionalInformation VARCHAR(255) %DESCRIPTION 'Specification of special instructions of the relevant party.'
);

CREATE TABLE cdm_product_template_metafields.ReferenceWithMetaAssetPayout (
    ReferenceWithMetaAssetPayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_math.NonNegativeQuantitySchedule_datedValue (
    NonNegativeQuantitySchedule_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.NonNegativeQuantitySchedule (
    NonNegativeQuantitySchedule_id INT UNIQUE NOT NULL,
    multiplier VARCHAR(255) %DESCRIPTION 'Defines an optional number that the quantity should be multiplied by to derive a total quantity. This number is associated to a unit. For example in the case of the Coal (API2) CIF ARA (ARGUS-McCloskey) Futures Contract on the CME, where the unit would be contracts, the multiplier value would 1,000 and the mulitiplier unit would be 1,000 MT (Metric Tons).',
    frequency VARCHAR(255) %DESCRIPTION 'Defines the frequency to be used when defining a quantity. For example a quantity may be specified as a number of barrels of oil per day, which needs multiplying by the number of days in the relevant period to get the total quantity as a number of barrels.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_observable_asset_fro.FloatingRateIndexCalculationMethodEnum (
    FloatingRateIndexCalculationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party_metafields.ReferenceWithMetaNaturalPerson (
    ReferenceWithMetaNaturalPerson_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.InformationProviderEnum (
    InformationProviderEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_collateral.CollateralInterestNotification (
    CollateralInterestNotification_id INT UNIQUE NOT NULL,
    trigger VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies what triggers notification (should be enum) Interest Statement Frequency, Period End Date.',
    offset FLOAT NOT NULL %DESCRIPTION 'Specifies the number of days before (negative) or after (positive) the trigger event.',
    notificationTime VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the time of day that the notification should occur.',
    notificationDayType VARCHAR(255) NOT NULL %DESCRIPTION 'The type of days on which notification should occur.'
);

CREATE TABLE cdm_base_datetime.BusinessCenters_businessCenter (
    BusinessCenters_id INT NOT NULL,
    FieldWithMetaBusinessCenterEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.BusinessCenters_commodityBusinessCalendar (
    BusinessCenters_id INT NOT NULL,
    FieldWithMetaCommodityBusinessCalendarEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_datetime.BusinessCenters (
    BusinessCenters_id INT UNIQUE NOT NULL,
    businessCenter INT NOT NULL %DESCRIPTION 'A code identifying one or several business day calendar location(s). The set of business day calendar locations are specified by the business day calendar location enumeration which is maintained by the FpML standard.',
    commodityBusinessCalendar INT NOT NULL,
    businessCentersReference VARCHAR(255) %DESCRIPTION 'A reference to a financial business center location specified elsewhere in the instance document.'
);

CREATE TABLE cdm_event_common.TransferInstruction_transferState (
    TransferInstruction_id INT NOT NULL,
    TransferState_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TransferInstruction (
    TransferInstruction_id INT UNIQUE NOT NULL,
    transferState INT NOT NULL %DESCRIPTION 'Specifies the terms and state of a transfers.'
);

CREATE TABLE cdm_observable_asset.Observable_productIdentifier (
    Observable_id INT NOT NULL,
    FieldWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.Observable (
    Observable_id INT UNIQUE NOT NULL,
    rateOption VARCHAR(255) %DESCRIPTION 'Specifies a floating rate index and tenor.',
    commodity VARCHAR(255) %DESCRIPTION 'Identifies a commodity by referencing a product identifier.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises of an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.',
    currencyPair VARCHAR(255) %DESCRIPTION 'Describes the composition of a rate that has been quoted or is to be quoted, including the two currencies and the quotation relationship between the two currencies.',
    optionReferenceType VARCHAR(255) %DESCRIPTION 'The underlying contract which is referenced when determining the final settlement price of the instrument. Eg. Rolling Front Month Future; Spot etc.'
);

CREATE TABLE cdm_product_common_settlement.ScheduledTransferEnum (
    ScheduledTransferEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.RelativeDates (
    RelativeDates_id INT UNIQUE NOT NULL,
    periodSkip INT %DESCRIPTION 'The number of periods in the referenced date schedule that are between each date in the relative date schedule. Thus a skip of 2 would mean that dates are relative to every second date in the referenced schedule. If present this should have a value greater than 1.',
    scheduleBounds VARCHAR(255) %DESCRIPTION 'The first and last dates of a schedule. This can be used to restrict the range of values in a reference series of dates.',
    businessDayConvention VARCHAR(255) %DESCRIPTION 'The convention for adjusting a date if it would otherwise fall on a day that is not a business day, as specified by an ISDA convention (e.g. Following, Precedent).',
    businessCenters VARCHAR(255),
    businessCentersReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to a set of financial business centers defined elsewhere in the document. This set of business centers is used to determine whether a particular day is a business day or not.',
    dateRelativeTo VARCHAR(255) %DESCRIPTION 'Specifies the anchor as an href attribute. The href attribute value is a pointer style reference to the element or component elsewhere in the document where the anchor date is defined.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).',
    dayType VARCHAR(255) %DESCRIPTION 'In the case of an offset specified as a number of days, this element defines whether consideration is given as to whether a day is a good business day or not. If a day type of business days is specified then non-business days are ignored when calculating the offset. The financial business centers to use for determination of business days are implied by the context in which this element is used. This element must only be included when the offset is specified as a number of days. If the offset is zero days then the dayType element should not be included.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2 or 3 etc. A negative value can be used when specifying an offset relative to another date, e.g. -2 days.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month or year of the stream. If the periodMultiplier value is 0 (zero) then period must contain the value D (day).'
);

CREATE TABLE cdm_event_common.ReturnInstruction_quantity (
    ReturnInstruction_id INT NOT NULL,
    Quantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ReturnInstruction (
    ReturnInstruction_id INT UNIQUE NOT NULL,
    quantity INT NOT NULL %DESCRIPTION 'Specifies the quantity of shares and cash to be returned in a partial return event.'
);

CREATE TABLE cdm_product_template.CancellationEvent (
    CancellationEvent_id INT UNIQUE NOT NULL,
    adjustedExerciseDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which option exercise takes place. This date should already be adjusted for any applicable business day convention.',
    adjustedEarlyTerminationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The early termination date that is applicable if an early termination provision is exercised. This date should already be adjusted for any applicable business day convention.'
);

CREATE TABLE cdm_product_common_schedule.ResetDates (
    ResetDates_id INT UNIQUE NOT NULL,
    calculationPeriodDatesReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to the associated calculation period dates component defined elsewhere in the document.',
    resetRelativeTo VARCHAR(255) %DESCRIPTION 'Specifies whether the reset dates are determined with respect to each adjusted calculation period start date or adjusted calculation period end date. If the reset frequency is specified as daily this element must not be included.',
    initialFixingDate VARCHAR(255) %DESCRIPTION 'The initial fixing date.',
    fixingDates VARCHAR(255) %DESCRIPTION 'The fixing dates are the dates on which the index values are observed. The fixing dates are specified by reference to the reset date through business days offset and an associated set of financial business centers. Normally these offset calculation rules will be those specified in the ISDA definition for the relevant floating rate index (ISDA''s Floating Rate Option). However, non-standard offset calculation rules may apply for a trade if mutually agreed by the principal parties to the transaction.',
    finalFixingDate VARCHAR(255) %DESCRIPTION 'This attribute is not part of the FpML ResetDate, and has been added as part of the CDM to support the credit derivatives final fixing date.',
    rateCutOffDaysOffset VARCHAR(255) %DESCRIPTION 'Specifies the number of business days before the period end date when the rate cut-off date is assumed to apply. The financial business centers associated with determining the rate cut-off date are those specified in the reset dates adjustments. The rate cut-off number of days must be a negative integer (a value of zero would imply no rate cut off applies in which case the rateCutOffDaysOffset element should not be included). The relevant rate for each reset date in the period from, and including, a rate cut-off date to, but excluding, the next applicable period end date (or, in the case of the last calculation period, the termination date) will (solely for purposes of calculating the floating amount payable on the next applicable payment date) be deemed to be the relevant rate in effect on that rate cut-off date. For example, if rate cut-off days for a daily averaging deal is -2 business days, then the refix rate applied on (period end date - 2 days) will also be applied as the reset on (period end date - 1 day), i.e. the actual number of reset dates remains the same but from the rate cut-off date until the period end date, the same refix rate is applied. Note that in the case of several calculation periods contributing to a single payment, the rate cut-off is assumed only to apply to the final calculation period contributing to that payment. The day type associated with the offset must imply a business days offset.',
    resetFrequency VARCHAR(255) %DESCRIPTION 'The frequency at which the reset dates occur. In the case of a weekly reset frequency, also specifies the day of the week that the reset occurs. If the reset frequency is greater than the calculation period frequency then this implies that more than one reset is established for each calculation period and some form of rate averaging is applicable.',
    resetDatesAdjustments VARCHAR(255) %DESCRIPTION 'The definition of the business day convention and financial business centers used for adjusting the reset date if it would otherwise fall on a day that is not a business day in the specified business center.'
);

CREATE TABLE cdm_base_math.Rounding (
    Rounding_id INT UNIQUE NOT NULL,
    roundingDirection VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the rounding rounding rule as up, down, or nearest.',
    precision INT %DESCRIPTION 'Specifies the rounding precision in terms of a number of decimal places when the number is evaluated in decimal form (not percentage), e.g. 0.09876543 rounded to the nearest 5 decimal places is  0.0987654.'
);

CREATE TABLE cdm_product_asset.BoundedCorrelation (
    BoundedCorrelation_id INT UNIQUE NOT NULL,
    minimumBoundaryPercent FLOAT %DESCRIPTION 'Minimum Boundary as a percentage of the Strike Price.',
    maximumBoundaryPercent FLOAT %DESCRIPTION 'Maximum Boundary as a percentage of the Strike Price.'
);

CREATE TABLE cdm_event_workflow.LimitApplicableExtended (
    LimitApplicableExtended_id INT UNIQUE NOT NULL,
    limitLevel VARCHAR(255) %DESCRIPTION 'The level at which the limit is set: customer business, proprietary business or account level. This attribute is specified as a string as part of the CME clearing confirmation specification.',
    limitAmount FLOAT %DESCRIPTION 'The total limit available for the limit level and limit type. While the attribute is of type integer in the CME schema, it has been specified to be of type number in the CDM to take into consideration java size limits as well as for consistency purposes with the way most monetary amounts are expressed.',
    limitImpactDueToTrade FLOAT %DESCRIPTION 'The limit utilized by this specific trade. While the attribute is of type integer in the CME schema, it has been specified to be of type number in the CDM to take into consideration java size limits as well as for consistency purposes with the way most monetary amounts are expressed.',
    limitType VARCHAR(255) %DESCRIPTION 'Standard code to indicate which type of credit line is being referred to - i.e. IM, DV01, PV01, CS01, Notional, Clip Size, Notional, maximumOrderQuantity.',
    clipSize INT %DESCRIPTION 'This element is required in FpML, optional in CDM for the purpose of accommodating the CME data representation while making reference to the FpML one.',
    amountUtilized FLOAT %DESCRIPTION 'The limit utilised by all the cleared trades for the limit level and limit type. While the attribute is of type integer in FpML and the CME schema, it has been specified to be of type number in the CDM to take into consideration java size limits as well as for consistency purposes with the way most monetary amounts are expressed.',
    utilization VARCHAR(255),
    amountRemaining FLOAT %DESCRIPTION 'The limit remaining for the limit level and limit type. This does not take into account any pending trades. While the attribute is of type integer in FpML and the CME schema, it has been specified to be of type number in the CDM to take into consideration java size limits as well as for consistency purposes with the way most monetary amounts are expressed.',
    currency VARCHAR(255) %DESCRIPTION 'The currency in which the applicable limit is denominated. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    velocity VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.PaymentCalculationPeriod_calculationPeriod (
    PaymentCalculationPeriod_id INT NOT NULL,
    CalculationPeriod_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.PaymentCalculationPeriod (
    PaymentCalculationPeriod_id INT UNIQUE NOT NULL,
    unadjustedPaymentDate VARCHAR(255) %DESCRIPTION 'The unadjusted payment date.',
    adjustedPaymentDate VARCHAR(255) %DESCRIPTION 'The adjusted payment date. This date should already be adjusted for any applicable business day convention. This component is not intended for use in trade confirmation but may be specified to allow the fee structure to also serve as a cashflow type component.',
    calculationPeriod INT NOT NULL %DESCRIPTION 'The parameters used in the calculation of a fixed or floating rate calculation period amount. A list of calculation period elements may be ordered in the document by ascending start date. An FpML document which contains an unordered list of calculation periods is still regarded as a conformant document.',
    fixedPaymentAmount VARCHAR(255) %DESCRIPTION 'A known fixed payment amount.',
    discountFactor FLOAT %DESCRIPTION 'A decimal value representing the discount factor used to calculate the present value of cash flow.',
    forecastPaymentAmount VARCHAR(255) %DESCRIPTION 'A monetary amount representing the forecast of the future value of the payment.',
    presentValueAmount VARCHAR(255) %DESCRIPTION 'A monetary amount representing the present value of the forecast payment.'
);

CREATE TABLE cdm_product_template.Payout_interestRatePayout (
    Payout_id INT NOT NULL,
    InterestRatePayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_optionPayout (
    Payout_id INT NOT NULL,
    OptionPayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_commodityPayout (
    Payout_id INT NOT NULL,
    CommodityPayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_forwardPayout (
    Payout_id INT NOT NULL,
    ForwardPayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_fixedPricePayout (
    Payout_id INT NOT NULL,
    FixedPricePayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_securityPayout (
    Payout_id INT NOT NULL,
    SecurityPayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_cashflow (
    Payout_id INT NOT NULL,
    Cashflow_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_performancePayout (
    Payout_id INT NOT NULL,
    PerformancePayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout_assetPayout (
    Payout_id INT NOT NULL,
    AssetPayout_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Payout (
    Payout_id INT UNIQUE NOT NULL,
    interestRatePayout INT NOT NULL %DESCRIPTION 'All of the terms necessary to define and calculate a cash flow based on a fixed, a floating or an inflation index rate. The interest rate payout can be applied to interest rate swaps and FRA (which both have two associated interest rate payouts), credit default swaps (to represent the fee leg when subject to periodic payments) and equity swaps (to represent the funding leg).',
    creditDefaultPayout VARCHAR(255) %DESCRIPTION 'The credit default payout, which provides the details necessary for determining when a credit payout will be triggered as well as the parameters for calculating the payout and the settlement terms.',
    optionPayout INT NOT NULL %DESCRIPTION 'The option payout.',
    commodityPayout INT NOT NULL %DESCRIPTION 'Defines the payout for the floating leg of a Commodity Swap.',
    forwardPayout INT NOT NULL %DESCRIPTION 'Represents a forward settling payout. The ''Underlier'' attribute captures the underlying payout, which is settled according to the ''SettlementTerms'' attribute. Both FX Spot and FX Forward should use this component.',
    fixedPricePayout INT NOT NULL %DESCRIPTION 'Defines a payout in which one or more payouts are defined as a fixed price.',
    securityPayout INT NOT NULL %DESCRIPTION 'The security payout when the product involves some form of securities, such as collateral in a securities financing transaction',
    cashflow INT NOT NULL %DESCRIPTION 'A cashflow between the parties to the trade. For interest rate and equity products, this corresponds to the FpML additionalPayment element. For credit default swaps, this corresponds to the FpML initialPayment element and the singlePayment element of the fee leg. For option products, it represents the FpML premium element.',
    performancePayout INT NOT NULL %DESCRIPTION 'The performance payout, which encompasses the equity price returns, dividend returns, volatility return, variance return and correlation provisions.',
    assetPayout INT NOT NULL %DESCRIPTION 'The security payout when the product involves some form of securities, such as collateral in a securities financing transaction'
);

CREATE TABLE cdm_base_datetime.BusinessCenterEnum (
    BusinessCenterEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.ObservationInstruction (
    ObservationInstruction_id INT UNIQUE NOT NULL,
    observationEvent VARCHAR(255) NOT NULL %DESCRIPTION 'Contains all information related to an observation.'
);

CREATE TABLE cdm_product_collateral.DistributionAndInterestPayment_interestParameters (
    DistributionAndInterestPayment_id INT NOT NULL,
    CollateralInterestParameters_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.DistributionAndInterestPayment (
    DistributionAndInterestPayment_id INT UNIQUE NOT NULL,
    interestParameters INT NOT NULL %DESCRIPTION 'Represents the interest parameters for the various currencies, margin types, posting parties.'
);

CREATE TABLE cdm_product_common_settlement.DeliverableObligations (
    DeliverableObligations_id INT UNIQUE NOT NULL,
    accruedInterest INT %DESCRIPTION 'Indicates whether accrued interest is included (true) or not (false). For cash settlement this specifies whether quotations should be obtained inclusive or not of accrued interest. For physical settlement this specifies whether the buyer should deliver the obligation with an outstanding principal balance that includes or excludes accrued interest. ISDA 2003 Term: Include/Exclude Accrued Interest.',
    category VARCHAR(255) %DESCRIPTION 'Used in both obligations and deliverable obligations to represent a class or type of securities which apply. ISDA 2003 Term: Obligation Category/Deliverable Obligation Category.',
    notSubordinated INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. An obligation that ranks at least equal with the most senior Reference Obligation in priority of payment or, if no Reference Obligation is specified in the related Confirmation, the obligations of the Reference Entity that are senior. ISDA 2003 Term: Not Subordinated.',
    specifiedCurrency VARCHAR(255) %DESCRIPTION 'An obligation and deliverable obligation characteristic. The currency or currencies in which an obligation or deliverable obligation must be payable. ISDA 2003 Term: Specified Currency.',
    notSovereignLender INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Any obligation that is not primarily (majority) owed to a Sovereign or Supranational Organisation. ISDA 2003 Term: Not Sovereign Lender.',
    notDomesticCurrency VARCHAR(255) %DESCRIPTION 'An obligation and deliverable obligation characteristic. Any obligation that is payable in any currency other than the domestic currency. Domestic currency is either the currency so specified or, if no currency is specified, the currency of (a) the reference entity, if the reference entity is a sovereign, or (b) the jurisdiction in which the relevant reference entity is organised, if the reference entity is not a sovereign. ISDA 2003 Term: Not Domestic Currency.',
    notDomesticLaw INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. If the reference entity is a Sovereign, this means any obligation that is not subject to the laws of the reference entity. If the reference entity is not a sovereign, this means any obligation that is not subject to the laws of the jurisdiction of the reference entity. ISDA 2003 Term: Not Domestic Law.',
    listed INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Indicates whether or not the obligation is quoted, listed or ordinarily purchased and sold on an exchange. ISDA 2003 Term: Listed.',
    notContingent INT %DESCRIPTION 'A deliverable obligation characteristic. In essence Not Contingent means the repayment of principal cannot be dependant on a formula/index, i.e. to prevent the risk of being delivered an instrument that may never pay any element of principal, and to ensure that the obligation is interest bearing (on a regular schedule). ISDA 2003 Term: Not Contingent.',
    notDomesticIssuance INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Any obligation other than an obligation that was intended to be offered for sale primarily in the domestic market of the relevant Reference Entity. This specifies that the obligation must be an internationally recognised bond. ISDA 2003 Term: Not Domestic Issuance.',
    assignableLoan VARCHAR(255) %DESCRIPTION 'A deliverable obligation characteristic. A loan that is freely assignable to a bank or financial institution without the consent of the Reference Entity or the guarantor, if any, of the loan (or the consent of the applicable borrower if a Reference Entity is guaranteeing the loan) or any agent. ISDA 2003 Term: Assignable Loan.',
    consentRequiredLoan VARCHAR(255) %DESCRIPTION 'A deliverable obligation characteristic. A loan that is capable of being assigned with the consent of the Reference Entity or the guarantor, if any, of the loan or any agent. ISDA 2003 Term: Consent Required Loan.',
    directLoanParticipation VARCHAR(255) %DESCRIPTION 'A deliverable obligation characteristic. A loan with a participation agreement whereby the buyer is capable of creating, or procuring the creation of, a contractual right in favour of the seller that provides the seller with recourse to the participation seller for a specified share in any payments due under the relevant loan which are received by the participation seller. ISDA 2003 Term: Direct Loan Participation.',
    transferable INT %DESCRIPTION 'A deliverable obligation characteristic. An obligation that is transferable to institutional investors without any contractual, statutory or regulatory restrictions. ISDA 2003 Term: Transferable.',
    maximumMaturity VARCHAR(255) %DESCRIPTION 'A deliverable obligation characteristic. An obligation that has a remaining maturity from the Physical Settlement Date of not greater than the period specified. ISDA 2003 Term: Maximum Maturity.',
    acceleratedOrMatured INT %DESCRIPTION 'A deliverable obligation characteristic. An obligation at time of default is due to mature and due to be repaid, or as a result of downgrade/bankruptcy is due to be repaid as a result of an acceleration clause. ISDA 2003 Term: Accelerated or Matured.',
    notBearer INT %DESCRIPTION 'A deliverable obligation characteristic. Any obligation that is not a bearer instrument. This applies to Bonds only and is meant to avoid tax, fraud and security/delivery provisions that can potentially be associated with Bearer Bonds. ISDA 2003 Term: Not Bearer.',
    fullFaithAndCreditObLiability INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published additional provisions for U.S. Municipal as Reference Entity. ISDA 2003 Term: Full Faith and Credit Obligation Liability.',
    generalFundObligationLiability INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published additional provisions for U.S. Municipal as Reference Entity. ISDA 2003 Term: General Fund Obligation Liability.',
    revenueObligationLiability INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published additional provisions for U.S. Municipal as Reference Entity. ISDA 2003 Term: Revenue Obligation Liability.',
    indirectLoanParticipation VARCHAR(255) %DESCRIPTION 'ISDA 1999 Term: Indirect Loan Participation. NOTE: Only applicable as a deliverable obligation under ISDA Credit 1999.',
    excluded VARCHAR(255) %DESCRIPTION 'A free format string to specify any excluded obligations or deliverable obligations, as the case may be, of the reference entity or excluded types of obligations or deliverable obligations. ISDA 2003 Term: Excluded Obligations/Excluded Deliverable Obligations.',
    othReferenceEntityObligations VARCHAR(255) %DESCRIPTION 'This element is used to specify any other obligations of a reference entity in both obligations and deliverable obligations. The obligations can be specified free-form. ISDA 2003 Term: Other Obligations of a Reference Entity.'
);

CREATE TABLE cdm_event_common.ObservationEvent (
    ObservationEvent_id INT UNIQUE NOT NULL,
    creditEvent VARCHAR(255) %DESCRIPTION 'Specifies the necessary information to create a credit event.',
    corporateAction VARCHAR(255) %DESCRIPTION 'Specifies the necessary information to create a corporate action.'
);

CREATE TABLE cdm_product_asset.BoundedVariance (
    BoundedVariance_id INT UNIQUE NOT NULL,
    realisedVarianceMethod VARCHAR(255) NOT NULL %DESCRIPTION 'The contract specifies which price must satisfy the boundary condition.',
    daysInRangeAdjustment INT NOT NULL %DESCRIPTION 'The contract specifies whether the notional should be scaled by the Number of Days in Range divided by the Expected N. The number of Days in Ranges refers to the number of returns that contribute to the realized volatility.',
    upperBarrier FLOAT %DESCRIPTION 'All observations above this price level will be excluded from the variance calculation.',
    lowerBarrier FLOAT %DESCRIPTION 'All observations below this price level will be excluded from the variance calculation.'
);

CREATE TABLE cdm_observable_asset.ObservationSource (
    ObservationSource_id INT UNIQUE NOT NULL,
    curve VARCHAR(255),
    informationSource VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.PremiumTypeEnum (
    PremiumTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.PhysicalSettlementPeriod (
    PhysicalSettlementPeriod_id INT UNIQUE NOT NULL,
    businessDaysNotSpecified INT %DESCRIPTION 'An explicit indication that a number of business days are not specified and therefore ISDA fallback provisions should apply.',
    businessDays INT %DESCRIPTION 'A number of business days. Its precise meaning is dependant on the context in which this element is used. ISDA 2003 Term: Business Day.',
    maximumBusinessDays INT %DESCRIPTION 'A maximum number of business days. Its precise meaning is dependant on the context in which this element is used. Intended to be used to limit a particular ISDA fallback provision.'
);

CREATE TABLE cdm_product_template.Composite (
    Composite_id INT UNIQUE NOT NULL,
    determinationMethod VARCHAR(255) %DESCRIPTION 'Specifies the method according to which an amount or a date is determined.',
    relativeDate VARCHAR(255) %DESCRIPTION 'A date specified as some offset to another date (the anchor date).',
    fxSpotRateSource VARCHAR(255) %DESCRIPTION 'Specifies the methodology (reference source and, optionally, fixing time) to be used for determining a currency conversion rate.',
    fixingTime VARCHAR(255) %DESCRIPTION 'The time at which the spot currency exchange rate will be observed. It is specified as a time in a business day calendar location, e.g. 11:00am London time.'
);

CREATE TABLE cdm_base_staticdata_asset_common.AssetType_otherAssetType (
    AssetType_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.AssetType (
    AssetType_id INT UNIQUE NOT NULL,
    assetType VARCHAR(255) NOT NULL %DESCRIPTION 'Represents a filter based on the type of collateral asset.',
    securityType VARCHAR(255) %DESCRIPTION 'Represents a filter based on the type of security.',
    debtType VARCHAR(255) %DESCRIPTION 'Represents a filter based on the type of bond.',
    equityType VARCHAR(255) %DESCRIPTION 'Represents a filter based on the type of equity.',
    fundType VARCHAR(255) %DESCRIPTION 'Represents a filter based on the type of fund.',
    otherAssetType INT NOT NULL %DESCRIPTION 'Specifies the eligible asset type when not enumerated.'
);

CREATE TABLE cdm_product_collateral.IndependentAmount_paymentDetail (
    IndependentAmount_id INT NOT NULL,
    PaymentDetail_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.IndependentAmount (
    IndependentAmount_id INT UNIQUE NOT NULL,
    paymentDetail INT NOT NULL %DESCRIPTION 'An attribute that specifies a payment as the combination of a payment amount, a payment date and an associated payment calculation rule.',
    payerPartyReference VARCHAR(255) %DESCRIPTION 'The party responsible for making the payments defined by this structure.',
    payerAccountReference VARCHAR(255) %DESCRIPTION 'A reference to the account responsible for making the payments defined by this structure.',
    receiverPartyReference VARCHAR(255) %DESCRIPTION 'The party that receives the payments corresponding to this structure.',
    receiverAccountReference VARCHAR(255) %DESCRIPTION 'A reference to the account that receives the payments corresponding to this structure.'
);

CREATE TABLE cdm_base_staticdata_asset_common.QuasiGovernmentIssuerType (
    QuasiGovernmentIssuerType_id INT UNIQUE NOT NULL,
    sovereignEntity INT NOT NULL %DESCRIPTION 'True if sovereign entity (e.g. not separate legal personality from sovereign) or false if non-sovereign entity (e.g. separate legal personality from sovereign).',
    sovereignRecourse INT %DESCRIPTION 'Applies to non-sovereign entity (e.g. separate legal personality from sovereign).  True if entity has recourse to sovereign (e.g. debt guaranteed by government).  False if entity does not have recourse to sovereign.'
);

CREATE TABLE cdm_product_asset.BondReference (
    BondReference_id INT UNIQUE NOT NULL,
    bond VARCHAR(255) NOT NULL %DESCRIPTION 'Reference to a bond underlier.',
    conditionPrecedentBond INT NOT NULL %DESCRIPTION 'To indicate whether the Condition Precedent Bond is applicable. The swap contract is only valid if the bond is issued and if there is any dispute over the terms of fixed stream then the bond terms would be used.',
    discrepancyClause INT %DESCRIPTION 'To indicate whether the Discrepancy Clause is applicable.',
    couponRate VARCHAR(255) %DESCRIPTION 'Specifies the coupon rate (expressed in percentage) of a fixed income security or convertible bond.'
);

CREATE TABLE cdm_product_common_settlement_metafields.ReferenceWithMetaSettlementTerms (
    ReferenceWithMetaSettlementTerms_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.ResetRelativeToEnum (
    ResetRelativeToEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_identifier.Identifier_assignedIdentifier (
    Identifier_id INT NOT NULL,
    AssignedIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_identifier.Identifier (
    Identifier_id INT UNIQUE NOT NULL,
    issuerReference VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified by reference to a party specified as part of the transaction.',
    issuer VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified explicitly alongside the identifier value (instead of being specified by reference to a party).',
    assignedIdentifier INT NOT NULL %DESCRIPTION 'The identifier value. This level of indirection between the issuer and the identifier and its version provides the ability to associate multiple identifiers to one issuer, consistently with the FpML PartyTradeIdentifier.'
);

CREATE TABLE cdm_base_staticdata_asset_common.ISOCurrencyCodeEnum (
    ISOCurrencyCodeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.DateRange (
    DateRange_id INT UNIQUE NOT NULL,
    startDate VARCHAR(255) NOT NULL %DESCRIPTION 'The first date of a date range.',
    endDate VARCHAR(255) NOT NULL %DESCRIPTION 'The last date of a date range.'
);

CREATE TABLE cdm_base_staticdata_party.PartyIdentifierTypeEnum (
    PartyIdentifierTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.ReferenceSwapCurve (
    ReferenceSwapCurve_id INT UNIQUE NOT NULL,
    swapUnwindValue VARCHAR(255) NOT NULL,
    makeWholeAmount VARCHAR(255) %DESCRIPTION 'Amount to be paid by the buyer of the option if the option is exercised prior to the Early Call Date. (The market practice in the convertible bond option space being that the buyer should be penalised if he/she exercises the option early on.)'
);

CREATE TABLE cdm_observable_asset.CsaTypeEnum (
    CsaTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset_floatingrate.FloatingRateProcessingDetails (
    FloatingRateProcessingDetails_id INT UNIQUE NOT NULL,
    rawRate FLOAT NOT NULL %DESCRIPTION 'The raw or untreated rate, prior to any of the rate treatments.',
    processingParameters VARCHAR(255),
    processedRate FLOAT NOT NULL %DESCRIPTION 'The value of the rate after processing.',
    spreadExclusiveRate FLOAT NOT NULL %DESCRIPTION 'The value of the processed rate without the spread applied, for subsequent compounding, etc.'
);

CREATE TABLE cdm_product_template.TradeLot_lotIdentifier (
    TradeLot_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.TradeLot_priceQuantity (
    TradeLot_id INT NOT NULL,
    PriceQuantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.TradeLot (
    TradeLot_id INT UNIQUE NOT NULL,
    lotIdentifier INT NOT NULL %DESCRIPTION 'Specifies one or more identifiers for the lot, if any.',
    priceQuantity INT NOT NULL %DESCRIPTION 'Specifies the settlement characteristics of a trade lot: price, quantity, observable (optionally) and the settlement terms. This attribute has a multiple cardinality to allow to specify the price, quantity and observable of different legs in a single, composite product (e.g. a Swap).'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaCreditNotation (
    FieldWithMetaCreditNotation_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_regulation.Document (
    Document_id INT UNIQUE NOT NULL,
    finInstrmRptgTxRpt VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_datetime.RoundingFrequencyEnum (
    RoundingFrequencyEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.AutomaticExercise (
    AutomaticExercise_id INT UNIQUE NOT NULL,
    thresholdRate FLOAT %DESCRIPTION 'A threshold rate. The threshold of 0.10% would be represented as 0.001',
    isApplicable INT %DESCRIPTION 'Boolean that indicates if it has an automaticExercise'
);

CREATE TABLE cdm_event_common.CounterpartyPositionState_observationHistory (
    CounterpartyPositionState_id INT NOT NULL,
    ObservationEvent_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CounterpartyPositionState_valuationHistory (
    CounterpartyPositionState_id INT NOT NULL,
    Valuation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CounterpartyPositionState (
    CounterpartyPositionState_id INT UNIQUE NOT NULL,
    counterpartyPosition VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the Position that has been effected by a business or life-cycle event.',
    state VARCHAR(255) %DESCRIPTION 'Represents the State of the Position through its life-cycle.',
    observationHistory INT NOT NULL %DESCRIPTION 'Represents the observed events related to a particular product or process, such as credit events or corporate actions.',
    valuationHistory INT NOT NULL
);

CREATE TABLE cdm_observable_asset.PremiumExpression (
    PremiumExpression_id INT UNIQUE NOT NULL,
    premiumType VARCHAR(255) %DESCRIPTION 'Forward start premium type',
    pricePerOption VARCHAR(255) %DESCRIPTION 'The amount of premium to be paid expressed as a function of the number of options.',
    percentageOfNotional FLOAT %DESCRIPTION 'The amount of premium to be paid expressed as a percentage of the notional value of the transaction. A percentage of 5% would be expressed as 0.05.'
);

CREATE TABLE cdm_event_common.TransferState (
    TransferState_id INT UNIQUE NOT NULL,
    transfer VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the Transfer that has been effected by a business or life-cycle event.',
    transferStatus VARCHAR(255) %DESCRIPTION 'Represents the State of the Transfer through its life-cycle.'
);

CREATE TABLE cdm_product_template.AveragingCalculation (
    AveragingCalculation_id INT UNIQUE NOT NULL,
    averagingMethod VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies enumerations for the type of averaging calculation.',
    precision VARCHAR(255) NOT NULL %DESCRIPTION 'Rounding applied to the average calculation. '
);

CREATE TABLE cdm_product_asset.BankHolidayTreatmentEnum (
    BankHolidayTreatmentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.Trade_tradeIdentifier (
    Trade_id INT NOT NULL,
    TradeIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Trade_party (
    Trade_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Trade_partyRole (
    Trade_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Trade_account (
    Trade_id INT NOT NULL,
    Account_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Trade (
    Trade_id INT UNIQUE NOT NULL,
    tradeIdentifier INT NOT NULL %DESCRIPTION 'Represents the identifier(s) that uniquely identify a trade for an identity issuer. A trade can include multiple identifiers, for example a trade that is reportable to both the CFTC and ESMA, and then has an associated USI (Unique Swap Identifier) UTI (Unique Trade Identifier).',
    tradeDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the date which the trade was agreed.',
    tradeTime VARCHAR(255) %DESCRIPTION 'Denotes the trade time and timezone as agreed by the parties to the trade.',
    tradableProduct VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the financial instrument The corresponding FpML construct is the product abstract element and the associated substitution group.',
    party INT NOT NULL %DESCRIPTION 'Represents the parties to the trade. The cardinality is optional to address the case where the trade is defined within a BusinessEvent data type, in which case the party is specified in BusinessEvent.',
    partyRole INT NOT NULL %DESCRIPTION 'Represents the role each specified party takes in the trade. further to the principal roles, payer and receiver.',
    executionDetails VARCHAR(255) %DESCRIPTION 'Represents information specific to trades that arose from executions.',
    contractDetails VARCHAR(255) %DESCRIPTION 'Represents information specific to trades involving contractual products.',
    clearedDate VARCHAR(255) %DESCRIPTION 'Specifies the date on which a trade is cleared (novated) through a central counterparty clearing service.',
    collateral VARCHAR(255) %DESCRIPTION 'Represents the collateral obligations of a party.',
    account INT NOT NULL %DESCRIPTION 'Represents a party''s granular account information, which may be used in subsequent internal processing.'
);

CREATE TABLE cdm_legaldocumentation_common.UmbrellaAgreement_parties (
    UmbrellaAgreement_id INT NOT NULL,
    UmbrellaAgreementEntity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.UmbrellaAgreement (
    UmbrellaAgreement_id INT UNIQUE NOT NULL,
    isApplicable INT NOT NULL %DESCRIPTION 'The determination of whether Umbrella Agreement terms are Applicable (True), or Not Applicable (False)',
    language VARCHAR(255) %DESCRIPTION 'The language associated with the umbrella agreement, and which applies to all the parties to the umbrella agreement.',
    parties INT NOT NULL %DESCRIPTION 'Underlying principals to the umbrella agreement.'
);

CREATE TABLE cdm_product_asset.ValuationTerms (
    ValuationTerms_id INT UNIQUE NOT NULL,
    futuresPriceValuation INT %DESCRIPTION 'The official settlement price as announced by the related exchange is applicable, in accordance with the ISDA 2002 definitions.',
    optionsPriceValuation INT %DESCRIPTION 'The official settlement price as announced by the related exchange is applicable, in accordance with the ISDA 2002 definitions',
    numberOfValuationDates INT %DESCRIPTION 'The number of valuation dates between valuation start date and valuation end date.',
    dividendValuationDates VARCHAR(255) %DESCRIPTION 'Specifies the dividend valuation dates of the swap.',
    fPVFinalPriceElectionFallback VARCHAR(255) %DESCRIPTION 'Specifies the fallback provisions for Hedging Party in the determination of the Final Price.',
    multipleExchangeIndexAnnexFallback INT %DESCRIPTION 'For an index option transaction, a flag to indicate whether a relevant Multiple Exchange Index Annex is applicable to the transaction. This annex defines additional provisions which are applicable where an index is comprised of component securities that are traded on multiple exchanges.',
    componentSecurityIndexAnnexFallback INT %DESCRIPTION 'For an index option transaction, a flag to indicate whether a relevant Component Security Index Annex is applicable to the transaction.'
);

CREATE TABLE cdm_base_staticdata_party.PayerReceiverEnum (
    PayerReceiverEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.CalculationPeriodFrequency (
    CalculationPeriodFrequency_id INT UNIQUE NOT NULL,
    rollConvention VARCHAR(255) NOT NULL %DESCRIPTION 'The roll convention specifies the period term as part of a periodic schedule, i.e. the calculation period end date within the regular part of the calculation period. The value could be a rule, e.g. IMM Settlement Dates, which is the 3rd Wednesday of the month, or it could be a specific day of the month, such as the first day of the applicable month. It is used in conjunction with a frequency and the regular period start date of a calculation period.',
    balanceOfFirstPeriod INT %DESCRIPTION 'Indicates, when true, that that the first Calculation Period should run from the Effective Date to the end of the calendar period in which the Effective Date falls, e.g. Jan 15 - Jan 31 if the calculation periods are one month long and Effective Date is Jan 15. If false, the first Calculation Period should run from the Effective Date for one whole period, e.g. Jan 15 to Feb 14 if the calculation periods are one month long and Effective Date is Jan 15. Mostly used in Commmodity Swaps.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2, or 3. If the period value is T (Term) then period multiplier must contain the value 1.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month, year or term of the stream.'
);

CREATE TABLE cdm_event_common.CalculateTransferInstruction_resets (
    CalculateTransferInstruction_id INT NOT NULL,
    Reset_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.CalculateTransferInstruction (
    CalculateTransferInstruction_id INT UNIQUE NOT NULL,
    tradeState VARCHAR(255) NOT NULL,
    payout VARCHAR(255) NOT NULL,
    resets INT NOT NULL,
    payerReceiver VARCHAR(255),
    quantity VARCHAR(255) %DESCRIPTION 'Specifies quantity amount returned if not the full amount from the TradeState, e.g. partial return',
    date VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.FxSpotRateSource (
    FxSpotRateSource_id INT UNIQUE NOT NULL,
    primarySource VARCHAR(255) NOT NULL %DESCRIPTION 'The primary source for where the rate observation will occur. Will typically be either a page or a reference bank published rate.',
    secondarySource VARCHAR(255) %DESCRIPTION 'An alternative, or secondary, source for where the rate observation will occur. Will typically be either a page or a reference bank published rate.'
);

CREATE TABLE cdm_event_common.TermsChangeInstruction_ancillaryParty (
    TermsChangeInstruction_id INT NOT NULL,
    AncillaryParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TermsChangeInstruction (
    TermsChangeInstruction_id INT UNIQUE NOT NULL,
    product VARCHAR(255) %DESCRIPTION 'product to be changed',
    ancillaryParty INT NOT NULL %DESCRIPTION 'ancillary party to be changed',
    adjustment VARCHAR(255)
);

CREATE TABLE cdm_product_asset.FixedRateSpecification (
    FixedRateSpecification_id INT UNIQUE NOT NULL,
    rateSchedule VARCHAR(255) %DESCRIPTION 'The fixed rate or fixed rate schedule expressed as explicit fixed rates and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments.'
);

CREATE TABLE cdm_observable_asset_fro.FloatingRateIndexDefinition (
    FloatingRateIndexDefinition_id INT UNIQUE NOT NULL,
    fro VARCHAR(255) NOT NULL %DESCRIPTION 'The underlying FRO name and designated maturity.',
    calculationDefaults VARCHAR(255) %DESCRIPTION 'Any calculation default values.'
);

CREATE TABLE cdm_product_collateral.CollateralTreatment_concentrationLimit (
    CollateralTreatment_id INT NOT NULL,
    ConcentrationLimit_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralTreatment (
    CollateralTreatment_id INT UNIQUE NOT NULL,
    valuationTreatment VARCHAR(255) %DESCRIPTION 'Specification of the valuation treatment for the specified collateral.',
    concentrationLimit INT NOT NULL %DESCRIPTION 'Specification of concentration limits applicable to the collateral criteria.',
    isIncluded INT NOT NULL %DESCRIPTION 'A boolean attribute to specify whether collateral critieria are inclusion (True) or exclusion (False) criteria.'
);

CREATE TABLE cdm_event_common.CreditEventTypeEnum (
    CreditEventTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.MoneyMarketTypeEnum (
    MoneyMarketTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_master.MasterAgreementVariantIdentifierEnum (
    MasterAgreementVariantIdentifierEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.AdjustableDate (
    AdjustableDate_id INT UNIQUE NOT NULL,
    unadjustedDate VARCHAR(255) %DESCRIPTION 'A date subject to adjustment. While in FpML this date is required, this cardinality constraint has been relaxed as part of the CDM in order to support the FRA representation, which effective and termination dates are specified in FpML as adjusted dates.',
    dateAdjustments VARCHAR(255) %DESCRIPTION 'The business day convention and financial business centers used for adjusting the date if it would otherwise fall on a day that is not a business date in the specified business centers.',
    dateAdjustmentsReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to date adjustments defined elsewhere in the document.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).'
);

CREATE TABLE cdm_product_asset.FieldWithMetaIndexAnnexSourceEnum (
    FieldWithMetaIndexAnnexSourceEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_party.AncillaryParty_partyReference (
    AncillaryParty_id INT NOT NULL,
    ReferenceWithMetaParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.AncillaryParty (
    AncillaryParty_id INT UNIQUE NOT NULL,
    role VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the AncillaryRoleEnum that is associated to the party reference. An ancillary party is any involved party that is not one of the two principal parties to the transaction.',
    partyReference INT NOT NULL %DESCRIPTION 'Specifies the party, or parties, associated to the ancillary role.',
    onBehalfOf VARCHAR(255) %DESCRIPTION 'Optionally specifies the counterparty that the ancillary party is acting on behalf of.'
);

CREATE TABLE cdm_observable_asset.DividendApplicability (
    DividendApplicability_id INT UNIQUE NOT NULL,
    optionsExchangeDividends INT %DESCRIPTION 'If present and true, then options exchange dividends are applicable.',
    additionalDividends INT %DESCRIPTION 'If present and true, then additional dividends are applicable.',
    allDividends INT %DESCRIPTION 'Represents the European Master Confirmation value of ''All Dividends'' which, when applicable, signifies that, for a given Ex-Date, the daily observed Share Price for that day is adjusted (reduced) by the cash dividend and/or the cash value of any non cash dividend per Share (including Extraordinary Dividends) declared by the Issuer. All Dividends in accordance with the ISDA 2002 Equity Derivatives Definitions.'
);

CREATE TABLE cdm_observable_asset.PriceOperandEnum (
    PriceOperandEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.TransferExpression (
    TransferExpression_id INT UNIQUE NOT NULL,
    priceTransfer VARCHAR(255) %DESCRIPTION 'Specifies a transfer amount exchanged as a price or fee for entering into a Business Event, e.g. Premium, Termination fee, Novation fee.',
    scheduledTransfer VARCHAR(255) %DESCRIPTION 'Specifies a transfer created from a scheduled or contingent event on a contract, e.g. Exercise, Performance, Credit Event'
);

CREATE TABLE cdm_base_staticdata_asset_common.ISOCountryCodeEnum (
    ISOCountryCodeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.Offset (
    Offset_id INT UNIQUE NOT NULL,
    dayType VARCHAR(255) %DESCRIPTION 'In the case of an offset specified as a number of days, this element defines whether consideration is given as to whether a day is a good business day or not. If a day type of business days is specified then non-business days are ignored when calculating the offset. The financial business centers to use for determination of business days are implied by the context in which this element is used. This element must only be included when the offset is specified as a number of days. If the offset is zero days then the dayType element should not be included.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2 or 3 etc. A negative value can be used when specifying an offset relative to another date, e.g. -2 days.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month or year of the stream. If the periodMultiplier value is 0 (zero) then period must contain the value D (day).'
);

CREATE TABLE cdm_event_common.ResetInstruction (
    ResetInstruction_id INT UNIQUE NOT NULL,
    payout VARCHAR(255) NOT NULL,
    rateRecordDate VARCHAR(255) %DESCRIPTION 'Specifies the ''Rate Record Day'' for a Fallback rate.  Fallback rate fixing processes typically set the fixing rate in arrears, i.e., the Fallback Rate corresponding to a Rate Record Date is set at the end of the interest accural period.  When this applies, Reset->resetDate occurs at the end of the interest period, and the Reset->rateRecordDate occurs near the start of the interest period.  The Reset->rateRecordDate and Reset->observations->observationIdentifier->observationDate will differ if a Fallback rate is unavailable on the Rate Record Date, and the latest previous available rate is used as the observation.',
    resetDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the date on which the reset is occuring.'
);

CREATE TABLE cdm_base_staticdata_party.FieldWithMetaEntityTypeEnum (
    FieldWithMetaEntityTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_common.MatrixTypeEnum (
    MatrixTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset_calculatedrate.InflationCalculationMethodEnum (
    InflationCalculationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_collateral.ConcentrationLimitCriteria_issuer (
    ConcentrationLimitCriteria_id INT NOT NULL,
    IssuerCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.ConcentrationLimitCriteria_asset (
    ConcentrationLimitCriteria_id INT NOT NULL,
    AssetCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.ConcentrationLimitCriteria_appliesTo (
    ConcentrationLimitCriteria_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.ConcentrationLimitCriteria (
    ConcentrationLimitCriteria_id INT UNIQUE NOT NULL,
    concentrationLimitType VARCHAR(255) %DESCRIPTION 'Specifies the type of concentration limit to be applied.',
    averageTradingVolume VARCHAR(255) %DESCRIPTION 'Specifies an average trading volume on an exchange in relation to Equity products.',
    issuer INT NOT NULL %DESCRIPTION 'Represents a filter based criteria related to the issuer.',
    asset INT NOT NULL %DESCRIPTION 'Represents a filter based on the criteria related to the asset.',
    appliesTo INT NOT NULL %DESCRIPTION 'Specifies which of the two counterparties the criteria applies to (either one or both counterparties). This attribute is optional, in case the applicable party is already specified elsewhere within a party election.'
);

CREATE TABLE cdm_base_datetime.BusinessCenterTime (
    BusinessCenterTime_id INT UNIQUE NOT NULL,
    hourMinuteTime VARCHAR(255) NOT NULL %DESCRIPTION 'A time specified in hh:mm:ss format where the second component must be ''00'', e.g. 11am would be represented as 11:00:00.',
    businessCenter VARCHAR(255) NOT NULL %DESCRIPTION 'A code identifying a business day calendar location. A business day calendar location is drawn from the list identified by the business day calendar location enumeration.'
);

CREATE TABLE cdm_product_common_schedule.ObservationSchedule_observationDate (
    ObservationSchedule_id INT NOT NULL,
    ObservationDate_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.ObservationSchedule (
    ObservationSchedule_id INT UNIQUE NOT NULL,
    observationDate INT NOT NULL %DESCRIPTION 'Specifies an adjusted or unadjusted date for a market observation.',
    dateAdjustments VARCHAR(255) %DESCRIPTION 'The business day convention and financial business centers used for adjusting the date if it would otherwise fall on a day that is not a business date in the specified business centers.'
);

CREATE TABLE cdm_product_template.BermudaExercise (
    BermudaExercise_id INT UNIQUE NOT NULL,
    bermudaExerciseDates VARCHAR(255) NOT NULL %DESCRIPTION 'The dates that define the Bermuda option exercise dates and the expiration date. The last specified date is assumed to be the expiration date. The dates can either be specified as a series of explicit dates and associated adjustments or as a series of dates defined relative to another schedule of dates, for example, the calculation period start dates. Where a relative series of dates are defined the first and last possible exercise dates can be separately specified.',
    relevantUnderlyingDate VARCHAR(255) %DESCRIPTION 'The effective date on the underlying product if the option is exercised.  For example, for a swaption it is the swap effective date, for an option on an FX spot or forward it is the value date for settlement, and in an extendible/cancelable provision it is the swap termination date, which is the date on which the termination is effective.',
    earliestExerciseTime VARCHAR(255) NOT NULL %DESCRIPTION 'The earliest time at which notice of exercise can be given by the buyer to the seller (or seller''s agent) on each Bermuda option exercise date and the expiration date.',
    latestExerciseTime VARCHAR(255) %DESCRIPTION 'For a Bermuda or American style option, the latest time on an exercise business day (excluding the expiration date) within the exercise period that notice can be given by the buyer to the seller or seller''s agent. Notice of exercise given after this time will be deemed to have been given on the next exercise business day.',
    expirationTime VARCHAR(255) NOT NULL %DESCRIPTION 'The latest time for exercise on expirationDate.',
    expirationTimeType VARCHAR(255) %DESCRIPTION 'The time of day at which the equity option expires, for example the official closing time of the exchange.',
    multipleExercise VARCHAR(255) %DESCRIPTION 'As defined in the 2000 ISDA Definitions, Section 12.4. Multiple Exercise, the buyer of the option has the right to exercise all or less than all the unexercised notional amount of the underlying swap on one or more days in the exercise period, but on any such day may not exercise less than the minimum notional amount or more that the maximum notional amount, and if an integral multiple amount is specified, the notional amount exercised must be equal to, or be an integral multiple of, the integral multiple amount.',
    exerciseFeeSchedule VARCHAR(255) %DESCRIPTION 'The fees associated with an exercise date. The fees are conditional on the exercise occurring. The fees can be specified as actual currency amounts or as percentages of the notional amount being exercised.'
);

CREATE TABLE cdm_base_math.Measure (
    Measure_id INT UNIQUE NOT NULL,
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_observable_asset.FloatingRateOption (
    FloatingRateOption_id INT UNIQUE NOT NULL,
    floatingRateIndex VARCHAR(255) %DESCRIPTION 'The reference index that is used to specify the floating interest rate. The FpML standard maintains the list of such indices, which are positioned as enumeration values as part of the CDM.',
    inflationRateIndex VARCHAR(255) %DESCRIPTION 'The reference index that is used to specify the inflation interest rate. The FpML standard maintains the list of such indices, which are positioned as enumeration values as part of the CDM.',
    indexTenor VARCHAR(255) %DESCRIPTION 'The ISDA Designated Maturity, i.e. the floating rate tenor.',
    indexReferenceInformation VARCHAR(255) %DESCRIPTION 'This Attribute contains all the terms relevant to defining an Index.'
);

CREATE TABLE cdm_event_common.Reset_observations (
    Reset_id INT NOT NULL,
    ReferenceWithMetaObservation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Reset (
    Reset_id INT UNIQUE NOT NULL,
    resetValue VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the reset or fixing value. The fixing value could be a cash price, interest rate, or other value.',
    resetDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the date on which the reset occurred.',
    rateRecordDate VARCHAR(255) %DESCRIPTION 'Specifies the ''Rate Record Day'' for a Fallback rate.  Fallback rate fixing processes typically set the fixing rate in arrears, i.e., the Fallback Rate corresponding to a Rate Record Date is set at the end of the interest accural period.  When this applies, Reset->resetDate occurs at the end of the interest period, and the Reset->rateRecordDate occurs near the start of the interest period.  The Reset->rateRecordDate and Reset->observations->observationIdentifier->observationDate will differ if a Fallback rate is unavailable on the Rate Record Date, and the latest previous available rate is used as the observation.',
    observations INT NOT NULL %DESCRIPTION 'Represents an audit of the observations used to produce the reset value. If multiple observations were necessary to produce the reset value, the aggregation method should be defined on the payout.',
    averagingMethodology VARCHAR(255) %DESCRIPTION 'Identifies the aggregation method to use in the case where multiple observations are used to compute the reset value and the method is not defined in a payout.'
);

CREATE TABLE cdm_event_common.RegIMRoleEnum (
    RegIMRoleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common_metafields.ReferenceWithMetaCollateralPortfolio (
    ReferenceWithMetaCollateralPortfolio_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.ExchangeRate_crossRate (
    ExchangeRate_id INT NOT NULL,
    CrossRate_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.ExchangeRate (
    ExchangeRate_id INT UNIQUE NOT NULL,
    crossRate INT NOT NULL %DESCRIPTION 'An optional element that allow for definition of the currency exchange rates used to cross between the traded currencies for non-base currency FX contracts.'
);

CREATE TABLE cdm_event_common.CorporateAction (
    CorporateAction_id INT UNIQUE NOT NULL,
    corporateActionType VARCHAR(255) NOT NULL %DESCRIPTION 'The type of corporate action taking place.',
    exDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the corporate action is known to have taken place.',
    payDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which resulting from the corporate action are delivered.',
    underlier VARCHAR(255) NOT NULL %DESCRIPTION 'The entity impacted by the corporate action.'
);

CREATE TABLE cdm_legaldocumentation_common.AgreementTerms_counterparty (
    AgreementTerms_id INT NOT NULL,
    Counterparty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.AgreementTerms (
    AgreementTerms_id INT UNIQUE NOT NULL,
    agreement VARCHAR(255) NOT NULL %DESCRIPTION 'Specification of the standard set of terms that define a legal agreement.',
    clauseLibrary INT %DESCRIPTION 'Specification of whether the agreement terms have been negotiated using the clause library methodology.',
    counterparty INT NOT NULL %DESCRIPTION 'Specification of the roles of the counterparties to the agreement.'
);

CREATE TABLE cdm_observable_event_metafields.ReferenceWithMetaObservation (
    ReferenceWithMetaObservation_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.Security_productTaxonomy (
    Security_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Security_productIdentifier (
    Security_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Security (
    Security_id INT UNIQUE NOT NULL,
    securityType VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the type of security using an enumerated list.',
    debtType VARCHAR(255) %DESCRIPTION 'Identifies the type of debt and selected debt economics.',
    equityType VARCHAR(255) %DESCRIPTION 'Identifies the type of equity.',
    fundType VARCHAR(255) %DESCRIPTION 'Identifies the type of fund.',
    economicTerms VARCHAR(255) %DESCRIPTION 'The economic terms associated with a contractual product, i.e. the set of features that are price-forming.',
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_base_staticdata_asset_credit.Obligations (
    Obligations_id INT UNIQUE NOT NULL,
    category VARCHAR(255) NOT NULL %DESCRIPTION 'Used in both obligations and deliverable obligations to represent a class or type of securities which apply. ISDA 2003 Term: Obligation Category/Deliverable Obligation Category.',
    notSubordinated INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. An obligation that ranks at least equal with the most senior Reference Obligation in priority of payment or, if no Reference Obligation is specified in the related Confirmation, the obligations of the Reference Entity that are senior. ISDA 2003 Term: Not Subordinated.',
    specifiedCurrency VARCHAR(255) %DESCRIPTION 'An obligation and deliverable obligation characteristic. The currency or currencies in which an obligation or deliverable obligation must be payable. ISDA 2003 Term: Specified Currency.',
    notSovereignLender INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Any obligation that is not primarily (majority) owed to a Sovereign or Supranational Organisation. ISDA 2003 Term: Not Sovereign Lender.',
    notDomesticCurrency VARCHAR(255) %DESCRIPTION 'An obligation and deliverable obligation characteristic. Any obligation that is payable in any currency other than the domestic currency. Domestic currency is either the currency so specified or, if no currency is specified, the currency of (a) the reference entity, if the reference entity is a sovereign, or (b) the jurisdiction in which the relevant reference entity is organised, if the reference entity is not a sovereign. ISDA 2003 Term: Not Domestic Currency.',
    notDomesticLaw INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. If the reference entity is a Sovereign, this means any obligation that is not subject to the laws of the reference entity. If the reference entity is not a sovereign, this means any obligation that is not subject to the laws of the jurisdiction of the reference entity. ISDA 2003 Term: Not Domestic Law.',
    listed INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Indicates whether or not the obligation is quoted, listed or ordinarily purchased and sold on an exchange. ISDA 2003 Term: Listed.',
    notDomesticIssuance INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Any obligation other than an obligation that was intended to be offered for sale primarily in the domestic market of the relevant Reference Entity. This specifies that the obligation must be an internationally recognised bond. ISDA 2003 Term: Not Domestic Issuance.',
    fullFaithAndCreditObLiability INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published additional provisions for U.S. Municipal as Reference Entity. ISDA 2003 Term: Full Faith and Credit Obligation Liability.',
    generalFundObligationLiability INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published additional provisions for U.S. Municipal as Reference Entity. ISDA 2003 Term: General Fund Obligation Liability.',
    revenueObligationLiability INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published additional provisions for U.S. Municipal as Reference Entity. ISDA 2003 Term: Revenue Obligation Liability.',
    notContingent INT %DESCRIPTION 'OTE: Only allowed as an obligation characteristic under ISDA Credit 1999. In essence Not Contingent means the repayment of principal cannot be dependent on a formula/index, i.e. to prevent the risk of being delivered an instrument that may never pay any element of principal, and to ensure that the obligation is interest bearing (on a regular schedule). ISDA 2003 Term: Not Contingent.',
    excluded VARCHAR(255) %DESCRIPTION 'A free format string to specify any excluded obligations or deliverable obligations, as the case may be, of the reference entity or excluded types of obligations or deliverable obligations. ISDA 2003 Term: Excluded Obligations/Excluded Deliverable Obligations.',
    othReferenceEntityObligations VARCHAR(255) %DESCRIPTION 'This element is used to specify any other obligations of a reference entity in both obligations and deliverable obligations. The obligations can be specified free-form. ISDA 2003 Term: Other Obligations of a Reference Entity.',
    designatedPriority VARCHAR(255) %DESCRIPTION 'Applies to Loan CDS, to indicate what lien level is appropriate for a deliverable obligation. Applies to European Loan CDS, to indicate the Ranking of the obligation. Example: a 2nd lien Loan CDS would imply that the deliverable obligations are 1st or 2nd lien loans.',
    cashSettlementOnly INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published Standard Terms Supplement for use with CDS Transactions on Leveraged Loans. ISDA 2003 Term: Cash Settlement Only.',
    deliveryOfCommitments INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published Standard Terms Supplement for use with CDS Transactions on Leveraged Loans. ISDA 2003 Term: Delivery of Commitments.',
    continuity INT %DESCRIPTION 'An obligation and deliverable obligation characteristic. Defined in the ISDA published Standard Terms Supplement for use with CDS Transactions on Leveraged Loans. ISDA 2003 Term: Continuity.'
);

CREATE TABLE cdm_base_staticdata_party.AncillaryRoleEnum (
    AncillaryRoleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE com_rosetta_model_lib_meta.Reference (
    Reference_id INT UNIQUE NOT NULL,
    scope VARCHAR(255),
    value VARCHAR(255)
);

CREATE TABLE cdm_base_math.Quantity_datedValue (
    Quantity_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.Quantity (
    Quantity_id INT UNIQUE NOT NULL,
    multiplier VARCHAR(255) %DESCRIPTION 'Defines an optional number that the quantity should be multiplied by to derive a total quantity. This number is associated to a unit. For example in the case of the Coal (API2) CIF ARA (ARGUS-McCloskey) Futures Contract on the CME, where the unit would be contracts, the multiplier value would 1,000 and the mulitiplier unit would be 1,000 MT (Metric Tons).',
    frequency VARCHAR(255) %DESCRIPTION 'Defines the frequency to be used when defining a quantity. For example a quantity may be specified as a number of barrels of oil per day, which needs multiplying by the number of days in the relevant period to get the total quantity as a number of barrels.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_product_common_schedule.CalculationPeriodData (
    CalculationPeriodData_id INT UNIQUE NOT NULL,
    startDate VARCHAR(255) NOT NULL,
    endDate VARCHAR(255) NOT NULL,
    daysInPeriod INT NOT NULL,
    daysInLeapYearPeriod INT NOT NULL,
    isFirstPeriod INT NOT NULL,
    isLastPeriod INT NOT NULL
);

CREATE TABLE cdm_event_workflow.LimitLevelEnum (
    LimitLevelEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.MarginCallResponseAction_collateralPositionComponent (
    MarginCallResponseAction_id INT NOT NULL,
    CollateralPosition_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallResponseAction (
    MarginCallResponseAction_id INT UNIQUE NOT NULL,
    collateralPositionComponent INT NOT NULL %DESCRIPTION 'Specifies the collateral to be moved and its direction.',
    marginCallAction VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the margin call action details, specified as either Delivery or Return.'
);

CREATE TABLE cdm_product_template.OptionPayout (
    OptionPayout_id INT UNIQUE NOT NULL,
    buyerSeller VARCHAR(255) NOT NULL,
    optionType VARCHAR(255) %DESCRIPTION 'The type of option transaction. From a usage standpoint, put/call is the default option type, while payer/receiver indicator is used for options on index credit default swaps, consistently with the industry practice. Straddle is used for the case of straddle strategy, that combine a call and a put with the same strike.',
    feature VARCHAR(255) %DESCRIPTION 'The option feature, such as quanto, Asian, barrier, knock.',
    exerciseTerms VARCHAR(255) NOT NULL %DESCRIPTION 'The terms for exercising the option, which include the option style (e.g. American style option), the exercise procedure (e.g. manual exercise) and the settlement terms (e.g. physical vs. cash).',
    underlier VARCHAR(255) NOT NULL %DESCRIPTION 'The product underlying the option, which can be of any type including ContractualProduct or Security.',
    observationTerms VARCHAR(255) %DESCRIPTION 'Class containing terms that are associated with observing a price/benchmark/index across either single or multple observations. To be used for option contracts that reference a benchmark price.',
    schedule VARCHAR(255) %DESCRIPTION 'Allows the full representation of a payout by defining a set of schedule periods. It supports standard schedule customization by expressing all the dates, quantities, and pricing data in a non-parametric way.',
    delivery VARCHAR(255) %DESCRIPTION 'Contains the information relative to the delivery of the asset.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_product_template.MandatoryEarlyTerminationAdjustedDates (
    MandatoryEarlyTerminationAdjustedDates_id INT UNIQUE NOT NULL,
    adjustedEarlyTerminationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The early termination date that is applicable if an early termination provision is exercised. This date should already be adjusted for any applicable business day convention.',
    adjustedCashSettlementValuationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date by which the cash settlement amount must be agreed. This date should already be adjusted for any applicable business day convention.',
    adjustedCashSettlementPaymentDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the cash settlement amount is paid. This date should already be adjusted for any applicable business date convention.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.FallbackRateParameters (
    FallbackRateParameters_id INT UNIQUE NOT NULL,
    floatingRateIndex VARCHAR(255) NOT NULL %DESCRIPTION 'The floating rate index that is used as the basis of the fallback rate.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date the fallback rate takes effect.',
    calculationParameters VARCHAR(255) %DESCRIPTION 'Support for modular calculated rates, such such as lockout compound calculations.',
    spreadAdjustment FLOAT %DESCRIPTION 'The economic spread applied to the underlying fallback rate to replicate the original risky rate.'
);

CREATE TABLE cdm_observable_asset.BondValuationModel (
    BondValuationModel_id INT UNIQUE NOT NULL,
    nominalAmount VARCHAR(255) NOT NULL %DESCRIPTION 'The quantity of the underlier expressed as a nominal amount.',
    bondPriceAndYieldModel VARCHAR(255) NOT NULL %DESCRIPTION 'Price and yield model for valuing a bond security leg.',
    accrualsAmount VARCHAR(255) %DESCRIPTION 'Accruals amount for the bond in the security leg'
);

CREATE TABLE cdm_event_common.ContractFormationInstruction_legalAgreement (
    ContractFormationInstruction_id INT NOT NULL,
    LegalAgreement_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ContractFormationInstruction (
    ContractFormationInstruction_id INT UNIQUE NOT NULL,
    legalAgreement INT NOT NULL %DESCRIPTION 'Optional legal agreements associated to the contract being formed, for instance a master agreement.'
);

CREATE TABLE cdm_event_common.TransferStatusEnum (
    TransferStatusEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.ExtendibleProvisionAdjustedDates_extensionEvent (
    ExtendibleProvisionAdjustedDates_id INT NOT NULL,
    ExtensionEvent_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.ExtendibleProvisionAdjustedDates (
    ExtendibleProvisionAdjustedDates_id INT UNIQUE NOT NULL,
    extensionEvent INT NOT NULL %DESCRIPTION 'The adjusted dates associated with a single extendible exercise date.'
);

CREATE TABLE cdm_product_template.AssetLeg (
    AssetLeg_id INT UNIQUE NOT NULL,
    settlementDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the settlement date of securities.  In a repo transaction the purchase date would always be the effective date as specified under Economic Terms, the repurchase date would always be the termination date as specified under Economic Terms.',
    deliveryMethod VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies a delivery method for the security transaction.'
);

CREATE TABLE cdm_observable_event.MarketDisruptionEnum (
    MarketDisruptionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_schedule.InitialFixingDate (
    InitialFixingDate_id INT UNIQUE NOT NULL,
    relativeDateOffset VARCHAR(255),
    initialFixingDate VARCHAR(255)
);

CREATE TABLE cdm_observable_asset_metafields.ReferenceWithMetaPriceSchedule (
    ReferenceWithMetaPriceSchedule_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_master.DeterminationRolesAndTerms (
    DeterminationRolesAndTerms_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_math.MoneyBound (
    MoneyBound_id INT UNIQUE NOT NULL,
    money VARCHAR(255) NOT NULL %DESCRIPTION 'The money amount to be used as the bound, e.g. 1,000 USD.',
    inclusive INT NOT NULL %DESCRIPTION 'Whether the money amount bound is inclusive, e.g. for a lower bound, false would indicate greater than, whereas true would indicate greater than or equal to.'
);

CREATE TABLE cdm_legaldocumentation_master.Clause_subcomponents (
    Clause_id INT NOT NULL,
    Clause_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.Clause (
    Clause_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) %DESCRIPTION 'The  name or identifier associated to this clause ',
    terms VARCHAR(255) %DESCRIPTION 'Content of this bespoke clause',
    subcomponents INT NOT NULL %DESCRIPTION 'Additional hierarchichal components of the clause if relevant'
);

CREATE TABLE cdm_event_workflow.LimitApplicable (
    LimitApplicable_id INT UNIQUE NOT NULL,
    limitType VARCHAR(255) %DESCRIPTION 'Standard code to indicate which type of credit line is being referred to - i.e. IM, DV01, PV01, CS01, Notional, Clip Size, Notional, maximumOrderQuantity.',
    clipSize INT %DESCRIPTION 'This element is required in FpML, optional in CDM for the purpose of accommodating the CME data representation while making reference to the FpML one.',
    amountUtilized FLOAT %DESCRIPTION 'The limit utilised by all the cleared trades for the limit level and limit type. While the attribute is of type integer in FpML and the CME schema, it has been specified to be of type number in the CDM to take into consideration java size limits as well as for consistency purposes with the way most monetary amounts are expressed.',
    utilization VARCHAR(255),
    amountRemaining FLOAT %DESCRIPTION 'The limit remaining for the limit level and limit type. This does not take into account any pending trades. While the attribute is of type integer in FpML and the CME schema, it has been specified to be of type number in the CDM to take into consideration java size limits as well as for consistency purposes with the way most monetary amounts are expressed.',
    currency VARCHAR(255) %DESCRIPTION 'The currency in which the applicable limit is denominated. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    velocity VARCHAR(255)
);

CREATE TABLE cdm_event_common.BillingInstruction_billingRecordInstruction (
    BillingInstruction_id INT NOT NULL,
    BillingRecordInstruction_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.BillingInstruction_billingSummary (
    BillingInstruction_id INT NOT NULL,
    BillingSummaryInstruction_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.BillingInstruction (
    BillingInstruction_id INT UNIQUE NOT NULL,
    sendingParty VARCHAR(255) NOT NULL %DESCRIPTION 'The party issuing the invoice',
    receivingParty VARCHAR(255) NOT NULL %DESCRIPTION 'The party receiving the invoice',
    billingStartDate VARCHAR(255) NOT NULL %DESCRIPTION 'The starting date of the period described by this invoice',
    billingEndDate VARCHAR(255) NOT NULL %DESCRIPTION 'The ending date of the period described by this invoice',
    billingRecordInstruction INT NOT NULL %DESCRIPTION 'Instructions for creating the billing records contained within the invoice',
    billingSummary INT NOT NULL %DESCRIPTION 'The billing summaries contained within the invoice'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaInterpolationMethodEnum (
    FieldWithMetaInterpolationMethodEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common_metafields.ReferenceWithMetaCommodity (
    ReferenceWithMetaCommodity_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.InterestAmountApplication (
    InterestAmountApplication_id INT UNIQUE NOT NULL,
    returnAmount VARCHAR(255) NOT NULL %DESCRIPTION 'The application of Interest Amount with respect the Return Amount.',
    deliveryAmount VARCHAR(255) NOT NULL %DESCRIPTION 'The application of Interest Amount with respect the Delivery Amount.'
);

CREATE TABLE cdm_observable_event.PubliclyAvailableInformation_publicSource (
    PubliclyAvailableInformation_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_event.PubliclyAvailableInformation (
    PubliclyAvailableInformation_id INT UNIQUE NOT NULL,
    standardPublicSources INT %DESCRIPTION 'If this element is specified and set to ''true'', indicates that ISDA defined Standard Public Sources are applicable.',
    publicSource INT NOT NULL %DESCRIPTION 'A public information source, e.g. a particular newspaper or electronic news service, that may publish relevant information used in the determination of whether or not a credit event has occurred. ISDA 2003 Term: Public Source.',
    specifiedNumber INT %DESCRIPTION 'The minimum number of the specified public information sources that must publish information that reasonably confirms that a credit event has occurred. The market convention is two. ISDA 2003 Term: Specified Number.'
);

CREATE TABLE cdm_product_collateral.CreditSupportAgreementTypeEnum (
    CreditSupportAgreementTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.FieldWithMetaPersonIdentifier (
    FieldWithMetaPersonIdentifier_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_observable_asset_metafields.ReferenceWithMetaRateObservation (
    ReferenceWithMetaRateObservation_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_regulation.ExctgPrsn (
    ExctgPrsn_id INT UNIQUE NOT NULL,
    prsn VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_event_common.InstructionFunctionEnum (
    InstructionFunctionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.DayTypeEnum (
    DayTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.MatrixTermEnum (
    MatrixTermEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.PaymentRule (
    PaymentRule_id INT UNIQUE NOT NULL,
    percentageRule VARCHAR(255) %DESCRIPTION 'This attribute is not present as part of the FpML construct, as the payment rule is specialised by means of runtime type extension through the xsi:type.'
);

CREATE TABLE cdm_product_common_settlement.SettlementBase (
    SettlementBase_id INT UNIQUE NOT NULL,
    settlementType VARCHAR(255) NOT NULL %DESCRIPTION 'Whether the settlement will be cash, physical, by election, ...',
    transferSettlementType VARCHAR(255) %DESCRIPTION 'The qualification as to how the transfer will settle, e.g. a DvP settlement.',
    settlementCurrency VARCHAR(255) %DESCRIPTION 'The settlement currency is to be specified when the Settlement Amount cannot be known in advance. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    settlementDate VARCHAR(255) %DESCRIPTION 'The date on which the settlement amount will be paid, subject to adjustment in accordance with any applicable business day convention. This component would not be present for a mandatory early termination provision where the cash settlement payment date is the mandatory early termination date.',
    settlementCentre VARCHAR(255) %DESCRIPTION 'Optional settlement centre as an enumerated list: Euroclear, Clearstream.',
    settlementProvision VARCHAR(255) %DESCRIPTION 'Optionally defines the parameters that regulate a settlement.',
    standardSettlementStyle VARCHAR(255) %DESCRIPTION 'Settlement Style.'
);

CREATE TABLE cdm_product_collateral.CollateralTypeEnum (
    CollateralTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_position_metafields.ReferenceWithMetaPortfolioState (
    ReferenceWithMetaPortfolioState_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_party.Address_street (
    Address_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.Address (
    Address_id INT UNIQUE NOT NULL,
    street INT NOT NULL %DESCRIPTION 'The set of street and building number information that identifies a postal address within a city.',
    city VARCHAR(255) %DESCRIPTION 'The city component of the postal address.',
    state VARCHAR(255) %DESCRIPTION 'A country subdivision used in postal addresses in some countries. For example, US states, Canadian provinces, Swiss cantons, ...',
    country VARCHAR(255) %DESCRIPTION 'The ISO 3166 standard code for the country within which the postal address is located.',
    postalCode VARCHAR(255) %DESCRIPTION 'The code, required for computerized mail sorting systems, that is allocated to a physical address by a national postal authority.'
);

CREATE TABLE cdm_base_staticdata_asset_common.Loan_borrower (
    Loan_id INT NOT NULL,
    LegalEntity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Loan_productTaxonomy (
    Loan_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Loan_productIdentifier (
    Loan_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Loan (
    Loan_id INT UNIQUE NOT NULL,
    borrower INT NOT NULL %DESCRIPTION 'Specifies the borrower. There can be more than one borrower. It is meant to be used in the event that there is no Bloomberg Id or the Secured List isn''t applicable.',
    lien VARCHAR(255) %DESCRIPTION 'Specifies the seniority level of the lien.',
    facilityType VARCHAR(255) %DESCRIPTION 'Specifies the type of loan facility (letter of credit, revolving, ...).',
    creditAgreementDate VARCHAR(255) %DESCRIPTION 'Specifies the credit agreement date is the closing date (the date where the agreement has been signed) for the loans in the credit agreement. Funding of the facilities occurs on (or sometimes a little after) the Credit Agreement date. This underlier attribute is used to help identify which of the company''s outstanding loans are being referenced by knowing to which credit agreement it belongs. ISDA Standards Terms Supplement term: Date of Original Credit Agreement.',
    tranche VARCHAR(255) %DESCRIPTION 'Denotes the loan tranche that is subject to the derivative transaction. It will typically be referenced as the Bloomberg tranche number. ISDA Standards Terms Supplement term: Bloomberg Tranche Number.',
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_product_asset.VarianceReturnTerms (
    VarianceReturnTerms_id INT UNIQUE NOT NULL,
    varianceStrikePrice VARCHAR(255) %DESCRIPTION 'Variance Strike Price in accordance with the ISDA 2011 Equity Derivatives Definitions.',
    volatilityStrikePrice VARCHAR(255) %DESCRIPTION 'Volatility Strike Price in accordance with the ISDA 2011 Equity Derivatives Definitions.',
    varianceCapFloor VARCHAR(255) %DESCRIPTION 'Contains possible barriers for variance products, both variance-based and underlier price based',
    volatilityCapFloor VARCHAR(255) %DESCRIPTION 'Contains containing volatility-based barriers',
    vegaNotionalAmount VARCHAR(255) %DESCRIPTION 'Vega Notional represents the approximate gain/loss at maturity for a 1% difference between RVol (realised vol) and KVol (strike vol). It does not necessarily represent the Vega Risk of the trade.',
    exchangeTradedContractNearest VARCHAR(255) %DESCRIPTION 'Specification of the exchange traded contract nearest.',
    valuationTerms VARCHAR(255) %DESCRIPTION 'Contains all non-date valuation information.',
    annualizationFactor INT %DESCRIPTION 'This specifies the numerator of an annualization factor. Frequently this number is equal to the number of observations of prices in a year e.g. 252.',
    dividendApplicability VARCHAR(255) %DESCRIPTION 'The parameters which define whether dividends are applicable',
    equityUnderlierProvisions VARCHAR(255) %DESCRIPTION 'Contains Equity underlier provisions regarding jurisdiction and fallbacks.',
    sharePriceDividendAdjustment INT %DESCRIPTION 'Indicates whether the price of shares is adjusted for dividends or not.',
    expectedN INT %DESCRIPTION 'Expected number of trading days.',
    initialLevel FLOAT %DESCRIPTION 'Contract will strike off this initial level. Providing just the initialLevel without initialLevelSource, infers that this is AgreedInitialPrice - a specified Initial Index Level.',
    initialLevelSource VARCHAR(255) %DESCRIPTION 'In this context, this is AgreedInitialPrice - a specified Initial Index Level.',
    meanAdjustment INT %DESCRIPTION 'Specifies whether Mean Adjustment is applicable or not in the calculation of the Realized Volatility, Variance or Correlation',
    performance VARCHAR(255) %DESCRIPTION 'Performance calculation, in accordance with Part 1 Section 12 of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap, Para 75. ''Equity Performance''. Cumulative performance is used as a notional multiplier factor on both legs of an Equity Swap.'
);

CREATE TABLE cdm_observable_event.IndexEventConsequenceEnum (
    IndexEventConsequenceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_event.TriggerEvent_schedule (
    TriggerEvent_id INT NOT NULL,
    AveragingSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_event.TriggerEvent (
    TriggerEvent_id INT UNIQUE NOT NULL,
    schedule INT NOT NULL %DESCRIPTION 'A derivative schedule.',
    triggerDates VARCHAR(255) %DESCRIPTION 'The trigger Dates.',
    trigger VARCHAR(255) NOT NULL %DESCRIPTION 'The trigger level',
    featurePayment VARCHAR(255) %DESCRIPTION 'The feature payment, i.e. the payment made following trigger occurrence.'
);

CREATE TABLE cdm_legaldocumentation_common.SpecifiedEntityTermsEnum (
    SpecifiedEntityTermsEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.LegalAgreementTypeEnum (
    LegalAgreementTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.MarginCallIssuance_recallNonCashCollateralDescription (
    MarginCallIssuance_id INT NOT NULL,
    EligibleCollateralCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallIssuance_party (
    MarginCallIssuance_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallIssuance_partyRole (
    MarginCallIssuance_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallIssuance (
    MarginCallIssuance_id INT UNIQUE NOT NULL,
    callAmountInBaseCurrency VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the amount of margin being called for which accounts for margin calculation inclusive of exposure, independent amount,threshold,collateral balance, MTA, rounding increments (in base currency detailed in supporting collateral agreement).',
    recallNonCashCollateralDescription INT NOT NULL %DESCRIPTION 'Specifies the details to describe or identify non-cash collateral eligible assets for recall purposes.',
    instructionType VARCHAR(255) %DESCRIPTION 'Identifies the enumeration values to specify the call notification type, direction, specific action type.',
    party INT NOT NULL %DESCRIPTION 'Represents the parties to the margin call. The cardinality is optional to address the case where both parties of the event are specified and a third party if applicable.',
    partyRole INT NOT NULL %DESCRIPTION 'Represents the role each specified party takes in the margin call. further to the principal roles, payer and receiver.',
    clearingBroker VARCHAR(255) %DESCRIPTION 'Indicates the name of the Clearing Broker FCM/DCM.',
    callIdentifier VARCHAR(255) %DESCRIPTION 'Represents a unique Identifier for a margin call message, that can be referenced throughout all points of the process.',
    callAgreementType VARCHAR(255) %DESCRIPTION 'Specifies the legal agreement type the margin call is generated from and governed by.',
    agreementMinimumTransferAmount VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement minimum transfer amount in base currency.',
    agreementThreshold VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement threshold amount in base currency.',
    agreementRounding VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement rounding in base currency.',
    regMarginType VARCHAR(255) %DESCRIPTION 'Identifies margin type and if related regulatory mandate',
    regIMRole VARCHAR(255) %DESCRIPTION 'Indicates the role of the party in an regulatory initial margin call instruction (i.e Pledgor party or Secured party).',
    baseCurrencyExposure VARCHAR(255) %DESCRIPTION 'Represents the current mark to market value or IM calculation value of the trade portfolio as recorded by the principle (in base currency), to be referenced in a margin call.',
    collateralPortfolio VARCHAR(255) %DESCRIPTION 'Represents attributes to define the details of collateral assets within a collateral portfolio to be used in margin call messaging and contribute to collateral balances e.g securities in a collateral account recorded by the principal as held or posted.',
    independentAmountBalance VARCHAR(255) %DESCRIPTION 'Represents additional credit support amount over and above mark to market value.'
);

CREATE TABLE cdm_event_common.TradeState_resetHistory (
    TradeState_id INT NOT NULL,
    Reset_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TradeState_transferHistory (
    TradeState_id INT NOT NULL,
    TransferState_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TradeState_observationHistory (
    TradeState_id INT NOT NULL,
    ObservationEvent_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TradeState_valuationHistory (
    TradeState_id INT NOT NULL,
    Valuation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TradeState (
    TradeState_id INT UNIQUE NOT NULL,
    trade VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the Trade that has been effected by a business or life-cycle event.',
    state VARCHAR(255) %DESCRIPTION 'Represents the State of the Trade through its life-cycle.',
    resetHistory INT NOT NULL %DESCRIPTION 'Represents the updated Trade attributes which can change as the result of a reset event. Only the changed values are captured, leaving the remaining data attributes empty. See Create_Reset function for further details on how TradeState is used in the Reset event. The TradeState data type is used to maintain backwards compatibility with the current Reset mechanism.',
    transferHistory INT NOT NULL %DESCRIPTION 'Represents the updated Trade attributes which can change as the result of a transfer event.',
    observationHistory INT NOT NULL %DESCRIPTION 'Represents the observed events related to a particular product or process, such as credit events or corporate actions.',
    valuationHistory INT NOT NULL
);

CREATE TABLE cdm_regulation.InvstmtDcsnPrsn (
    InvstmtDcsnPrsn_id INT UNIQUE NOT NULL,
    prsn VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_datetime.DayOfWeekEnum (
    DayOfWeekEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.AssetDeliveryInformation_location (
    AssetDeliveryInformation_id INT NOT NULL,
    LocationIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.AssetDeliveryInformation (
    AssetDeliveryInformation_id INT UNIQUE NOT NULL,
    periods VARCHAR(255) %DESCRIPTION 'Defines the periods of delivery, including the delivery profile.',
    location INT NOT NULL %DESCRIPTION 'Defines the location of the delivery of the commodity.',
    deliveryCapacity VARCHAR(255) %DESCRIPTION 'The number of units included in the transaction for each delivery interval'
);

CREATE TABLE cdm_product_asset.Tranche (
    Tranche_id INT UNIQUE NOT NULL,
    attachmentPoint FLOAT NOT NULL %DESCRIPTION 'Lower bound percentage of the loss that the Tranche can endure, expressed as a decimal. An attachment point of 5% would be represented as 0.05. The difference between Attachment and Exhaustion points is called the width of the Tranche.',
    exhaustionPoint FLOAT NOT NULL %DESCRIPTION 'Upper bound percentage of the loss that the Tranche can endure, expressed as a decimal. An exhaustion point of 5% would be represented as 0.05. The difference between Attachment and Exhaustion points is call the width of the Tranche.',
    incurredRecoveryApplicable INT %DESCRIPTION 'Outstanding Swap Notional Amount is defined at any time on any day, as the greater of: (a) Zero; If Incurred Recovery Amount Applicable: (b) The Original Swap Notional Amount minus the sum of all Incurred Loss Amounts and all Incurred Recovery Amounts (if any) determined under this Confirmation at or prior to such time.Incurred Recovery Amount not populated: (b) The Original Swap Notional Amount minus the sum of all Incurred Loss Amounts determined under this Confirmation at or prior to such time.'
);

CREATE TABLE cdm_legaldocumentation_common.ContractualSupplementTypeEnum (
    ContractualSupplementTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.CreditSupportDocumentTermsEnum (
    CreditSupportDocumentTermsEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.ProductBase_productTaxonomy (
    ProductBase_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.ProductBase_productIdentifier (
    ProductBase_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.ProductBase (
    ProductBase_id INT UNIQUE NOT NULL,
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_observable_asset.QuotationStyleEnum (
    QuotationStyleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.IndexTransitionInstruction_priceQuantity (
    IndexTransitionInstruction_id INT NOT NULL,
    PriceQuantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.IndexTransitionInstruction (
    IndexTransitionInstruction_id INT UNIQUE NOT NULL,
    priceQuantity INT NOT NULL %DESCRIPTION 'Specifies both new floating rate index and spread adjustment for each leg to be updated.  The spread adjustment accounts for the difference between the old floating rate index relative to the new one. This spread amount is added to the existing spread to determine the new spread, which is applied from the specified effective date forward. In the case of the IBOR Fallback Rate Adjustments, the adjustment spread (also known as the Fallback Adjustment) accounts for two distinctions: i) the fact that the replacement Risk-Free Rate is an overnight rate while IBORs have term structures (e.g., 1, 3, 6-month LIBOR); and (ii) the historical spread differential between IBORs and their term equivalent Overnight Risk-Free Rate compounded rates.',
    effectiveDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the effective date of the index transition event. This is first date on which the floating rate calculation will use the new floating rate index and adjusted spread in the floating rate calculation.',
    cashTransfer VARCHAR(255) %DESCRIPTION 'Specifies the cash transfer that can optionally be tied to an index transition event.'
);

CREATE TABLE cdm_observable_asset.PriceSchedule_datedValue (
    PriceSchedule_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.PriceSchedule (
    PriceSchedule_id INT UNIQUE NOT NULL,
    perUnitOf VARCHAR(255) %DESCRIPTION 'Provides an attribute to define the unit of the thing being priced. For example, {amount, unitOfAmount, PerUnitOfAmount} = [10, EUR, Shares] = (10.00 EUR/SHARE) * (300,000 SHARES) = EUR 3,000,000.00 (Shares cancel out in the calculation).',
    priceType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the price type as an enumeration: interest rate, exchange rate, asset price etc. This attribute is mandatory so that prices can always be clasiffied according to their type. The price type implies some constraints on the price''s units.',
    priceExpression VARCHAR(255) %DESCRIPTION '(Optionally) Specifies whether the price is expressed in absolute or percentage terms.',
    composite VARCHAR(255) %DESCRIPTION '(Optionally) Specifies the underlying price components if the price can be expressed as a composite: e.g. dirty price = clean price + accrued.',
    arithmeticOperator VARCHAR(255) %DESCRIPTION '(Optionally) When the price is to be understood as an operator to apply to an observable, i.e. a spread, multiplier or min/max.',
    cashPrice VARCHAR(255) %DESCRIPTION '(Optionally when the price type is cash) Additional attributes that further define a cash price, e.g. what type of fee it is.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_base_datetime.BusinessDayAdjustments (
    BusinessDayAdjustments_id INT UNIQUE NOT NULL,
    businessDayConvention VARCHAR(255) NOT NULL %DESCRIPTION 'The convention for adjusting a date if it would otherwise fall on a day that is not a business day.',
    businessCenters VARCHAR(255) %DESCRIPTION 'The business center(s), specified either explicitly or by reference to those specified somewhere else in the instance document.'
);

CREATE TABLE cdm_product_asset.FutureValueAmount (
    FutureValueAmount_id INT UNIQUE NOT NULL,
    quantity VARCHAR(255),
    currency VARCHAR(255) NOT NULL %DESCRIPTION 'The currency in which the an amount is denominated. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    calculationPeriodNumberOfDays INT NOT NULL %DESCRIPTION 'The number of days from the adjusted calculation period start date to the adjusted value date, calculated in accordance with the applicable day count fraction.',
    valueDate VARCHAR(255) NOT NULL %DESCRIPTION 'Adjusted value date of the future value amount.'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaCommodityReferencePriceEnum (
    FieldWithMetaCommodityReferencePriceEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_template.OptionalEarlyTerminationAdjustedDates_earlyTerminationEvent (
    OptionalEarlyTerminationAdjustedDates_id INT NOT NULL,
    EarlyTerminationEvent_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.OptionalEarlyTerminationAdjustedDates (
    OptionalEarlyTerminationAdjustedDates_id INT UNIQUE NOT NULL,
    earlyTerminationEvent INT NOT NULL %DESCRIPTION 'The adjusted dates associated with an individual early termination date.'
);

CREATE TABLE cdm_product_template.ManualExercise (
    ManualExercise_id INT UNIQUE NOT NULL,
    exerciseNotice VARCHAR(255) %DESCRIPTION 'Definition of the party to whom notice of exercise should be given.',
    fallbackExercise INT %DESCRIPTION 'If fallback exercise is specified then the notional amount of the underlying swap, not previously exercised under the swaption, will be automatically exercised at the expiration time on the expiration date if at such time the buyer is in-the-money, provided that the difference between the settlement rate and the fixed rate under the relevant underlying swap is not less than one tenth of a percentage point (0.10% or 0.001). The term in-the-money is assumed to have the meaning defined in the 2000 ISDA Definitions, Section 17.4. In-the-money.'
);

CREATE TABLE cdm_observable_asset_fro.FloatingRateIndexCategoryEnum (
    FloatingRateIndexCategoryEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_collateral.CollateralValuationTreatment (
    CollateralValuationTreatment_id INT UNIQUE NOT NULL,
    haircutPercentage FLOAT %DESCRIPTION 'Specifies a haircut percentage to be applied to the value of asset and used as a discount factor to the value of the collateral asset,expressed as a percentage in decimal terms. As an example a 0.5% haircut would be represented as a decimal number 0.005.',
    marginPercentage FLOAT %DESCRIPTION 'Specifies a percentage value of transaction needing to be posted as collateral expressed as a valuation. As an example a 104% requirement would be represented as a decimal number 1.04.',
    fxHaircutPercentage FLOAT %DESCRIPTION 'Specifies an FX haircut applied to a specific asset which is agreed between the parties (for example, if pledgor eligible collateral is not denominated in the termination currency or under other specified cases in collateral support documents both for initial margin and variation margin).The percentage value is expressed as the discount haircut to the value of the collateral- as an example an 8% FX haircut would be expressed as 0.08.',
    additionalHaircutPercentage FLOAT %DESCRIPTION 'Specifies a percentage value of any additional haircut to be applied to a collateral asset,the percentage value is expressed as the discount haircut to the value of the collateral- as an example a 5% haircut would be expressed as 0.05. '
);

CREATE TABLE cdm_product_common_settlement_metafields.ReferenceWithMetaPhysicalSettlementTerms (
    ReferenceWithMetaPhysicalSettlementTerms_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_datetime.AdjustableOrAdjustedOrRelativeDate (
    AdjustableOrAdjustedOrRelativeDate_id INT UNIQUE NOT NULL,
    unadjustedDate VARCHAR(255) %DESCRIPTION 'A date subject to adjustment.',
    dateAdjustments VARCHAR(255) %DESCRIPTION 'The business day convention and financial business centers used for adjusting the date if it would otherwise fall on a day that is not a business date in the specified business centers.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).',
    relativeDate VARCHAR(255) %DESCRIPTION 'A date specified as some offset to another date (the anchor date).'
);

CREATE TABLE cdm_product_template.ContractualProduct_productTaxonomy (
    ContractualProduct_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.ContractualProduct_productIdentifier (
    ContractualProduct_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.ContractualProduct (
    ContractualProduct_id INT UNIQUE NOT NULL,
    economicTerms VARCHAR(255) NOT NULL %DESCRIPTION 'The economic terms associated with a contractual product, i.e. the set of features that are price-forming.',
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_base_staticdata_party.FieldWithMetaAccountTypeEnum (
    FieldWithMetaAccountTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.FieldWithMetaAssetClassEnum (
    FieldWithMetaAssetClassEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_template.PartialExercise (
    PartialExercise_id INT UNIQUE NOT NULL,
    notionaReference VARCHAR(255) NOT NULL %DESCRIPTION 'A pointer style reference to the associated notional schedule defined elsewhere in the document. This element has been made optional as part of its integration in the OptionBaseExtended, because not required for the options on securities.',
    integralMultipleAmount FLOAT %DESCRIPTION 'A notional amount which restricts the amount of notional that can be exercised when partial exercise or multiple exercise is applicable. The integral multiple amount defines a lower limit of notional that can be exercised and also defines a unit multiple of notional that can be exercised, i.e. only integer multiples of this amount can be exercised.',
    minimumNotionalAmount FLOAT %DESCRIPTION 'The minimum notional amount that can be exercised on a given exercise date. See multipleExercise.',
    minimumNumberOfOptions INT %DESCRIPTION 'The minimum number of options that can be exercised on a given exercise date.'
);

CREATE TABLE cdm_product_asset_floatingrate.FloatingRateSettingDetails (
    FloatingRateSettingDetails_id INT UNIQUE NOT NULL,
    calculationDetails VARCHAR(255) %DESCRIPTION 'Calculated rate details (observation dates, values, and weights).',
    observationDate VARCHAR(255) %DESCRIPTION 'The day upon which the rate was observed (for term rates).',
    resetDate VARCHAR(255) %DESCRIPTION 'The day for which the rate is needed (e.g. period beginning or end date).',
    floatingRate FLOAT NOT NULL %DESCRIPTION 'The resulting rate that was observed or calculated.'
);

CREATE TABLE cdm_product_asset.AdditionalFixedPayments (
    AdditionalFixedPayments_id INT UNIQUE NOT NULL,
    interestShortfallReimbursement INT %DESCRIPTION 'An additional Fixed Payment Event. Corresponds to the payment by or on behalf of the Issuer of an actual interest amount in respect to the reference obligation that is greater than the expected interest amount. ISDA 2003 Term: Interest Shortfall Reimbursement.',
    principalShortfallReimbursement INT %DESCRIPTION 'An additional Fixed Payment Event. Corresponds to the payment by or on behalf of the Issuer of an actual principal amount in respect to the reference obligation that is greater than the expected principal amount. ISDA 2003 Term: Principal Shortfall Reimbursement.',
    writedownReimbursement INT %DESCRIPTION 'An Additional Fixed Payment. Corresponds to the payment by or on behalf of the issuer of an amount in respect to the reference obligation in reduction of the prior writedowns. ISDA 2003 Term: Writedown Reimbursement.'
);

CREATE TABLE cdm_product_template.ExerciseFee (
    ExerciseFee_id INT UNIQUE NOT NULL,
    notionalReference VARCHAR(255) NOT NULL %DESCRIPTION 'A pointer style reference to the associated notional schedule defined elsewhere in the document.',
    feeAmount FLOAT %DESCRIPTION 'The amount of fee to be paid on exercise. The fee currency is that of the referenced notional.',
    feeRate FLOAT %DESCRIPTION 'A fee represented as a percentage of some referenced notional. A percentage of 5% would be represented as 0.05.',
    feePaymentDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which exercise fee(s) will be paid. It is specified as a relative date.',
    payer VARCHAR(255) %DESCRIPTION 'Specifies the counterparty responsible for making the payments defined by this structure.  The party is one of the two principal parties to the transaction.',
    receiver VARCHAR(255) %DESCRIPTION 'Specifies the party that receives the payments corresponding to this structure.  The party is one of the two counterparties to the transaction.'
);

CREATE TABLE cdm_observable_event.GracePeriodExtension (
    GracePeriodExtension_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the grace period extension provision is applicable.',
    gracePeriod VARCHAR(255) %DESCRIPTION 'The number of calendar or business days after any due date that the reference entity has to fulfil its obligations before a failure to pay credit event is deemed to have occurred. ISDA 2003 Term: Grace Period.'
);

CREATE TABLE cdm_event_workflow.CreditLimitUtilisationPosition (
    CreditLimitUtilisationPosition_id INT UNIQUE NOT NULL,
    shortPosition FLOAT %DESCRIPTION 'Credit limit utilisation attributable to short positions.',
    longPosition FLOAT %DESCRIPTION 'Credit limit utilisation attributable to long positions.',
    global FLOAT %DESCRIPTION 'Global credit limit utilisation amount, agnostic of long/short position direction.'
);

CREATE TABLE cdm_base_datetime.Frequency (
    Frequency_id INT UNIQUE NOT NULL,
    periodMultiplier INT NOT NULL %DESCRIPTION 'A time period multiplier, e.g. 1, 2, or 3. If the period value is T (Term) then period multiplier must contain the value 1.',
    period VARCHAR(255) NOT NULL %DESCRIPTION 'A time period, e.g. a day, week, month, year or term of the stream.'
);

CREATE TABLE cdm_legaldocumentation_common.TerminationCurrencyConditionEnum (
    TerminationCurrencyConditionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_position.Portfolio (
    Portfolio_id INT UNIQUE NOT NULL,
    aggregationParameters VARCHAR(255) NOT NULL %DESCRIPTION 'Describes the portfolio by describing how to aggregate all its relevant Events.',
    portfolioState VARCHAR(255) NOT NULL %DESCRIPTION 'Describes the state of the Portfolio as a list of Positions resulting from the aggregation.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.ObservationParameters (
    ObservationParameters_id INT UNIQUE NOT NULL,
    observationCapRate FLOAT %DESCRIPTION 'A daily observation cap rate.',
    observationFloorRate FLOAT %DESCRIPTION 'A daily observation floor rate.'
);

CREATE TABLE cdm_product_common_schedule.FinalCalculationPeriodDateAdjustment (
    FinalCalculationPeriodDateAdjustment_id INT UNIQUE NOT NULL,
    relevantUnderlyingDateReference VARCHAR(255) NOT NULL %DESCRIPTION 'Reference to the unadjusted cancellation effective dates.',
    swapStreamReference VARCHAR(255) NOT NULL %DESCRIPTION 'Reference to the leg, where date adjustments may apply.',
    businessDayConvention VARCHAR(255) NOT NULL %DESCRIPTION 'Override business date convention. This takes precedence over leg level information.'
);

CREATE TABLE cdm_event_workflow.PartyCustomisedWorkflow_customisedWorkflow (
    PartyCustomisedWorkflow_id INT NOT NULL,
    CustomisedWorkflow_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.PartyCustomisedWorkflow (
    PartyCustomisedWorkflow_id INT UNIQUE NOT NULL,
    partyReference VARCHAR(255) %DESCRIPTION 'Reference to the party to which the workflow pertains to.',
    partyName VARCHAR(255) %DESCRIPTION 'The party name to which the workflow pertains to.',
    customisedWorkflow INT NOT NULL %DESCRIPTION 'Non-standardized data in a generic form.'
);

CREATE TABLE cdm_product_collateral.EligibleCollateralCriteria_issuer (
    EligibleCollateralCriteria_id INT NOT NULL,
    IssuerCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralCriteria_asset (
    EligibleCollateralCriteria_id INT NOT NULL,
    AssetCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralCriteria_appliesTo (
    EligibleCollateralCriteria_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.EligibleCollateralCriteria (
    EligibleCollateralCriteria_id INT UNIQUE NOT NULL,
    treatment VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the treatment of specified collateral, e.g., haircuts,holding limits or exclusions.',
    issuer INT NOT NULL %DESCRIPTION 'Represents a filter based criteria related to the issuer.',
    asset INT NOT NULL %DESCRIPTION 'Represents a filter based on the criteria related to the asset.',
    appliesTo INT NOT NULL %DESCRIPTION 'Specifies which of the two counterparties the criteria applies to (either one or both counterparties). This attribute is optional, in case the applicable party is already specified elsewhere within a party election.'
);

CREATE TABLE cdm_product_template.PassThrough_passThroughItem (
    PassThrough_id INT NOT NULL,
    PassThroughItem_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.PassThrough (
    PassThrough_id INT UNIQUE NOT NULL,
    passThroughItem INT NOT NULL %DESCRIPTION 'One to many pass through payment items.'
);

CREATE TABLE cdm_product_template.ReturnTerms (
    ReturnTerms_id INT UNIQUE NOT NULL,
    priceReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the underlier''s observed price.',
    dividendReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon dividend payments associated to the underlier.',
    varianceReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the observed variance of the underlier''s price.',
    volatilityReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the observed volatility of the underlier''s price.',
    correlationReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the observed correlation between the components of the underlying basket.'
);

CREATE TABLE cdm_legaldocumentation_common.AgreementName_contractualDefinitionsType (
    AgreementName_id INT NOT NULL,
    FieldWithMetaContractualDefinitionsEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.AgreementName_contractualTermsSupplement (
    AgreementName_id INT NOT NULL,
    ContractualTermsSupplement_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.AgreementName_contractualMatrix (
    AgreementName_id INT NOT NULL,
    ContractualMatrix_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.AgreementName (
    AgreementName_id INT UNIQUE NOT NULL,
    agreementType VARCHAR(255) NOT NULL %DESCRIPTION 'Specification of the legal agreement type.',
    creditSupportAgreementType VARCHAR(255) %DESCRIPTION 'Specification of the credit support agreement type.',
    creditSupportAgreementMarginType VARCHAR(255) %DESCRIPTION 'specifies the type of margin for which a legal agreement is named.',
    contractualDefinitionsType INT NOT NULL %DESCRIPTION 'The definitions such as those published by ISDA that will define the terms of the trade.',
    contractualTermsSupplement INT NOT NULL %DESCRIPTION 'A contractual supplement (such as those published by ISDA) that will apply to the trade.',
    contractualMatrix INT NOT NULL %DESCRIPTION 'A reference to a contractual matrix of elected terms/values (such as those published by ISDA) that shall be deemed to apply to the trade. The applicable matrix is identified by reference to a name and optionally a publication date. Depending on the structure of the matrix, an additional term (specified in the matrixTerm element) may be required to further identify a subset of applicable terms/values within the matrix.',
    masterAgreementType VARCHAR(255) %DESCRIPTION 'Specification of the master agreement type.',
    masterConfirmationType VARCHAR(255) %DESCRIPTION 'The type of master confirmation executed between the parties.',
    masterConfirmationAnnexType VARCHAR(255) %DESCRIPTION 'The type of master confirmation annex executed between the parties.',
    otherAgreement VARCHAR(255) %DESCRIPTION 'Definition of an agreement that is not enumerated in the CDM.'
);

CREATE TABLE cdm_base_datetime.Period (
    Period_id INT UNIQUE NOT NULL,
    periodMultiplier INT NOT NULL %DESCRIPTION 'A time period multiplier, e.g. 1, 2 or 3 etc. A negative value can be used when specifying an offset relative to another date, e.g. -2 days.',
    period VARCHAR(255) NOT NULL %DESCRIPTION 'A time period, e.g. a day, week, month or year of the stream. If the periodMultiplier value is 0 (zero) then period must contain the value D (day).'
);

CREATE TABLE cdm_event_workflow.CreditLimitTypeEnum (
    CreditLimitTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.DebtPrincipalEnum (
    DebtPrincipalEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.InflationRateSpecification (
    InflationRateSpecification_id INT UNIQUE NOT NULL,
    inflationLag VARCHAR(255) NOT NULL %DESCRIPTION 'An off-setting period from the payment date which determines the reference period for which the inflation index is observed.',
    indexSource VARCHAR(255) NOT NULL %DESCRIPTION 'The reference source such as Reuters or Bloomberg. FpML specifies indexSource to be of type rateSourcePageScheme, but without specifying actual values.',
    mainPublication VARCHAR(255) NOT NULL %DESCRIPTION 'The current main publication source such as relevant web site or a government body. FpML specifies mainPublication to be of type mainPublicationSource, but without specifying actual values.',
    interpolationMethod VARCHAR(255) NOT NULL %DESCRIPTION 'The method used when calculating the Inflation Index Level from multiple points. The most common is Linear.',
    initialIndexLevel FLOAT %DESCRIPTION 'Initial known index level for the first calculation period.',
    fallbackBondApplicable INT NOT NULL %DESCRIPTION 'The applicability of a fallback bond as defined in the 2006 ISDA Inflation Derivatives Definitions, sections 1.3 and 1.8.',
    calculationMethod VARCHAR(255) %DESCRIPTION 'Indicates how to use the inflation index to calculate the payment (e.g. Ratio, Return, Spread). Added for Inflation Asset Swap',
    calculationStyle VARCHAR(255) %DESCRIPTION 'Indicates the style of how the inflation index calculates the payment (e.g. YearOnYear, ZeroCoupon).',
    finalPrincipalExchangeCalculation VARCHAR(255) %DESCRIPTION 'To be specified only for products that embed a redemption payment.',
    initialRate VARCHAR(255) %DESCRIPTION 'The initial floating rate reset agreed between the principal parties involved in the trade. This is assumed to be the first required reset rate for the first regular calculation period. It should only be included when the rate is not equal to the rate published on the source implied by the floating rate index. An initial rate of 5% would be represented as 0.05.',
    finalRateRounding VARCHAR(255) %DESCRIPTION 'The rounding convention to apply to the final rate used in determination of a calculation period amount.',
    averagingMethod VARCHAR(255) %DESCRIPTION 'If averaging is applicable, this component specifies whether a weighted or unweighted average method of calculation is to be used. The component must only be included when averaging applies.',
    negativeInterestRateTreatment VARCHAR(255) %DESCRIPTION 'The specification of any provisions for calculating payment obligations when a floating rate is negative (either due to a quoted negative floating rate or by operation of a spread that is subtracted from the floating rate).',
    floatingRateMultiplierSchedule VARCHAR(255) %DESCRIPTION 'A rate multiplier or multiplier schedule to apply to the floating rate. A multiplier schedule is expressed as explicit multipliers and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in the calculationPeriodDatesAdjustments. The multiplier can be a positive or negative decimal. This element should only be included if the multiplier is not equal to 1 (one) for the term of the stream.',
    rateTreatment VARCHAR(255) %DESCRIPTION 'The specification of any rate conversion which needs to be applied to the observed rate before being used in any calculations. The two common conversions are for securities quoted on a bank discount basis which will need to be converted to either a Money Market Yield or Bond Equivalent Yield. See the Annex to the 2000 ISDA Definitions, Section 7.3. Certain General Definitions Relating to Floating Rate Options, paragraphs (g) and (h) for definitions of these terms.',
    calculationParameters VARCHAR(255) %DESCRIPTION 'Support for modular calculated rates, such such as lockout compound calculations.',
    fallbackRate VARCHAR(255) %DESCRIPTION 'Definition of any fallback rate that may be applicable.',
    rateOption VARCHAR(255),
    spreadSchedule VARCHAR(255) %DESCRIPTION 'The ISDA Spread or a Spread schedule expressed as explicit spreads and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    capRateSchedule VARCHAR(255) %DESCRIPTION 'The cap rate or cap rate schedule, if any, which applies to the floating rate. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain level. A cap rate schedule is expressed as explicit cap rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRateSchedule VARCHAR(255) %DESCRIPTION 'The floor rate or floor rate schedule, if any, which applies to the floating rate. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. A floor rate schedule is expressed as explicit floor rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_event_workflow.CustomisedWorkflow (
    CustomisedWorkflow_id INT UNIQUE NOT NULL,
    itemName VARCHAR(255) NOT NULL %DESCRIPTION 'In this initial iteration, this corresponds to the DTCC TIW element name.',
    itemValue VARCHAR(255) NOT NULL %DESCRIPTION 'In this initial iteration, this corresponds to the DTCC value.'
);

CREATE TABLE cdm_observable_asset.SecurityValuation (
    SecurityValuation_id INT UNIQUE NOT NULL,
    securityValuationModel VARCHAR(255) NOT NULL %DESCRIPTION 'The security valuation model choice, based on either a nominal amount or a number of units.',
    underlier VARCHAR(255) NOT NULL %DESCRIPTION 'The underlying security of the security leg.'
);

CREATE TABLE cdm_product_asset_floatingrate.FloatingRateProcessingParameters (
    FloatingRateProcessingParameters_id INT UNIQUE NOT NULL,
    initialRate VARCHAR(255) %DESCRIPTION 'The rate to be applied for the initial period.',
    multiplier FLOAT %DESCRIPTION 'floating rate multiplier.',
    spread FLOAT %DESCRIPTION 'spread to be added to the floating rate.',
    treatment VARCHAR(255) %DESCRIPTION 'US rate treatment (Bond Equivalent Yield or Money Market Yield, if applicable.',
    capRate FLOAT %DESCRIPTION 'capt to be applied to the floating rate.',
    floorRate FLOAT %DESCRIPTION 'floor to be applied to the floating rate.',
    rounding VARCHAR(255) %DESCRIPTION 'THe final rate rounding to be applied.',
    negativeTreatment VARCHAR(255) %DESCRIPTION 'How to handle negative interest rates.'
);

CREATE TABLE cdm_observable_event.ObservationIdentifier (
    ObservationIdentifier_id INT UNIQUE NOT NULL,
    observable VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the asset or rate to which the observation relates.',
    observationDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the date value to use when resolving the market data.',
    observationTime VARCHAR(255) %DESCRIPTION 'Represents the time and time-zone.',
    informationSource VARCHAR(255) %DESCRIPTION 'Represents where the market data published and should be observed.',
    determinationMethodology VARCHAR(255) %DESCRIPTION 'Specifies the method according to which an amount or a date is determined.'
);

CREATE TABLE cdm_product_collateral.AverageTradingVolume (
    AverageTradingVolume_id INT UNIQUE NOT NULL,
    period VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the period of the equities average trading volume on the exchange/s.',
    methodology VARCHAR(255) NOT NULL %DESCRIPTION 'Indicates the type of equity average trading volume being stated (single) the highest amount on one exchange, or (consolidated) volumes across multiple exchanges.'
);

CREATE TABLE cdm_product_template.PortfolioReturnTerms (
    PortfolioReturnTerms_id INT UNIQUE NOT NULL,
    payerReceiver VARCHAR(255) NOT NULL %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each individual return leg.',
    underlier VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the product that is the subject of a tradable product definition, an underlying product definition, a physical exercise, a position, or other purposes.',
    quantity VARCHAR(255) %DESCRIPTION 'Notional quantity of the underlier that applies to each individual return leg.',
    initialValuationPrice VARCHAR(255) %DESCRIPTION 'Specifies the initial valuation price(s) of the underlier. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    interimValuationPrice VARCHAR(255) %DESCRIPTION 'Specifies the initial valuation price(s) of the underlier. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    finalValuationPrice VARCHAR(255) %DESCRIPTION '2018 ISDA CDM Equity Confirmation for Security Equity Swap: Final Price | Specifies the final valuation price of the underlier. This price can be expressed either as an actual amount/currency, as a determination method, or by reference to another value specified in the swap document.',
    priceReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the underlier''s observed price.',
    dividendReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon dividend payments associated to the underlier.',
    varianceReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the observed variance of the underlier''s price.',
    volatilityReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the observed volatility of the underlier''s price.',
    correlationReturnTerms VARCHAR(255) %DESCRIPTION 'Return terms based upon the observed correlation between the components of the underlying basket.'
);

CREATE TABLE cdm_event_common_metafields.ReferenceWithMetaExecutionDetails (
    ReferenceWithMetaExecutionDetails_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.FundProductTypeEnum (
    FundProductTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party_metafields.ReferenceWithMetaParty (
    ReferenceWithMetaParty_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.Lag (
    Lag_id INT UNIQUE NOT NULL,
    lagDuration VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the offset of the series of pricing dates relative to the calculation period.',
    firstObservationDateOffset VARCHAR(255) %DESCRIPTION 'Defines the offset of the series of pricing dates relative to the calculation period.'
);

CREATE TABLE cdm_product_template.StrikeSpread (
    StrikeSpread_id INT UNIQUE NOT NULL,
    upperStrike VARCHAR(255) NOT NULL %DESCRIPTION 'Upper strike in a strike spread.',
    upperStrikeNumberOfOptions FLOAT NOT NULL %DESCRIPTION 'Number of options at the upper strike price in a strike spread.'
);

CREATE TABLE cdm_product_common_settlement.SettlementTypeEnum (
    SettlementTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.SpreadScheduleTypeEnum (
    SpreadScheduleTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.CreditSeniorityEnum (
    CreditSeniorityEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_schedule.DateRelativeToPaymentDates_paymentDatesReference (
    DateRelativeToPaymentDates_id INT NOT NULL,
    ReferenceWithMetaPaymentDates_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.DateRelativeToPaymentDates (
    DateRelativeToPaymentDates_id INT UNIQUE NOT NULL,
    paymentDatesReference INT NOT NULL %DESCRIPTION 'A set of href pointers to payment dates defined somewhere else in the document.'
);

CREATE TABLE cdm_product_common_settlement.ShapingProvision_shapeSchedule (
    ShapingProvision_id INT NOT NULL,
    Money_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.ShapingProvision (
    ShapingProvision_id INT UNIQUE NOT NULL,
    shapeSchedule INT NOT NULL %DESCRIPTION 'Defines applicable settlement limits in each currency.'
);

CREATE TABLE cdm_observable_asset.CreditNotationMismatchResolutionEnum (
    CreditNotationMismatchResolutionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_master.AdditionalDisruptionEvents_additionalBespokeTerms (
    AdditionalDisruptionEvents_id INT NOT NULL,
    Clause_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.AdditionalDisruptionEvents (
    AdditionalDisruptionEvents_id INT UNIQUE NOT NULL,
    changeInLaw INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions: ',
    failureToDeliver INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions',
    insolvencyFiling INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions',
    hedgingDisruption INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions',
    increasedCostOfHedging INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions',
    foreignOwnershipEvent INT %DESCRIPTION 'Per ISDA Def ',
    lossOfStockBorrow INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions:',
    maximumStockLoanRate FLOAT %DESCRIPTION 'Specifies the maximum stock loan rate for Loss of Stock Borrow. A percentage of 5% is represented as 0.05.',
    increasedCostOfStockBorrow INT %DESCRIPTION 'Per 2002 ISDA Equity Derivatives Definitions',
    initialStockLoanRate FLOAT %DESCRIPTION 'Specifies the initial stock loan per ISDA Def. A percentage of 5% is represented as 0.05.',
    determiningParty VARCHAR(255) %DESCRIPTION 'Specifies the party which determines additional disruption events.',
    additionalBespokeTerms INT NOT NULL %DESCRIPTION 'Where parties may optionnaly describe any extra bespoke agreements, in regards of the standardized Extraordinary Events.'
);

CREATE TABLE cdm_legaldocumentation_common.ExecutionLocationEnum (
    ExecutionLocationEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_position.InventoryRecord (
    InventoryRecord_id INT UNIQUE NOT NULL,
    identifer VARCHAR(255) NOT NULL %DESCRIPTION 'Unique identifier for this record. This can be used to uniquely identify a specific piece of inventory.',
    security VARCHAR(255) NOT NULL %DESCRIPTION 'The security details.'
);

CREATE TABLE cdm_product_asset.ReferencePair (
    ReferencePair_id INT UNIQUE NOT NULL,
    referenceEntity VARCHAR(255) NOT NULL %DESCRIPTION 'The corporate or sovereign entity on which you are buying or selling protection and any successor that assumes all or substantially all of its contractual and other obligations. It is vital to use the correct legal name of the entity and to be careful not to choose a subsidiary if you really want to trade protection on a parent company. Please note, Reference Entities cannot be senior or subordinated. It is the obligations of the Reference Entities that can be senior or subordinated. ISDA 2003 Term: Reference Entity.',
    referenceObligation VARCHAR(255) %DESCRIPTION 'The Reference Obligation is a financial instrument that is either issued or guaranteed by the reference entity. It serves to clarify the precise reference entity protection is being offered upon, and its legal position with regard to other related firms (parents/subsidiaries). Furthermore the Reference Obligation is ALWAYS deliverable and establishes the Pari Passu ranking (as the deliverable bonds must rank equal to the reference obligation). ISDA 2003 Term: Reference Obligation.',
    noReferenceObligation INT %DESCRIPTION 'Used to indicate that there is no Reference Obligation associated with this Credit Default Swap and that there will never be one.',
    entityType VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the reference entity types corresponding to a list of types in the ISDA First to Default documentation.'
);

CREATE TABLE cdm_event_position.SecurityLocate_party (
    SecurityLocate_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.SecurityLocate_partyRole (
    SecurityLocate_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.SecurityLocate_availableInventoryRecord (
    SecurityLocate_id INT NOT NULL,
    AvailableInventoryRecord_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.SecurityLocate (
    SecurityLocate_id INT UNIQUE NOT NULL,
    messageInformation VARCHAR(255) %DESCRIPTION 'Allows details related to the availability messaging use case to be defined',
    party INT NOT NULL %DESCRIPTION 'Defines all parties involved for the list of inventory records in this set of inventory. For example, when used to describe securities lending availability, this could hold the sender of the availability, the intended recipient, the beneficial owner(s), the lender (which may differ from the sender as the lender may have the same piece of availability going through multiple agents), an agent or a venue.',
    partyRole INT NOT NULL %DESCRIPTION 'Defines the role(s) that party(ies) may have in relation to the inventory.',
    availableInventoryRecord INT NOT NULL %DESCRIPTION 'An array holding the list of inventory being described. Each element in the inventoryRecord array represents an individual piece of inventory i.e. a security.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterConfirmationAnnexTypeEnum (
    MasterConfirmationAnnexTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.QuotationSideEnum (
    QuotationSideEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.BusinessDayConventionEnum (
    BusinessDayConventionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.PartyRole (
    PartyRole_id INT UNIQUE NOT NULL,
    partyReference VARCHAR(255) NOT NULL %DESCRIPTION 'A reference to the party to which the role refers to.',
    role VARCHAR(255) NOT NULL %DESCRIPTION 'The party role.',
    ownershipPartyReference VARCHAR(255) %DESCRIPTION 'A reference to the party that has ownership of this party role information. FpML specifies that For shared trade information, this attribute will reference the originator of the data (for example, an execution facility or clearing house).'
);

CREATE TABLE cdm_observable_asset.CrossRate (
    CrossRate_id INT UNIQUE NOT NULL,
    rate FLOAT NOT NULL %DESCRIPTION 'The exchange rate used to cross between the traded currencies.',
    spotRate FLOAT %DESCRIPTION 'An optional element used for FX forwards and certain types of FX OTC options. For deals consummated in the FX Forwards Market, this represents the current market rate for a particular currency pair.',
    forwardPoints FLOAT %DESCRIPTION 'An optional element used for deals consummated in the FX Forwards market. Forward points represent the interest rate differential between the two currencies traded and are quoted as a premium or a discount. Forward points are added to, or subtracted from, the spot rate to create the rate of the forward trade.',
    currency1 VARCHAR(255) %DESCRIPTION 'The first currency specified when a pair of currencies is to be evaluated.',
    currency2 VARCHAR(255) %DESCRIPTION 'The second currency specified when a pair of currencies is to be evaluated.',
    quoteBasis VARCHAR(255) %DESCRIPTION 'The method by which the exchange rate is quoted.'
);

CREATE TABLE cdm_product_collateral.CollateralCriteriaBase_issuer (
    CollateralCriteriaBase_id INT NOT NULL,
    IssuerCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralCriteriaBase_asset (
    CollateralCriteriaBase_id INT NOT NULL,
    AssetCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralCriteriaBase_appliesTo (
    CollateralCriteriaBase_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CollateralCriteriaBase (
    CollateralCriteriaBase_id INT UNIQUE NOT NULL,
    issuer INT NOT NULL %DESCRIPTION 'Represents a filter based criteria related to the issuer.',
    asset INT NOT NULL %DESCRIPTION 'Represents a filter based on the criteria related to the asset.',
    appliesTo INT NOT NULL %DESCRIPTION 'Specifies which of the two counterparties the criteria applies to (either one or both counterparties). This attribute is optional, in case the applicable party is already specified elsewhere within a party election.'
);

CREATE TABLE cdm_product_common_settlement.PrincipalPaymentSchedule (
    PrincipalPaymentSchedule_id INT UNIQUE NOT NULL,
    initialPrincipalPayment VARCHAR(255) %DESCRIPTION 'Principal Payment made at Trade inception.',
    intermediatePrincipalPayment VARCHAR(255) %DESCRIPTION 'Principal Payment as part of the Trade lifecycle e.g. as part of notional reset adjustements in a Cross Currency Swap with a varying notional leg.',
    finalPrincipalPayment VARCHAR(255) %DESCRIPTION 'Principal Payment at Trade maturity'
);

CREATE TABLE cdm_product_common_settlement.PayoutBase (
    PayoutBase_id INT UNIQUE NOT NULL,
    payerReceiver VARCHAR(255) NOT NULL %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_product_asset.InterestRatePayout (
    InterestRatePayout_id INT UNIQUE NOT NULL,
    rateSpecification VARCHAR(255) %DESCRIPTION 'The specification of the rate value(s) applicable to the contract using either a floating rate calculation, a single fixed rate, a fixed rate schedule, or an inflation rate calculation.',
    dayCountFraction VARCHAR(255) %DESCRIPTION 'The day count fraction. The cardinality has been relaxed when compared with the FpML interest rate swap for the purpose of accommodating standardized credit default swaps which DCF is not explicitly stated as part of the economic terms. The data rule InterestRatePayout_dayCountFraction requires that the DCF be stated for interest rate products.',
    calculationPeriodDates VARCHAR(255) %DESCRIPTION 'The parameters used to generate the calculation period dates schedule, including the specification of any initial or final stub calculation periods.',
    paymentDates VARCHAR(255) %DESCRIPTION 'The payment date schedule, as defined by the parameters that are needed to specify it, either in a parametric way or by reference to another schedule of dates (e.g. the reset dates).',
    paymentDate VARCHAR(255) %DESCRIPTION 'The payment date, where only one date is specified, as for the FRA product.',
    paymentDelay INT %DESCRIPTION 'Applicable to CDS on MBS to specify whether payment delays are applicable to the fixed Amount. RMBS typically have a payment delay of 5 days between the coupon date of the reference obligation and the payment date of the synthetic swap. CMBS do not, on the other hand, with both payment dates being on the 25th of each month.',
    resetDates VARCHAR(255) %DESCRIPTION 'The reset dates schedule, i.e. the dates on which the new observed index value is applied for each period and the interest rate hence begins to accrue.',
    discountingMethod VARCHAR(255) %DESCRIPTION 'The parameters specifying any discounting conventions that may apply. This element must only be included if discounting applies.',
    compoundingMethod VARCHAR(255) %DESCRIPTION 'If one or more calculation period contributes to a single payment amount this element specifies whether compounding is applicable and, if so, what compounding method is to be used. This element must only be included when more than one calculation period contributes to a single payment amount.',
    cashflowRepresentation VARCHAR(255) %DESCRIPTION 'The cashflow representation of the swap stream.',
    stubPeriod VARCHAR(255) %DESCRIPTION 'The stub calculation period amount parameters. This element must only be included if there is an initial or final stub calculation period. Even then, it must only be included if either the stub references a different floating rate tenor to the regular calculation periods, or if the stub is calculated as a linear interpolation of two different floating rate tenors, or if a specific stub rate or stub amount has been negotiated.',
    bondReference VARCHAR(255) %DESCRIPTION 'Reference to a bond underlier to represent an asset swap or Condition Precedent Bond.',
    fixedAmount VARCHAR(255) %DESCRIPTION 'Fixed Amount Calculation',
    floatingAmount VARCHAR(255) %DESCRIPTION 'Floating Amount Calculation',
    spreadCalculationMethod VARCHAR(255) %DESCRIPTION 'Method by which spread is calculated. For example on an asset swap: ''ParPar'' or ''Proceeds'' may be the method indicated.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_event_common_metafields.ReferenceWithMetaContractDetails (
    ReferenceWithMetaContractDetails_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_master.EquityAdditionalTerms_determinationTerms (
    EquityAdditionalTerms_id INT NOT NULL,
    DeterminationRolesAndTerms_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.EquityAdditionalTerms (
    EquityAdditionalTerms_id INT UNIQUE NOT NULL,
    extraordinaryEvents VARCHAR(255),
    determinationTerms INT NOT NULL,
    substitutionProvision VARCHAR(255)
);

CREATE TABLE cdm_event_common.PartyChangeInstruction_tradeId (
    PartyChangeInstruction_id INT NOT NULL,
    TradeIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.PartyChangeInstruction (
    PartyChangeInstruction_id INT UNIQUE NOT NULL,
    counterparty VARCHAR(255) NOT NULL %DESCRIPTION 'The new counterparty who is stepping into the trade. The stepping out counterparty is inferred based on the counterparty role that is being updated.',
    ancillaryParty VARCHAR(255) %DESCRIPTION 'Specifies an ancillary party to be added onto the new transaction, e.g. the original executing party in an allocation.',
    partyRole VARCHAR(255) %DESCRIPTION 'Specifies an additional party roles to be added on to the new transaction.',
    tradeId INT NOT NULL %DESCRIPTION 'The identifier to be assigned to the new trade post change of party.'
);

CREATE TABLE cdm_product_common_settlement.FxFixingDate (
    FxFixingDate_id INT UNIQUE NOT NULL,
    businessDayConvention VARCHAR(255) %DESCRIPTION 'The convention for adjusting a date if it would otherwise fall on a day that is not a business day, as specified by an ISDA convention (e.g. Following, Precedent).',
    businessCenters VARCHAR(255),
    businessCentersReference VARCHAR(255) %DESCRIPTION 'A reference to a set of financial business centers defined elsewhere in the document. This set of business centers is used to determine whether a particular day is a business day or not.',
    dateRelativeToPaymentDates VARCHAR(255) %DESCRIPTION 'The payment date references on which settlements in non-deliverable currency are due and will then have to be converted according to the terms specified through the other parts of the nonDeliverableSettlement structure.',
    dateRelativeToCalculationPeriodDates VARCHAR(255) %DESCRIPTION 'The calculation period references on which settlements in non-deliverable currency are due and will then have to be converted according to the terms specified through the other parts of the nonDeliverableSettlement structure. Implemented for Brazilian-CDI swaps where it will refer to the termination date of the appropriate leg.',
    dateRelativeToValuationDates VARCHAR(255) %DESCRIPTION 'The calculation period references on which settlements in non-deliverable currency are due and will then have to be converted according to the terms specified through the other parts of the nonDeliverableSettlement structure. Implemented for Brazilian-CDI swaps where it will refer to the termination date of the appropriate leg.',
    fxFixingDate VARCHAR(255) %DESCRIPTION 'Describes the specific date when a non-deliverable forward or cash-settled option will ''fix'' against a particular rate, which will be used to compute the ultimate cash settlement. This element should be omitted where a single, discrete fixing date cannot be identified e.g. on an american option, where fixing may occur at any date on a continuous range.  This attribute was formerly part of ''fxSettlementTerms'', which is now being harmonised into a common ''CashSettlementTerms'' that includes a ''ValuationDate''.',
    dayType VARCHAR(255) %DESCRIPTION 'In the case of an offset specified as a number of days, this element defines whether consideration is given as to whether a day is a good business day or not. If a day type of business days is specified then non-business days are ignored when calculating the offset. The financial business centers to use for determination of business days are implied by the context in which this element is used. This element must only be included when the offset is specified as a number of days. If the offset is zero days then the dayType element should not be included.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2 or 3 etc. A negative value can be used when specifying an offset relative to another date, e.g. -2 days.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month or year of the stream. If the periodMultiplier value is 0 (zero) then period must contain the value D (day).'
);

CREATE TABLE cdm_observable_asset.CreditRatingAgencyEnum (
    CreditRatingAgencyEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.SchedulePeriod (
    SchedulePeriod_id INT UNIQUE NOT NULL,
    calculationPeriod VARCHAR(255) NOT NULL %DESCRIPTION 'Period for which the payment is generated.',
    paymentDate VARCHAR(255) NOT NULL %DESCRIPTION 'Adjusted payment date.',
    fixingPeriod VARCHAR(255) NOT NULL %DESCRIPTION 'Period over which the underlying price is observed.',
    deliveryPeriod VARCHAR(255) %DESCRIPTION 'Period and time profile over which the delivery takes place.'
);

CREATE TABLE cdm_product_collateral.AssetCriteria_collateralAssetType (
    AssetCriteria_id INT NOT NULL,
    AssetType_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AssetCriteria_assetCountryOfOrigin (
    AssetCriteria_id INT NOT NULL,
    ISOCountryCodeEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AssetCriteria_denominatedCurrency (
    AssetCriteria_id INT NOT NULL,
    CurrencyCodeEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AssetCriteria_agencyRating (
    AssetCriteria_id INT NOT NULL,
    AgencyRatingCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AssetCriteria_productIdentifier (
    AssetCriteria_id INT NOT NULL,
    ProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AssetCriteria_collateralTaxonomy (
    AssetCriteria_id INT NOT NULL,
    CollateralTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AssetCriteria (
    AssetCriteria_id INT UNIQUE NOT NULL,
    collateralAssetType INT NOT NULL %DESCRIPTION 'Represents a filter based on the asset product type.',
    assetCountryOfOrigin INT NOT NULL %DESCRIPTION 'Represents a filter on the asset country of origin based on the ISO Standard 3166.',
    denominatedCurrency INT NOT NULL %DESCRIPTION 'Represents a filter on the underlying asset denominated currency based on ISO Standards.',
    agencyRating INT NOT NULL %DESCRIPTION 'Represents an agency rating based on default risk and creditors claim in event of default associated with specific instrument.',
    maturityType VARCHAR(255) %DESCRIPTION 'Specifies whether the maturity range is the remaining or original maturity.',
    maturityRange VARCHAR(255) %DESCRIPTION 'Represents a filter based on the underlying asset maturity.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Represents a filter based on specific instrument identifiers (e.g. specific ISINs, CUSIPs etc).',
    collateralTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the collateral taxonomy,which is composed of a taxonomy value and a taxonomy source.',
    domesticCurrencyIssued INT %DESCRIPTION 'Identifies that the Security must be denominated in the domestic currency of the issuer.',
    listing VARCHAR(255) %DESCRIPTION 'Specifies the exchange, index or sector specific to listing of a security.'
);

CREATE TABLE cdm_product_common_settlement.SettlementDate (
    SettlementDate_id INT UNIQUE NOT NULL,
    adjustableOrRelativeDate VARCHAR(255) %DESCRIPTION 'A single settlement date subject to adjustment or specified as relative to another date (e.g. the trade date). This attribute was formerly part of ''SettlementTerms'', which is now being harmonised to include a common ''SettlementDate'', as inherited from ''SettlementBase''.',
    valueDate VARCHAR(255) %DESCRIPTION 'The settlement date for a forward settling product. For Foreign Exchange contracts, this represents a common settlement date between both currency legs. To specify different settlement dates for each currency leg, see the ForeignExchange class. This attribute was formerly part of ''SettlementTerms'', which is now being harmonised to include a common ''SettlementDate'', as inherited from ''SettlementBase''.',
    adjustableDates VARCHAR(255) %DESCRIPTION 'A series of dates that shall be subject to adjustment if they would otherwise fall on a day that is not a business day in the specified business centers, together with the convention for adjusting the date. This attributes was formerly part of ''CashSettlementPaymentDate'' as included into ''OptionCashSettlement'' (which is now merged into a unique ''CashSettlementTerms'' data type.',
    businessDateRange VARCHAR(255) %DESCRIPTION 'A range of contiguous business days. This attribute is meant to be merged with the ''settlementDate'' at some future point once we refactor ''Date'' to use a single complex type across the model. This attributes was formerly part of ''CashSettlementPaymentDate'', as included into ''OptionCashSettlement'' (which is now merged into a unique ''CashSettlementTerms'' data type.',
    cashSettlementBusinessDays INT %DESCRIPTION 'The number of business days used in the determination of the cash settlement payment date. If a cash settlement amount is specified, the cash settlement payment date will be this number of business days following the calculation of the final price. If a cash settlement amount is not specified, the cash settlement payment date will be this number of business days after all conditions to settlement are satisfied. ISDA 2003 Term: Cash Settlement Date. This attribute was formerly part of ''CashSettlementTerms'' as used for credit event settlement, which now includes a common ''SettlementDate'' attribute.',
    paymentDelay INT %DESCRIPTION 'Applicable to CDS on MBS to specify whether payment delays are applicable to the fixed Amount. RMBS typically have a payment delay of 5 days between the coupon date of the reference obligation and the payment date of the synthetic swap. CMBS do not, on the other hand, with both payment dates being on the 25th of each month.'
);

CREATE TABLE cdm_regulation.AcctOwnr (
    AcctOwnr_id INT UNIQUE NOT NULL,
    id VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_asset.DiscountingMethod (
    DiscountingMethod_id INT UNIQUE NOT NULL,
    discountingType VARCHAR(255) NOT NULL %DESCRIPTION 'The discounting method that is applicable.',
    discountRate FLOAT %DESCRIPTION 'A discount rate, expressed as a decimal, to be used in the calculation of a discounted amount. A discount amount of 5% would be represented as 0.05.',
    discountRateDayCountFraction VARCHAR(255) %DESCRIPTION 'A discount day count fraction to be used in the calculation of a discounted amount.'
);

CREATE TABLE cdm_product_template.FixedPricePayout (
    FixedPricePayout_id INT UNIQUE NOT NULL,
    paymentDates VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the parameters to generate the payment date schedule, either through a parametric representation or by reference to specified dates.',
    fixedPrice VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the fixed price on which fixed forward payments are based.',
    schedule VARCHAR(255) %DESCRIPTION 'Allows the full representation of a payout by defining a set of schedule periods. It supports standard schedule customization by expressing all the dates, quantities, and pricing data in a non-parametric way.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_base_datetime_metafields.ReferenceWithMetaAdjustableOrRelativeDates (
    ReferenceWithMetaAdjustableOrRelativeDates_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_event.Observation (
    Observation_id INT UNIQUE NOT NULL,
    observedValue VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the observed value as a number.',
    observationIdentifier VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the observation was made i.e. how to uniquely identify the observed value among the population of all available market data.'
);

CREATE TABLE cdm_event_common.CollateralBalance (
    CollateralBalance_id INT UNIQUE NOT NULL,
    collateralBalanceStatus VARCHAR(255) %DESCRIPTION 'Defines the collateral balance breakdown of settlement status.',
    haircutIndicator VARCHAR(255) %DESCRIPTION 'Indicates if the collateral balance amount is based on pre or post haircut, if a haircut is associated with the collateral asset',
    amountBaseCurrency VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the collateral balance amount in base currency determined within a collateral legal agreement, or defined for reporting purposes.',
    payerReceiver VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies each of the parties in the collateral balance and its perspective with regards to the direction of the collateral balance, posted or received.'
);

CREATE TABLE cdm_observable_asset.MakeWholeAmount (
    MakeWholeAmount_id INT UNIQUE NOT NULL,
    interpolationMethod VARCHAR(255) %DESCRIPTION 'The type of interpolation method that the calculation agent reserves the right to use.',
    earlyCallDate VARCHAR(255) NOT NULL %DESCRIPTION 'Date prior to which the option buyer will have to pay a Make Whole Amount to the option seller if he/she exercises the option.',
    floatingRateIndex VARCHAR(255),
    indexTenor VARCHAR(255) %DESCRIPTION 'The ISDA Designated Maturity, i.e. the tenor of the floating rate.',
    spread FLOAT %DESCRIPTION 'Spread in basis points over the floating rate index.',
    side VARCHAR(255) %DESCRIPTION 'The side (bid/mid/ask) of the measure.'
);

CREATE TABLE cdm_product_template.InitialMargin_margin (
    InitialMargin_id INT NOT NULL,
    InitialMarginCalculation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.InitialMargin (
    InitialMargin_id INT UNIQUE NOT NULL,
    marginType VARCHAR(255) NOT NULL %DESCRIPTION 'An element defining the type of assets (cash or securities) specified to apply as margin to the repo transaction. See GMRA 2011 paragraph 2(h) for ''Cash Margin'' and GMRA 2011 paragraph 2(cc) for ''Margin Securities''.',
    margin INT NOT NULL %DESCRIPTION 'Initial margin calculation for a collateral asset. Initial margin requirements may be specified for multiple pieces of collateral.',
    marginThreshold VARCHAR(255) %DESCRIPTION 'An element defining a margin threshold which is the Net Exposure of a trade below which parties agree they will not call a margin from each other.',
    minimumTransferAmount VARCHAR(255) %DESCRIPTION 'An element defining a minimum transfer amount which is the minimum margin call parties will make once the margin threshold (or margin ratio threshold / haircut threshold) has been exceeded.'
);

CREATE TABLE cdm_event_common.MarginCallResponseTypeEnum (
    MarginCallResponseTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.ExecutionDetails (
    ExecutionDetails_id INT UNIQUE NOT NULL,
    executionType VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the type of execution, e.g. via voice, electronically...',
    executionVenue VARCHAR(255) %DESCRIPTION 'Represents the venue on which a trade was executed.',
    packageReference VARCHAR(255) %DESCRIPTION 'A reference to the package linking the trade with other trades, in case the trade was executed as part of a package (hence this attribute is optional).'
);

CREATE TABLE cdm_base_staticdata_party.RelatedParty (
    RelatedParty_id INT UNIQUE NOT NULL,
    partyReference VARCHAR(255) NOT NULL %DESCRIPTION 'Reference to a party.',
    accountReference VARCHAR(255) %DESCRIPTION 'Reference to an account.',
    role VARCHAR(255) NOT NULL %DESCRIPTION 'The category of the relationship. The related party performs the role specified in this field for the base party. For example, if the role is ,Guarantor, the related party acts as a guarantor for the base party.'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaInformationProviderEnum (
    FieldWithMetaInformationProviderEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_math.NonNegativeStep (
    NonNegativeStep_id INT UNIQUE NOT NULL,
    stepDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the associated stepValue becomes effective. This day may be subject to adjustment in accordance with a business day convention.',
    stepValue FLOAT NOT NULL %DESCRIPTION 'The non-negative rate or amount which becomes effective on the associated stepDate. A rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_asset.NegativeInterestRateTreatmentEnum (
    NegativeInterestRateTreatmentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.Quanto_fxRate (
    Quanto_id INT NOT NULL,
    FxRate_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.Quanto (
    Quanto_id INT UNIQUE NOT NULL,
    fxRate INT NOT NULL %DESCRIPTION 'Specifies a currency conversion rate.',
    fxSpotRateSource VARCHAR(255) %DESCRIPTION 'Specifies the methodology (reference source and, optionally, fixing time) to be used for determining a currency conversion rate.',
    fixingTime VARCHAR(255) %DESCRIPTION 'The time at which the spot currency exchange rate will be observed. It is specified as a time in a business day calendar location, e.g. 11:00am London time.'
);

CREATE TABLE cdm_product_common_settlement.CommodityPriceReturnTerms (
    CommodityPriceReturnTerms_id INT UNIQUE NOT NULL,
    rounding VARCHAR(255) %DESCRIPTION 'Defines rounding rules and precision to be used in the rounding of a number.',
    spread VARCHAR(255) %DESCRIPTION 'Defines a spread value for one or more defined dates.',
    rollFeature VARCHAR(255) %DESCRIPTION 'Used in conjunction with an exchange-based pricing source. Identifies a way in which the futures contracts referenced will roll between periods. ',
    conversionFactor FLOAT %DESCRIPTION 'Defines the conversion applied if the quantity unit on contract is different from unit on referenced underlier.'
);

CREATE TABLE cdm_base_staticdata_identifier.LocationIdentifier_assignedIdentifier (
    LocationIdentifier_id INT NOT NULL,
    AssignedIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_identifier.LocationIdentifier (
    LocationIdentifier_id INT UNIQUE NOT NULL,
    locationIdentifierType VARCHAR(255) %DESCRIPTION 'Specifies the nature of a location identifier.',
    issuerReference VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified by reference to a party specified as part of the transaction.',
    issuer VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified explicitly alongside the identifier value (instead of being specified by reference to a party).',
    assignedIdentifier INT NOT NULL %DESCRIPTION 'The identifier value. This level of indirection between the issuer and the identifier and its version provides the ability to associate multiple identifiers to one issuer, consistently with the FpML PartyTradeIdentifier.'
);

CREATE TABLE cdm_product_asset.CompoundingMethodEnum (
    CompoundingMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.AssetDeliveryProfileBlock_dayOfWeek (
    AssetDeliveryProfileBlock_id INT NOT NULL,
    DayOfWeekEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.AssetDeliveryProfileBlock (
    AssetDeliveryProfileBlock_id INT UNIQUE NOT NULL,
    startTime VARCHAR(255) %DESCRIPTION 'The start time of the delivery interval for each block or shape.',
    endTime VARCHAR(255) %DESCRIPTION 'The end time of the delivery interval for each block or shape.',
    dayOfWeek INT NOT NULL %DESCRIPTION 'The days of the week of the delivery.',
    deliveryCapacity VARCHAR(255) %DESCRIPTION 'The number of units included in the transaction for each delivery interval',
    priceTimeIntervalQuantity VARCHAR(255) %DESCRIPTION 'Price per quantity per delivery time interval.'
);

CREATE TABLE cdm_product_asset.DividendReturnTerms_dividendPayoutRatio (
    DividendReturnTerms_id INT NOT NULL,
    DividendPayoutRatio_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.DividendReturnTerms_dividendPeriod (
    DividendReturnTerms_id INT NOT NULL,
    DividendPeriod_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.DividendReturnTerms (
    DividendReturnTerms_id INT UNIQUE NOT NULL,
    dividendPayoutRatio INT NOT NULL %DESCRIPTION 'Specifies the dividend payout ratio associated with each underlier. In FpML 5.10 the payout is positioned at the underlier level, although there is an intent to reconsider this approach and position it at the leg level. This is approach adopted by the CDM.',
    dividendReinvestment INT %DESCRIPTION 'Boolean element that defines whether the dividend will be reinvested or not.',
    dividendEntitlement VARCHAR(255) %DESCRIPTION 'Defines the date on which the receiver of the equity return is entitled to the dividend.',
    dividendAmountType VARCHAR(255) %DESCRIPTION 'Specifies whether the dividend is paid with respect to the Dividend Period.',
    performance VARCHAR(255) %DESCRIPTION 'Performance calculation, in accordance with Part 1 Section 12 of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap, Para 75. ''Equity Performance''. Cumulative performance is used as a notional multiplier factor on both legs of an Equity Swap.',
    firstOrSecondPeriod VARCHAR(255) %DESCRIPTION '2002 ISDA Equity Derivatives Definitions: Dividend Period as either the First Period or the Second Period. | ',
    extraordinaryDividendsParty VARCHAR(255) %DESCRIPTION 'Specifies the party which determines if dividends are extraordinary in relation to normal levels.',
    excessDividendAmount VARCHAR(255) %DESCRIPTION 'Determination of Gross Cash Dividend per Share.',
    dividendCurrency VARCHAR(255) %DESCRIPTION 'Specifies the currency in which the dividend will be denominated, e.g. the dividend currency, or a specified currency. This class is not specified as such in FpML, which makes use of the CurrencyAndDeterminationMethod.model to specify such terms.',
    nonCashDividendTreatment VARCHAR(255) %DESCRIPTION 'Specifies the treatment of Non-Cash Dividends.',
    dividendComposition VARCHAR(255) %DESCRIPTION 'Specifies how the composition of Dividends is to be determined.',
    specialDividends INT %DESCRIPTION 'Specifies the method according to which special dividends are determined.',
    materialDividend INT %DESCRIPTION 'If present and true, then material non cash dividends are applicable.',
    dividendPeriod INT NOT NULL %DESCRIPTION 'One to many time bounded dividend payment periods, each with a dividend payment date per period.'
);

CREATE TABLE cdm_base_datetime.RollConventionEnum (
    RollConventionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_schedule.ObservationTerms (
    ObservationTerms_id INT UNIQUE NOT NULL,
    pricingTime VARCHAR(255) %DESCRIPTION 'Defines time in respect to a business calendar location that the price/benchmark/index is observed',
    pricingTimeType VARCHAR(255) %DESCRIPTION 'The enumerated values to specify points in the day when option exercise and valuation can occur.',
    informationSource VARCHAR(255) %DESCRIPTION 'The information source where a published or displayed market rate will be obtained, e.g. Telerate Page 3750.',
    precision VARCHAR(255) %DESCRIPTION 'Defines rounding rules and precision to be used in the rounding of observations.',
    calculationPeriodDates VARCHAR(255) %DESCRIPTION 'Defines parameters used to generate the calculation period dates schedule, including the specification of any initial or final stub calculation periods. A calculation period schedule consists of an optional initial stub calculation period, one or more regular calculation periods and an optional final stub calculation period. In the absence of any initial or final stub calculation periods, the regular part of the calculation period schedule is assumed to be between the effective date and the termination date. No implicit stubs are allowed, i.e. stubs must be explicitly specified using an appropriate combination of firstPeriodStartDate, firstRegularPeriodStartDate and lastRegularPeriodEndDate.',
    observable VARCHAR(255) %DESCRIPTION 'Specifies the object to be observed for a price, it could be an asset or a reference.',
    observationDates VARCHAR(255) NOT NULL %DESCRIPTION 'Describes date details for a set of observation dates in parametric or non-parametric form.',
    numberOfObservationDates INT %DESCRIPTION 'The number of observation dates between observation start date and observation end date.'
);

CREATE TABLE cdm_product_common_settlement.CashflowType (
    CashflowType_id INT UNIQUE NOT NULL,
    cashflowType VARCHAR(255) %DESCRIPTION 'Type of cashflow corresponding to a scheduled event.',
    cashPrice VARCHAR(255) %DESCRIPTION 'Type of cashflow corresponding to a non-scheduled event, where a price must be agreed between the parties.',
    priceExpression VARCHAR(255)
);

CREATE TABLE cdm_base_math.UnitType (
    UnitType_id INT UNIQUE NOT NULL,
    capacityUnit VARCHAR(255) %DESCRIPTION 'Provides an enumerated value for a capacity unit, generally used in the context of defining quantities for commodities.',
    weatherUnit VARCHAR(255) %DESCRIPTION 'Provides an enumerated values for a weather unit, generally used in the context of defining quantities for commodities.',
    financialUnit VARCHAR(255) %DESCRIPTION 'Provides an enumerated value for financial units, generally used in the context of defining quantities for securities.',
    currency VARCHAR(255) %DESCRIPTION 'Defines the currency to be used as a unit for a price, quantity, or other purpose.'
);

CREATE TABLE cdm_base_staticdata_asset_common.SpecialPurposeVehicleIssuerType (
    SpecialPurposeVehicleIssuerType_id INT UNIQUE NOT NULL,
    creditRisk VARCHAR(255) %DESCRIPTION 'Indicates tranched or untranched credit risk.'
);

CREATE TABLE cdm_observable_event.FieldWithMetaMarketDisruptionEnum (
    FieldWithMetaMarketDisruptionEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.Money_datedValue (
    Money_id INT NOT NULL,
    DatedValue_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.Money (
    Money_id INT UNIQUE NOT NULL,
    multiplier VARCHAR(255) %DESCRIPTION 'Defines an optional number that the quantity should be multiplied by to derive a total quantity. This number is associated to a unit. For example in the case of the Coal (API2) CIF ARA (ARGUS-McCloskey) Futures Contract on the CME, where the unit would be contracts, the multiplier value would 1,000 and the mulitiplier unit would be 1,000 MT (Metric Tons).',
    frequency VARCHAR(255) %DESCRIPTION 'Defines the frequency to be used when defining a quantity. For example a quantity may be specified as a number of barrels of oil per day, which needs multiplying by the number of days in the relevant period to get the total quantity as a number of barrels.',
    datedValue INT NOT NULL %DESCRIPTION 'A schedule of step date and value pairs. On each step date the associated step value becomes effective. The step dates are used to order the steps by ascending order. This attribute is optional so the data type may be used to define a schedule with a single value.',
    value FLOAT %DESCRIPTION 'Specifies the value of the measure as a number. Optional because in a measure vector or schedule, this single value may be omitted.',
    unit VARCHAR(255) %DESCRIPTION 'Qualifies the unit by which the amount is measured. Optional because a measure may be unit-less (e.g. when representing a ratio between amounts in the same unit).'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaPriceSchedule (
    FieldWithMetaPriceSchedule_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.ValuationSource (
    ValuationSource_id INT UNIQUE NOT NULL,
    quotedCurrencyPair VARCHAR(255) %DESCRIPTION 'Defines the two currencies for an FX trade and the quotation relationship between the two currencies.  This attribute was formerly part of ''fxSettlementTerms'', which is now being harmonised into a common ''CashSettlementTerms'' that includes a ''ValuationDate''.',
    informationSource VARCHAR(255) %DESCRIPTION 'The information source where a published or displayed market rate will be obtained, e.g. Telerate Page 3750.',
    settlementRateOption VARCHAR(255) %DESCRIPTION 'The rate option to use for the fixing. Currently only applicable to foreign exchange fixing in case of cross-currency settlement.',
    referenceBanks VARCHAR(255) %DESCRIPTION 'A container for a set of reference institutions that may be called upon to provide rate quotations as part of the method to determine the applicable cash settlement amount. If institutions are not specified, it is assumed that reference institutions will be agreed between the parties on the exercise date, or in the case of swap transaction to which mandatory early termination is applicable, the cash settlement valuation date.',
    dealerOrCCP VARCHAR(255) %DESCRIPTION 'Holds an identifier for the reference entity that is agreed by both parties as a basis for cash settlement calculations. This could be a dealer from whom quotations are obtained by the calculation agent on the reference obligation for purposes of cash settlement in a credit event. ISDA 2003 Term: Dealer. This could be the clearing organization (CCP, DCO) to which the trade should be cleared, as applicable for cash-settled swaptions.'
);

CREATE TABLE cdm_product_common_schedule.CalculationPeriod (
    CalculationPeriod_id INT UNIQUE NOT NULL,
    unadjustedStartDate VARCHAR(255) %DESCRIPTION 'The calculation start date, unadjusted.',
    unadjustedEndDate VARCHAR(255) %DESCRIPTION 'The calculation end date, unadjusted.',
    calculationPeriodNumberOfDays INT %DESCRIPTION 'The number of days from the adjusted effective / start date to the adjusted termination / end date calculated in accordance with the applicable day count fraction.',
    notionalAmount FLOAT %DESCRIPTION 'The amount that a cashflow will accrue interest on.',
    fxLinkedNotionalAmount VARCHAR(255) %DESCRIPTION 'The amount that a cashflow will accrue interest on. This is the calculated amount of the FX linked - i.e. the other currency notional amount multiplied by the appropriate FX spot rate.',
    floatingRateDefinition VARCHAR(255) %DESCRIPTION 'The floating rate reset information for the calculation period.',
    fixedRate FLOAT %DESCRIPTION 'The calculation period fixed rate. A per annum rate, expressed as a decimal. A fixed rate of 5% would be represented as 0.05.',
    dayCountYearFraction FLOAT %DESCRIPTION 'The year fraction value of the calculation period, result of applying the ISDA rules for day count fraction defined in the ISDA Annex.',
    forecastAmount VARCHAR(255) %DESCRIPTION 'The amount representing the forecast of the accrued value of the calculation period. An intermediate value used to generate the forecastPaymentAmount in the PaymentCalculationPeriod.',
    forecastRate FLOAT %DESCRIPTION 'A value representing the forecast rate used to calculate the forecast future value of the accrual period. This is a calculated rate determined based on averaging the rates in the rateObservation elements, and incorporates all of the rate treatment and averaging rules. A value of 1% should be represented as 0.01.',
    adjustedStartDate VARCHAR(255) %DESCRIPTION 'The calculation period start date, adjusted according to any relevant business day convention.',
    adjustedEndDate VARCHAR(255) %DESCRIPTION 'The calculation period end date, adjusted according to any relevant business day convention.'
);

CREATE TABLE cdm_regulation.SwpIn (
    SwpIn_id INT UNIQUE NOT NULL,
    sngl VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreementPublisherEnum (
    LegalAgreementPublisherEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.DebtSeniorityEnum (
    DebtSeniorityEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE com_rosetta_model.FieldWithMetaString (
    FieldWithMetaString_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.FieldWithMetaCreditSupportAgreementTypeEnum (
    FieldWithMetaCreditSupportAgreementTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_regulation.Sngl (
    Sngl_id INT UNIQUE NOT NULL,
    isin VARCHAR(255) NOT NULL,
    indx VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralTaxonomyValue_eu_EMIR_EligibleCollateral (
    CollateralTaxonomyValue_id INT NOT NULL,
    EU_EMIR_EligibleCollateralEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralTaxonomyValue_uk_EMIR_EligibleCollateral (
    CollateralTaxonomyValue_id INT NOT NULL,
    UK_EMIR_EligibleCollateralEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralTaxonomyValue_us_CFTC_PR_EligibleCollateral (
    CollateralTaxonomyValue_id INT NOT NULL,
    US_CFTC_PR_EligibleCollateralEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralTaxonomyValue_nonEnumeratedTaxonomyValue (
    CollateralTaxonomyValue_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.CollateralTaxonomyValue (
    CollateralTaxonomyValue_id INT UNIQUE NOT NULL,
    eu_EMIR_EligibleCollateral INT NOT NULL %DESCRIPTION 'Identifies European Union Eligible Collateral Assets classification categories based on EMIR Uncleared Margin Rules. Eligible Collateral asset classes for both initial margin (IM) and variation margin (VM) posted and collected between specified entities. Please note: EMIR regulation will detail which eligible collateral assets classes apply to each type of entity pairing (counterparty) and which apply to posting of IM and VM',
    uk_EMIR_EligibleCollateral INT NOT NULL %DESCRIPTION 'Identifies United Kingdom Eligible Collateral Assets classification categories based on UK Onshored EMIR Uncleared Margin Rules Eligible Collateral asset classes for both initial margin (IM) and variation margin (VM) posted and collected between specified entities. Please note: UK EMIR regulation will detail which eligible collateral assets classes apply to each type of entity pairing (counterparty) and which apply to posting of IM and VM.',
    us_CFTC_PR_EligibleCollateral INT NOT NULL %DESCRIPTION 'Identifies US Eligible Collateral Assets classification categories based on Uncleared Margin Rules published by the CFTC and the US Prudential Regulator. Note: While the same basic categories exist in the CFTC and US Prudential Regulators’ margin rules, the precise definitions or application of those rules could differ between the two rules.',
    nonEnumeratedTaxonomyValue INT NOT NULL %DESCRIPTION 'Identifies the taxonomy value when not specified as an enumeration.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementSchedule_clause (
    MasterAgreementSchedule_id INT NOT NULL,
    MasterAgreementClause_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementSchedule (
    MasterAgreementSchedule_id INT UNIQUE NOT NULL,
    clause INT NOT NULL %DESCRIPTION 'Clauses that have had elections made against them in this Master Agreement. There must be at least one clause defined in the agreement.'
);

CREATE TABLE cdm_observable_event.FeaturePayment (
    FeaturePayment_id INT UNIQUE NOT NULL,
    payerReceiver VARCHAR(255) NOT NULL %DESCRIPTION 'This attribute doesn''t exist as part of the FpML construct, which makes use of the PayerReceiver.model group.',
    levelPercentage FLOAT %DESCRIPTION 'The trigger level percentage.',
    amount FLOAT %DESCRIPTION 'The monetary quantity in currency units.',
    time VARCHAR(255) %DESCRIPTION 'The feature payment time.',
    currency VARCHAR(255) %DESCRIPTION 'The currency in which an amount is denominated.',
    paymentDate VARCHAR(255) %DESCRIPTION 'The feature payment date.'
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreementBase_identifier (
    LegalAgreementBase_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreementBase_contractualParty (
    LegalAgreementBase_id INT NOT NULL,
    ReferenceWithMetaParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreementBase_otherParty (
    LegalAgreementBase_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreementBase_attachment (
    LegalAgreementBase_id INT NOT NULL,
    Resource_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreementBase (
    LegalAgreementBase_id INT UNIQUE NOT NULL,
    agreementDate VARCHAR(255) %DESCRIPTION 'The date on which the legal agreement has been agreed between the parties. This corresponds to the Date of Deed in an English Law document.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date on which, or as of which, the agreement is effective, if different from the agreement date. It is expected that it will most often correspond to the agreement date, although there could be situations where the parties will explicitly agree on a distinct effective date.',
    identifier INT NOT NULL %DESCRIPTION 'The legal agreement identifier. Several identifiers can be specified.',
    legalAgreementIdentification VARCHAR(255) NOT NULL %DESCRIPTION 'The type of legal agreement, identified via a set of composable attributes: agreementName, publisher, governing law and version, e.g. ISDA 2013 Standard Credit Support Annex English Law.',
    contractualParty INT NOT NULL %DESCRIPTION 'The two contractual parties to the legal agreement, which reference information is positioned as part of the partyInformation attribute.',
    otherParty INT NOT NULL %DESCRIPTION 'The role(s) that other party(ies) may have in relation to the legal agreement, further to the contractual parties.',
    attachment INT NOT NULL %DESCRIPTION 'A human readable document, for example a confirmation.'
);

CREATE TABLE cdm_observable_asset_metafields.ReferenceWithMetaPerformanceValuationDates (
    ReferenceWithMetaPerformanceValuationDates_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_master.EquityMasterConfirmation (
    EquityMasterConfirmation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.PortfolioState_positions (
    PortfolioState_id INT NOT NULL,
    Position_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.PortfolioState (
    PortfolioState_id INT UNIQUE NOT NULL,
    positions INT NOT NULL %DESCRIPTION 'The list of positions, each containing a Quantity and a Product.',
    lineage VARCHAR(255) NOT NULL %DESCRIPTION 'Pointer to the previous PortfolioState and new Event(s) leading to the current (new) state. Previous PortfolioState in the Lineage can be Null in case this is the start of the chain of Events.'
);

CREATE TABLE cdm_legaldocumentation_common.AddressForNotices_additionalNotices (
    AddressForNotices_id INT NOT NULL,
    PartyContactInformation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.AddressForNotices (
    AddressForNotices_id INT UNIQUE NOT NULL,
    primaryNotices VARCHAR(255) NOT NULL %DESCRIPTION 'Specification of primary notice details',
    additionalNotices INT NOT NULL %DESCRIPTION 'The optional specification of additional information when a party requires notices to be delivered to more than one address.'
);

CREATE TABLE cdm_observable_asset_fro.FloatingRateIndexIdentification (
    FloatingRateIndexIdentification_id INT UNIQUE NOT NULL,
    floatingRateIndex VARCHAR(255) %DESCRIPTION 'The reference index that is used to specify the floating interest rate. The FpML standard maintains the list of such indices, which are positioned as enumeration values as part of the CDM.',
    currency VARCHAR(255) %DESCRIPTION 'FRO currency - 3 character ISO currrency code',
    froType VARCHAR(255) %DESCRIPTION 'FRO type (e.g. OIS)'
);

CREATE TABLE cdm_legaldocumentation_common.GoverningLawEnum (
    GoverningLawEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.FallbackReferencePrice_fallBackSettlementRateOption (
    FallbackReferencePrice_id INT NOT NULL,
    FieldWithMetaSettlementRateOptionEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.FallbackReferencePrice (
    FallbackReferencePrice_id INT UNIQUE NOT NULL,
    valuationPostponement VARCHAR(255) %DESCRIPTION 'Specifies how long to wait to get a quote from a settlement rate option upon a price source disruption.',
    fallBackSettlementRateOption INT NOT NULL %DESCRIPTION 'This settlement rate option will be used in its place.',
    fallbackSurveyValuationPostponement INT %DESCRIPTION 'Request rate quotes from the market. This element is set as type Empty in FpML. When present, the FpML synonym is mapped to a value True in the CDM.',
    calculationAgentDetermination VARCHAR(255) %DESCRIPTION 'The calculation agent will decide the rate.'
);

CREATE TABLE cdm_event_common.ContractDetails_documentation (
    ContractDetails_id INT NOT NULL,
    LegalAgreement_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ContractDetails (
    ContractDetails_id INT UNIQUE NOT NULL,
    documentation INT NOT NULL %DESCRIPTION 'Represents the legal document(s) that governs a trade and associated contractual product terms, either as a reference to such documents when specified as part of the CDM, or through identification of some of the key terms of those documents, such as the type of document, the document identifier, the publisher, the document vintage and the agreement date.',
    governingLaw VARCHAR(255) %DESCRIPTION 'Represents the law governing the trade and associated contractual product terms.'
);

CREATE TABLE cdm_product_template.ForwardPayout (
    ForwardPayout_id INT UNIQUE NOT NULL,
    underlier VARCHAR(255) NOT NULL %DESCRIPTION 'Underlying product that the forward is written on, which can be of any type: FX, a contractual product, a security, etc.',
    deliveryTerm VARCHAR(255) %DESCRIPTION 'Also called contract month or delivery month. However, it''s not always a month. It is usually expressed using a code, e.g. Z23 would be the Dec 2023 contract, (Z = December). For crude oil, the corresponding contract might be called CLZ23.',
    delivery VARCHAR(255) %DESCRIPTION 'Contains the information relative to the delivery of the asset.',
    schedule VARCHAR(255) %DESCRIPTION 'Allows the full representation of a payout by defining a set of schedule periods. It supports standard schedule customization by expressing all the dates, quantities, and pricing data in a non-parametric way.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_regulation.Sellr (
    Sellr_id INT UNIQUE NOT NULL,
    acctOwnr VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_asset.ProtectionTerms (
    ProtectionTerms_id INT UNIQUE NOT NULL,
    creditEvents VARCHAR(255) %DESCRIPTION 'Specifies the applicable Credit Events that would trigger a settlement, as specified in the related Confirmation and defined in the ISDA 2014 Credit Definition article IV section 4.1.',
    obligations VARCHAR(255) %DESCRIPTION 'The underlying obligations of the reference entity on which you are buying or selling protection. The credit events Failure to Pay, Obligation Acceleration, Obligation Default, Restructuring, Repudiation/Moratorium are defined with respect to these obligations.',
    floatingAmountEvents VARCHAR(255) %DESCRIPTION 'This element contains the ISDA terms relating to the floating rate payment events and the implied additional fixed payments, applicable to the credit derivatives transactions on mortgage-backed securities with pay-as-you-go or physical settlement.'
);

CREATE TABLE cdm_regulation.Tx (
    Tx_id INT UNIQUE NOT NULL,
    newTx VARCHAR(255) NOT NULL,
    tradDt VARCHAR(255) NOT NULL,
    tradgCpcty VARCHAR(255) NOT NULL,
    qty VARCHAR(255) NOT NULL,
    pric VARCHAR(255) NOT NULL,
    tradVn VARCHAR(255) NOT NULL,
    ctryOfBrnch VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_math.WeatherUnitEnum (
    WeatherUnitEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_regulation.OrdrTrnsmssn (
    OrdrTrnsmssn_id INT UNIQUE NOT NULL,
    trnsmssnInd VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_common_settlement.PhysicalSettlementTerms (
    PhysicalSettlementTerms_id INT UNIQUE NOT NULL,
    clearedPhysicalSettlement INT %DESCRIPTION 'Specifies whether the swap resulting from physical settlement of the swaption transaction will clear through a clearing house. The meaning of Cleared Physical Settlement is defined in the 2006 ISDA Definitions, Section 15.2 (published in Supplement number 28).',
    predeterminedClearingOrganizationParty VARCHAR(255) %DESCRIPTION 'Specifies the clearing organization (CCP, DCO) to which the trade should be cleared.',
    physicalSettlementPeriod VARCHAR(255) %DESCRIPTION 'The number of business days used in the determination of the physical settlement date. The physical settlement date is this number of business days after all applicable conditions to settlement are satisfied. If a number of business days is not specified fallback provisions apply for determining the number of business days. If Section 8.5/8.6 of the 1999/2003 ISDA Definitions are to apply the businessDaysNotSpecified element should be included. If a specified number of business days are to apply these should be specified in the businessDays element. If Section 8.5/8.6 of the 1999/2003 ISDA Definitions are to apply but capped at a maximum number of business days then the maximum number should be specified in the maximumBusinessDays element. ISDA 2003 Term: Physical Settlement Period.',
    deliverableObligations VARCHAR(255) %DESCRIPTION 'This element contains all the ISDA terms relevant to defining the deliverable obligations.',
    escrow INT %DESCRIPTION 'If this element is specified and set to ''true'', indicates that physical settlement must take place through the use of an escrow agent. (For Canadian counterparties this is always ''Not Applicable''. ISDA 2003 Term: Escrow.',
    sixtyBusinessDaySettlementCap INT %DESCRIPTION 'If this element is specified and set to ''true'', for a transaction documented under the 2003 ISDA Credit Derivatives Definitions, has the effect of incorporating the language set forth below into the confirmation. The section references are to the 2003 ISDA Credit Derivatives Definitions. Notwithstanding Section 1.7 or any provisions of Sections 9.9 or 9.10 to the contrary, but without prejudice to Section 9.3 and (where applicable) Sections 9.4, 9.5 and 9.6, if the Termination Date has not occurred on or prior to the date that is 60 Business Days following the Physical Settlement Date, such 60th Business Day shall be deemed to be the Termination Date with respect to this Transaction except in relation to any portion of the Transaction (an ''Affected Portion'') in respect of which: (1) a valid notice of Buy-in Price has been delivered that is effective fewer than three Business Days prior to such 60th Business Day, in which case the Termination Date for that Affected Portion shall be the third Business Day following the date on which such notice is effective; or (2) Buyer has purchased but not Delivered Deliverable Obligations validly specified by Seller pursuant to Section 9.10(b), in which case the Termination Date for that Affected Portion shall be the tenth Business Day following the date on which Seller validly specified such Deliverable Obligations to Buyer.'
);

CREATE TABLE cdm_observable_event.ShareExtraordinaryEventEnum (
    ShareExtraordinaryEventEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.LegalAgreement_relatedAgreements (
    LegalAgreement_id INT NOT NULL,
    LegalAgreement_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreement_identifier (
    LegalAgreement_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreement_contractualParty (
    LegalAgreement_id INT NOT NULL,
    ReferenceWithMetaParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreement_otherParty (
    LegalAgreement_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreement_attachment (
    LegalAgreement_id INT NOT NULL,
    Resource_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.LegalAgreement (
    LegalAgreement_id INT UNIQUE NOT NULL,
    agreementTerms VARCHAR(255) %DESCRIPTION 'Specification of the content of the legal agreement.',
    relatedAgreements INT NOT NULL %DESCRIPTION 'Specifies the agreement(s) that govern the agreement, either as a reference to such agreements when specified as part of the CDM, or through identification of some of the key terms of those agreements, such as the type of agreement, the publisher, the vintage, the agreement identifier and the agreement date.',
    umbrellaAgreement VARCHAR(255) %DESCRIPTION 'The determination of whether Umbrella Agreement terms are applicable (True) or Not Applicable (False).',
    agreementDate VARCHAR(255) %DESCRIPTION 'The date on which the legal agreement has been agreed between the parties. This corresponds to the Date of Deed in an English Law document.',
    effectiveDate VARCHAR(255) %DESCRIPTION 'The date on which, or as of which, the agreement is effective, if different from the agreement date. It is expected that it will most often correspond to the agreement date, although there could be situations where the parties will explicitly agree on a distinct effective date.',
    identifier INT NOT NULL %DESCRIPTION 'The legal agreement identifier. Several identifiers can be specified.',
    legalAgreementIdentification VARCHAR(255) %DESCRIPTION 'The type of legal agreement, identified via a set of composable attributes: agreementName, publisher, governing law and version, e.g. ISDA 2013 Standard Credit Support Annex English Law.',
    contractualParty INT NOT NULL %DESCRIPTION 'The two contractual parties to the legal agreement, which reference information is positioned as part of the partyInformation attribute.',
    otherParty INT NOT NULL %DESCRIPTION 'The role(s) that other party(ies) may have in relation to the legal agreement, further to the contractual parties.',
    attachment INT NOT NULL %DESCRIPTION 'A human readable document, for example a confirmation.'
);

CREATE TABLE cdm_regulation.SwpOut (
    SwpOut_id INT UNIQUE NOT NULL,
    sngl VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_asset.FloatingRate (
    FloatingRate_id INT UNIQUE NOT NULL,
    floatingRateMultiplierSchedule VARCHAR(255) %DESCRIPTION 'A rate multiplier or multiplier schedule to apply to the floating rate. A multiplier schedule is expressed as explicit multipliers and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in the calculationPeriodDatesAdjustments. The multiplier can be a positive or negative decimal. This element should only be included if the multiplier is not equal to 1 (one) for the term of the stream.',
    rateTreatment VARCHAR(255) %DESCRIPTION 'The specification of any rate conversion which needs to be applied to the observed rate before being used in any calculations. The two common conversions are for securities quoted on a bank discount basis which will need to be converted to either a Money Market Yield or Bond Equivalent Yield. See the Annex to the 2000 ISDA Definitions, Section 7.3. Certain General Definitions Relating to Floating Rate Options, paragraphs (g) and (h) for definitions of these terms.',
    calculationParameters VARCHAR(255) %DESCRIPTION 'Support for modular calculated rates, such such as lockout compound calculations.',
    fallbackRate VARCHAR(255) %DESCRIPTION 'Definition of any fallback rate that may be applicable.',
    rateOption VARCHAR(255),
    spreadSchedule VARCHAR(255) %DESCRIPTION 'The ISDA Spread or a Spread schedule expressed as explicit spreads and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    capRateSchedule VARCHAR(255) %DESCRIPTION 'The cap rate or cap rate schedule, if any, which applies to the floating rate. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain level. A cap rate schedule is expressed as explicit cap rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRateSchedule VARCHAR(255) %DESCRIPTION 'The floor rate or floor rate schedule, if any, which applies to the floating rate. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. A floor rate schedule is expressed as explicit floor rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_common_schedule_metafields.ReferenceWithMetaCalculationPeriodDates (
    ReferenceWithMetaCalculationPeriodDates_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.DeliveryAmountElectionEnum (
    DeliveryAmountElectionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.InterestRateCurve (
    InterestRateCurve_id INT UNIQUE NOT NULL,
    floatingRateIndex VARCHAR(255) NOT NULL,
    tenor VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.TaxonomySourceEnum (
    TaxonomySourceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.ReferenceBank (
    ReferenceBank_id INT UNIQUE NOT NULL,
    referenceBankId VARCHAR(255) NOT NULL %DESCRIPTION 'An institution (party) identifier, e.g. a bank identifier code (BIC). FpML specifies a referenceBankIdScheme.',
    referenceBankName VARCHAR(255) %DESCRIPTION 'The name of the institution (party). A free format string. FpML does not define usage rules for the element.'
);

CREATE TABLE cdm_event_common.TradeIdentifier_assignedIdentifier (
    TradeIdentifier_id INT NOT NULL,
    AssignedIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.TradeIdentifier (
    TradeIdentifier_id INT UNIQUE NOT NULL,
    identifierType VARCHAR(255) %DESCRIPTION 'The enumerated classification of the identifier. Optional as a trade identifier may be party-specific, in which case it may not correspond to any established classification.',
    issuerReference VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified by reference to a party specified as part of the transaction.',
    issuer VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified explicitly alongside the identifier value (instead of being specified by reference to a party).',
    assignedIdentifier INT NOT NULL %DESCRIPTION 'The identifier value. This level of indirection between the issuer and the identifier and its version provides the ability to associate multiple identifiers to one issuer, consistently with the FpML PartyTradeIdentifier.'
);

CREATE TABLE cdm_observable_asset.SettlementRateOptionEnum (
    SettlementRateOptionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.SecurityValuationModel (
    SecurityValuationModel_id INT UNIQUE NOT NULL,
    bondValuationModel VARCHAR(255) %DESCRIPTION 'The valuation model when the security is a bond.',
    unitContractValuationModel VARCHAR(255) %DESCRIPTION 'The valuation model when the security is a unit contract like equity.'
);

CREATE TABLE cdm_event_workflow.CreditLimitUtilisation (
    CreditLimitUtilisation_id INT UNIQUE NOT NULL,
    executed VARCHAR(255) %DESCRIPTION 'Credit limit utilisation attributable to executed trades.',
    pending VARCHAR(255) %DESCRIPTION 'Credit limit utilisation attributable to pending unexecuted orders.'
);

CREATE TABLE cdm_base_math.AveragingWeightingMethodEnum (
    AveragingWeightingMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.NumberBound (
    NumberBound_id INT UNIQUE NOT NULL,
    number FLOAT NOT NULL %DESCRIPTION 'The number to be used as the bound, e.g. 5.',
    inclusive INT NOT NULL %DESCRIPTION 'Whether the number bound is inclusive, e.g. for a lower bound, false would indicate greater than, whereas true would indicate greater than or equal to.'
);

CREATE TABLE cdm_observable_event.CreditEvents (
    CreditEvents_id INT UNIQUE NOT NULL,
    bankruptcy INT %DESCRIPTION 'A credit event. The reference entity has been dissolved or has become insolvent. It also covers events that may be a precursor to insolvency such as instigation of bankruptcy or insolvency proceedings. Sovereign trades are not subject to Bankruptcy as ''technically'' a Sovereign cannot become bankrupt. ISDA 2003 Term: Bankruptcy.',
    failureToPay VARCHAR(255) %DESCRIPTION 'A credit event. This credit event triggers, after the expiration of any applicable grace period, if the reference entity fails to make due payments in an aggregate amount of not less than the payment requirement on one or more obligations (e.g. a missed coupon payment). ISDA 2003 Term: Failure to Pay.',
    failureToPayPrincipal INT %DESCRIPTION 'A credit event. Corresponds to the failure by the Reference Entity to pay an expected principal amount or the payment of an actual principal amount that is less than the expected principal amount. ISDA 2003 Term: Failure to Pay Principal.',
    failureToPayInterest INT %DESCRIPTION 'A credit event. Corresponds to the failure by the Reference Entity to pay an expected interest amount or the payment of an actual interest amount that is less than the expected interest amount. ISDA 2003 Term: Failure to Pay Interest.',
    obligationDefault INT %DESCRIPTION 'A credit event. One or more of the obligations have become capable of being declared due and payable before they would otherwise have been due and payable as a result of, or on the basis of, the occurrence of a default, event of default or other similar condition or event other than failure to pay. ISDA 2003 Term: Obligation Default.',
    obligationAcceleration INT %DESCRIPTION 'A credit event. One or more of the obligations have been declared due and payable before they would otherwise have been due and payable as a result of, or on the basis of, the occurrence of a default, event of default or other similar condition or event other than failure to pay (preferred by the market over Obligation Default, because more definitive and encompasses the definition of Obligation Default - this is more favorable to the Seller). Subject to the default requirement amount. ISDA 2003 Term: Obligation Acceleration.',
    repudiationMoratorium INT %DESCRIPTION 'A credit event. The reference entity, or a governmental authority, either refuses to recognise or challenges the validity of one or more obligations of the reference entity, or imposes a moratorium thereby postponing payments on one or more of the obligations of the reference entity. Subject to the default requirement amount. ISDA 2003 Term: Repudiation/Moratorium.',
    restructuring VARCHAR(255) %DESCRIPTION 'A credit event. A restructuring is an event that materially impacts the reference entity''s obligations, such as an interest rate reduction, principal reduction, deferral of interest or principal, change in priority ranking, or change in currency or composition of payment. ISDA 2003 Term: Restructuring.',
    governmentalIntervention INT %DESCRIPTION 'A credit event. A governmental intervention is an event resulting from an action by a governmental authority that materially impacts the reference entity''s obligations, such as an interest rate reduction, principal reduction, deferral of interest or principal, change in priority ranking, or change in currency or composition of payment. ISDA 2014 Term: Governmental Intervention.',
    distressedRatingsDowngrade INT %DESCRIPTION 'A credit event. Results from the fact that the rating of the reference obligation is down-graded to a distressed rating level. From a usage standpoint, this credit event is typically not applicable in case of RMBS trades.',
    maturityExtension INT %DESCRIPTION 'A credit event. Results from the fact that the underlier fails to make principal payments as expected.',
    writedown INT %DESCRIPTION 'A credit event. Results from the fact that the underlier writes down its outstanding principal amount.',
    impliedWritedown INT %DESCRIPTION 'A credit event. Results from the fact that losses occur to the underlying instruments that do not result in reductions of the outstanding principal of the reference obligation.',
    defaultRequirement VARCHAR(255) %DESCRIPTION 'In relation to certain credit events, serves as a threshold for Obligation Acceleration, Obligation Default, Repudiation/Moratorium and Restructuring. Market standard is USD 10,000,000 (JPY 1,000,000,000 for all Japanese Yen trades). This is applied on an aggregate or total basis across all Obligations of the Reference Entity. Used to prevent technical/operational errors from triggering credit events. ISDA 2003 Term: Default Requirement.',
    creditEventNotice VARCHAR(255) %DESCRIPTION 'A specified condition to settlement. An irrevocable written or verbal notice that describes a credit event that has occurred. The notice is sent from the notifying party (either the buyer or the seller) to the counterparty. It provides information relevant to determining that a credit event has occurred. This is typically accompanied by Publicly Available Information. ISDA 2003 Term: Credit Event Notice.'
);

CREATE TABLE cdm_product_common_schedule.CalculationPeriodDates (
    CalculationPeriodDates_id INT UNIQUE NOT NULL,
    effectiveDate VARCHAR(255) %DESCRIPTION 'The first day of the terms of the trade. This day may be subject to adjustment in accordance with a business day convention.',
    terminationDate VARCHAR(255) %DESCRIPTION 'The last day of the terms of the trade. This date may be subject to adjustments in accordance with the business day convention. It can also be specified in relation to another scheduled date (e.g. the last payment date).',
    calculationPeriodDatesAdjustments VARCHAR(255) %DESCRIPTION 'The specification of the business day convention and financial business centers used for adjusting any calculation period date if it would otherwise fall on a day that is not a business day in the specified business center.',
    firstPeriodStartDate VARCHAR(255) %DESCRIPTION 'The start date of the calculation period. FpML specifies that for interest rate swaps this date must only be specified if it is not equal to the effective date. It is always specified in the case of equity swaps and credit default swaps with periodic payments. This date may be subject to adjustment in accordance with a business day convention.',
    firstRegularPeriodStartDate VARCHAR(255) %DESCRIPTION 'The start date of the regular part of the calculation period schedule. It must only be specified if there is an initial stub calculation period. This day may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments.',
    firstCompoundingPeriodEndDate VARCHAR(255) %DESCRIPTION 'The end date of the initial compounding period when compounding is applicable. It must only be specified when the compoundingMethod element is present and not equal to a value of None. This date may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments.',
    lastRegularPeriodEndDate VARCHAR(255) %DESCRIPTION 'The end date of the regular part of the calculation period schedule. It must only be specified if there is a final stub calculation period. This day may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments.',
    stubPeriodType VARCHAR(255) %DESCRIPTION 'Method to allocate any irregular period remaining after regular periods have been allocated between the effective and termination date.',
    calculationPeriodFrequency VARCHAR(255) %DESCRIPTION 'The frequency at which calculation period end dates occur with the regular part of the calculation period schedule and their roll date convention.'
);

CREATE TABLE cdm_product_common_settlement.CashSettlementMethodEnum (
    CashSettlementMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.US_CFTC_PR_EligibleCollateralEnum (
    US_CFTC_PR_EligibleCollateralEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset_metafields.ReferenceWithMetaFixedRateSpecification (
    ReferenceWithMetaFixedRateSpecification_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_event_common.ExerciseEvent (
    ExerciseEvent_id INT UNIQUE NOT NULL,
    adjustedExerciseDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the option exercise takes place. This date should already be adjusted for any applicable business day convention.',
    adjustedRelevantSwapEffectiveDate VARCHAR(255) NOT NULL %DESCRIPTION 'The effective date of the underlying swap associated with a given exercise date. This date should already be adjusted for any applicable business day convention.',
    adjustedCashSettlementValuationDate VARCHAR(255) %DESCRIPTION 'The date by which the cash settlement amount must be agreed. This date should already be adjusted for any applicable business day convention.',
    adjustedCashSettlementPaymentDate VARCHAR(255) %DESCRIPTION 'The date on which the cash settlement amount is paid. This date should already be adjusted for any applicable business day convention.',
    adjustedExerciseFeePaymentDate VARCHAR(255) %DESCRIPTION 'The date on which the exercise fee amount is paid. This date should already be adjusted for any applicable business day convention.'
);

CREATE TABLE cdm_product_template_metafields.ReferenceWithMetaPerformancePayout (
    ReferenceWithMetaPerformancePayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_template.FxFeature (
    FxFeature_id INT UNIQUE NOT NULL,
    referenceCurrency VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the reference currency of the trade.',
    composite VARCHAR(255) %DESCRIPTION 'If ''Composite'' is specified as the Settlement Type in the relevant Transaction Supplement, an amount in the Settlement Currency, determined by the Calculation Agent as being equal to the number of Options exercised or deemed exercised, multiplied by: (Settlement Price – Strike Price) / (Strike Price – Settlement Price) x Multiplier provided that if the above is equal to a negative amount the Option Cash Settlement Amount shall be deemed to be zero.',
    quanto VARCHAR(255) %DESCRIPTION 'If ''Quanto'' is specified as the Settlement Type in the relevant Transaction Supplement, an amount, as determined by the Calculation Agent in accordance with the Section 8.2 of the Equity Definitions.',
    crossCurrency VARCHAR(255) %DESCRIPTION 'If ''Cross-Currency'' is specified as the Settlement Type in the relevant Transaction Supplement, an amount in the Settlement Currency, determined by the Calculation Agent as being equal to the number of Options exercised or deemed exercised, multiplied by: (Settlement Price – Strike Price) / (Strike Price – Settlement Price) x Multiplier x one unit of the Reference Currency converted into an amount in the Settlement Currency using the rate of exchange of the Settlement Currency as quoted on the Reference Price Source on the Valuation Date, provided that if the above is equal to a negative amount the Option Cash Settlement Amount shall be deemed to be zero.'
);

CREATE TABLE cdm_legaldocumentation_master.FieldWithMetaMasterAgreementTypeEnum (
    FieldWithMetaMasterAgreementTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.EligibilityQuery (
    EligibilityQuery_id INT UNIQUE NOT NULL,
    maturity FLOAT NOT NULL %DESCRIPTION 'Maturity in years',
    collateralAssetType VARCHAR(255) NOT NULL %DESCRIPTION 'The asset product type.',
    assetCountryOfOrigin VARCHAR(255) NOT NULL %DESCRIPTION 'The asset country of origin.',
    denominatedCurrency VARCHAR(255) NOT NULL %DESCRIPTION 'The underlying asset denominated currency.',
    agencyRating VARCHAR(255) NOT NULL %DESCRIPTION 'The agency rating based on default risk and creditors claim in event of default associated with specific instrument.',
    issuerType VARCHAR(255) NOT NULL %DESCRIPTION 'Represents a filter based on the type of entity issuing the asset.',
    issuerName VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the issuing entity name or LEI.'
);

CREATE TABLE cdm_legaldocumentation_common.UmbrellaAgreementEntity_entityId (
    UmbrellaAgreementEntity_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_common.UmbrellaAgreementEntity (
    UmbrellaAgreementEntity_id INT UNIQUE NOT NULL,
    terms VARCHAR(255) %DESCRIPTION 'The terms that might be associated with each party to the umbrella agreement.',
    entityId INT NOT NULL %DESCRIPTION 'A legal entity identifier (e.g. RED entity code).',
    name VARCHAR(255) %DESCRIPTION 'The legal entity name.'
);

CREATE TABLE cdm_event_workflow.WorkflowState_partyCustomisedWorkflow (
    WorkflowState_id INT NOT NULL,
    PartyCustomisedWorkflow_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.WorkflowState (
    WorkflowState_id INT UNIQUE NOT NULL,
    workflowStatus VARCHAR(255) NOT NULL %DESCRIPTION 'The workflow status indicator, e.g. Accepted, Rejected, ...',
    comment VARCHAR(255) %DESCRIPTION 'A comment field to be associated with the workflow, e.g. to specify why a transaction event was rejected by a party.',
    partyCustomisedWorkflow INT NOT NULL %DESCRIPTION 'Workflow data that is specific to certain market participants and is expressed as part of the CDM in a very generic manner, which can be party-specific. The initial use cases have been derived from the CME clearing and the DTCC TIW submissions.',
    warehouseIdentity VARCHAR(255) %DESCRIPTION 'The identity of the warehouse, if any, that is executing that workflow step.'
);

CREATE TABLE cdm_product_asset.DividendEntitlementEnum (
    DividendEntitlementEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.AdjustableOrAdjustedDate (
    AdjustableOrAdjustedDate_id INT UNIQUE NOT NULL,
    unadjustedDate VARCHAR(255) %DESCRIPTION 'A date subject to adjustment.',
    dateAdjustments VARCHAR(255) %DESCRIPTION 'The business day convention and financial business centers used for adjusting the date if it would otherwise fall on a day that is not a business date in the specified business centers.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).'
);

CREATE TABLE cdm_legaldocumentation_common.ContractualMatrix (
    ContractualMatrix_id INT UNIQUE NOT NULL,
    matrixType VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the form of applicable matrix.',
    matrixTerm VARCHAR(255) %DESCRIPTION 'Defines any applicable key into the relevant matrix. For example, the Transaction Type would be the single term required for the Credit Derivatives Physical Settlement Matrix. This element should be omitted in the case of the 2000 ISDA Definitions Settlement Matrix for Early Termination and Swaptions.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.OffsetCalculation (
    OffsetCalculation_id INT UNIQUE NOT NULL,
    offsetDays INT %DESCRIPTION 'The number of business days offset.'
);

CREATE TABLE cdm_product_common_schedule.WeightedAveragingObservation (
    WeightedAveragingObservation_id INT UNIQUE NOT NULL,
    dateTime VARCHAR(255) %DESCRIPTION 'Observation date time, which should be used when literal observation dates are required. The CDM specifies that the zoned date time is to be expressed in accordance with ISO 8601, either as UTC as an offset to UTC.',
    observationNumber INT %DESCRIPTION 'Observation number, which should be unique, within a series generated by a date schedule.',
    weight FLOAT NOT NULL %DESCRIPTION 'Observation weight, which is used as a multiplier for the observation value.'
);

CREATE TABLE cdm_base_datetime.RelativeDateOffset (
    RelativeDateOffset_id INT UNIQUE NOT NULL,
    businessDayConvention VARCHAR(255) NOT NULL %DESCRIPTION 'The convention for adjusting a date if it would otherwise fall on a day that is not a business day, as specified by an ISDA convention (e.g. Following, Precedent).',
    businessCenters VARCHAR(255),
    businessCentersReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to a set of financial business centers defined elsewhere in the document. This set of business centers is used to determine whether a particular day is a business day or not.',
    dateRelativeTo VARCHAR(255) %DESCRIPTION 'Specifies the anchor as an href attribute. The href attribute value is a pointer style reference to the element or component elsewhere in the document where the anchor date is defined.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).',
    dayType VARCHAR(255) %DESCRIPTION 'In the case of an offset specified as a number of days, this element defines whether consideration is given as to whether a day is a good business day or not. If a day type of business days is specified then non-business days are ignored when calculating the offset. The financial business centers to use for determination of business days are implied by the context in which this element is used. This element must only be included when the offset is specified as a number of days. If the offset is zero days then the dayType element should not be included.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2 or 3 etc. A negative value can be used when specifying an offset relative to another date, e.g. -2 days.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month or year of the stream. If the periodMultiplier value is 0 (zero) then period must contain the value D (day).'
);

CREATE TABLE cdm_base_staticdata_party.ContactInformation_telephone (
    ContactInformation_id INT NOT NULL,
    TelephoneNumber_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.ContactInformation_address (
    ContactInformation_id INT NOT NULL,
    Address_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.ContactInformation_email (
    ContactInformation_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.ContactInformation_webPage (
    ContactInformation_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.ContactInformation (
    ContactInformation_id INT UNIQUE NOT NULL,
    telephone INT NOT NULL %DESCRIPTION 'The telephone number.',
    address INT NOT NULL %DESCRIPTION 'The street/postal address.',
    email INT NOT NULL %DESCRIPTION 'The email address.',
    webPage INT NOT NULL %DESCRIPTION 'The web page. This attribute is not specified as part of the FpML ContactInformation complex type.'
);

CREATE TABLE cdm_product_template.OptionStyle (
    OptionStyle_id INT UNIQUE NOT NULL,
    americanExercise VARCHAR(255),
    bermudaExercise VARCHAR(255),
    europeanExercise VARCHAR(255)
);

CREATE TABLE cdm_observable_event_metafields.ReferenceWithMetaCreditEvents (
    ReferenceWithMetaCreditEvents_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.DateRelativeToCalculationPeriodDates_calculationPeriodDatesReference (
    DateRelativeToCalculationPeriodDates_id INT NOT NULL,
    ReferenceWithMetaCalculationPeriodDates_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.DateRelativeToCalculationPeriodDates (
    DateRelativeToCalculationPeriodDates_id INT UNIQUE NOT NULL,
    calculationPeriodDatesReference INT NOT NULL %DESCRIPTION 'A set of href pointers to calculation period dates defined somewhere else in the document.'
);

CREATE TABLE cdm_regulation.FinInstrmGnlAttrbts (
    FinInstrmGnlAttrbts_id INT UNIQUE NOT NULL,
    fullNm VARCHAR(255) NOT NULL,
    clssfctnTp VARCHAR(255) NOT NULL,
    ntnlCcy VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.DebtEconomics (
    DebtEconomics_id INT UNIQUE NOT NULL,
    debtSeniority VARCHAR(255) %DESCRIPTION 'Specifies the order of repayment in the event of a sale or bankruptcy of the issuer or a related party (eg guarantor).',
    debtInterest VARCHAR(255) %DESCRIPTION 'Specifies the general rule for periodic interest rate payment.',
    debtPrincipal VARCHAR(255) %DESCRIPTION 'Specifies the general rule for repayment of principal.'
);

CREATE TABLE cdm_legaldocumentation_common.ResourceLength (
    ResourceLength_id INT UNIQUE NOT NULL,
    lengthUnit VARCHAR(255) NOT NULL %DESCRIPTION 'The length unit of the resource. For example, pages (pdf, text documents) or time (audio, video files).',
    lengthValue FLOAT NOT NULL %DESCRIPTION 'The length value of the resource.'
);

CREATE TABLE cdm_observable_event.Restructuring (
    Restructuring_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the restructuring provision is applicable.',
    restructuringType VARCHAR(255) %DESCRIPTION 'Specifies the type of restructuring that is applicable.',
    multipleHolderObligation INT %DESCRIPTION 'In relation to a restructuring credit event, unless multiple holder obligation is not specified restructurings are limited to multiple holder obligations. A multiple holder obligation means an obligation that is held by more than three holders that are not affiliates of each other and where at least two thirds of the holders must agree to the event that constitutes the restructuring credit event. ISDA 2003 Term: Multiple Holder Obligation.',
    multipleCreditEventNotices INT %DESCRIPTION 'Presence of this element and value set to ''true'' indicates that Section 3.9 of the 2003 Credit Derivatives Definitions shall apply. Absence of this element indicates that Section 3.9 shall not apply. NOTE: Not allowed under ISDA Credit 1999.'
);

CREATE TABLE cdm_base_datetime_metafields.ReferenceWithMetaBusinessCenters (
    ReferenceWithMetaBusinessCenters_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_collateral.ReturnAmount (
    ReturnAmount_id INT UNIQUE NOT NULL,
    includesDefaultLanguage INT %DESCRIPTION 'Default language is included when True, and excluded when False.',
    customElection VARCHAR(255) %DESCRIPTION 'Custom election that might be specified by the parties to the agreement.'
);

CREATE TABLE cdm_base_staticdata_asset_rates.FloatingRateIndexEnum (
    FloatingRateIndexEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.InterestShortFall (
    InterestShortFall_id INT UNIQUE NOT NULL,
    interestShortfallCap VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the nature of the interest Shortfall cap (i.e. Fixed Cap or Variable Cap) in the case where it is applicable. ISDA 2003 Term: Interest Shortfall Cap.',
    compounding INT NOT NULL,
    rateSource VARCHAR(255) %DESCRIPTION 'The rate source in the case of a variable cap.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservations_observationDates (
    CalculatedRateObservations_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservations_weights (
    CalculatedRateObservations_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservations_observedRates (
    CalculatedRateObservations_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservations_processedRates (
    CalculatedRateObservations_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservations (
    CalculatedRateObservations_id INT UNIQUE NOT NULL,
    observationDates INT NOT NULL %DESCRIPTION 'The observation date upon which the rate is observed.',
    weights INT NOT NULL %DESCRIPTION 'The corresponding weight for each date.',
    observedRates INT NOT NULL %DESCRIPTION 'The value observed for that date',
    processedRates INT NOT NULL %DESCRIPTION 'The value after any processing, such as application of caps or floors.'
);

CREATE TABLE cdm_observable_asset.BondChoiceModel (
    BondChoiceModel_id INT UNIQUE NOT NULL,
    bond VARCHAR(255),
    convertibleBond VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.ValuationDates (
    ValuationDates_id INT UNIQUE NOT NULL,
    valuationDatesInitial VARCHAR(255) %DESCRIPTION 'Specifies the initial valuation dates of the underlier.',
    valuationDatesInterim VARCHAR(255) %DESCRIPTION 'Specifies the interim valuation dates of the underlier.',
    valuationDatesFinal VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the final valuation dates of the underlier.'
);

CREATE TABLE cdm_product_common_schedule.StubCalculationPeriodAmount (
    StubCalculationPeriodAmount_id INT UNIQUE NOT NULL,
    calculationPeriodDatesReference VARCHAR(255) NOT NULL %DESCRIPTION 'A pointer style reference to the associated calculation period dates component defined elsewhere in the document.',
    initialStub VARCHAR(255) %DESCRIPTION 'Specifies how the initial stub amount is calculated. A single floating rate tenor different to that used for the regular part of the calculation periods schedule may be specified, or two floating tenors may be specified. If two floating rate tenors are specified then Linear Interpolation (in accordance with the 2000 ISDA Definitions, Section 8.3. Interpolation) is assumed to apply. Alternatively, an actual known stub rate or stub amount may be specified.',
    finalStub VARCHAR(255) %DESCRIPTION 'Specifies how the final stub amount is calculated. A single floating rate tenor different to that used for the regular part of the calculation periods schedule may be specified, or two floating tenors may be specified. If two floating rate tenors are specified then Linear Interpolation (in accordance with the 2000 ISDA Definitions, Section 8.3. Interpolation) is assumed to apply. Alternatively, an actual known stub rate or stub amount may be specified.'
);

CREATE TABLE cdm_base_staticdata_asset_common.DebtType_debtEconomics (
    DebtType_id INT NOT NULL,
    DebtEconomics_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.DebtType (
    DebtType_id INT UNIQUE NOT NULL,
    debtClass VARCHAR(255) %DESCRIPTION 'Specifies the characteristics of a debt instrument.',
    debtEconomics INT NOT NULL %DESCRIPTION 'Specifies selected financial terms of a debt instrument.'
);

CREATE TABLE cdm_product_common_schedule.RateSchedule (
    RateSchedule_id INT UNIQUE NOT NULL,
    price VARCHAR(255) NOT NULL %DESCRIPTION 'The initial rate. An initial rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_asset.VolatilityReturnTerms (
    VolatilityReturnTerms_id INT UNIQUE NOT NULL,
    volatilityStrikePrice VARCHAR(255) NOT NULL %DESCRIPTION 'Volatility Strike Price in accordance with the ISDA 2011 Equity Derivatives Definitions.',
    volatilityCapFloor VARCHAR(255) %DESCRIPTION 'Contains volatility-based barriers',
    exchangeTradedContractNearest VARCHAR(255) %DESCRIPTION 'Specification of the exchange traded contract nearest.',
    valuationTerms VARCHAR(255) %DESCRIPTION 'Contains all non-date valuation information.',
    annualizationFactor INT %DESCRIPTION 'This specifies the numerator of an annualization factor. Frequently this number is equal to the number of observations of prices in a year e.g. 252.',
    dividendApplicability VARCHAR(255) %DESCRIPTION 'The parameters which define whether dividends are applicable',
    equityUnderlierProvisions VARCHAR(255) %DESCRIPTION 'Contains Equity underlier provisions regarding jurisdiction and fallbacks.',
    sharePriceDividendAdjustment INT %DESCRIPTION 'Indicates whether the price of shares is adjusted for dividends or not.',
    expectedN INT %DESCRIPTION 'Expected number of trading days.',
    initialLevel FLOAT %DESCRIPTION 'Contract will strike off this initial level. Providing just the initialLevel without initialLevelSource, infers that this is AgreedInitialPrice - a specified Initial Index Level.',
    initialLevelSource VARCHAR(255) %DESCRIPTION 'In this context, this is AgreedInitialPrice - a specified Initial Index Level.',
    meanAdjustment INT %DESCRIPTION 'Specifies whether Mean Adjustment is applicable or not in the calculation of the Realized Volatility, Variance or Correlation',
    performance VARCHAR(255) %DESCRIPTION 'Performance calculation, in accordance with Part 1 Section 12 of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap, Para 75. ''Equity Performance''. Cumulative performance is used as a notional multiplier factor on both legs of an Equity Swap.'
);

CREATE TABLE cdm_base_staticdata_asset_common.SecurityTypeEnum (
    SecurityTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.ValuationTypeEnum (
    ValuationTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_identifier.IdentifiedList_componentId (
    IdentifiedList_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_identifier.IdentifiedList (
    IdentifiedList_id INT UNIQUE NOT NULL,
    listId VARCHAR(255) NOT NULL %DESCRIPTION 'The identifier for the list. In the case of a package transaction, this would be the package identifier. This attribute is mandatory to allow the list itself to be identified.',
    componentId INT NOT NULL %DESCRIPTION 'Identifiers for each component of the list. Since the data type is used to link multiple identified objects together, at least 2 components are required in the list. Creating an identified list with only 1 identified component has been deemed unnecessary, because it would just create a redundant identifier.',
    price VARCHAR(255) %DESCRIPTION 'The price of the package.'
);

CREATE TABLE cdm_base_math_metafields.ReferenceWithMetaNonNegativeQuantitySchedule (
    ReferenceWithMetaNonNegativeQuantitySchedule_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_math.CompareOp (
    CompareOp VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.CashflowRepresentation_paymentCalculationPeriod (
    CashflowRepresentation_id INT NOT NULL,
    PaymentCalculationPeriod_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.CashflowRepresentation (
    CashflowRepresentation_id INT UNIQUE NOT NULL,
    cashflowsMatchParameters INT NOT NULL %DESCRIPTION 'A true/false flag to indicate whether the cashflows match the parametric definition of the stream, i.e. whether the cashflows could be regenerated from the parameters without loss of information.',
    paymentCalculationPeriod INT NOT NULL %DESCRIPTION 'The adjusted payment date and associated calculation period parameters required to calculate the actual or projected payment amount. A list of payment calculation period elements may be ordered in the document by ascending adjusted payment date. An FpML document containing an unordered list of payment calculation periods is still regarded as a conformant document.'
);

CREATE TABLE cdm_base_math.CapacityUnitEnum (
    CapacityUnitEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_master.ExtraordinaryEvents_additionalBespokeTerms (
    ExtraordinaryEvents_id INT NOT NULL,
    Clause_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.ExtraordinaryEvents (
    ExtraordinaryEvents_id INT UNIQUE NOT NULL,
    additionalBespokeTerms INT NOT NULL %DESCRIPTION 'Where parties may optionnaly describe any extra bespoke agreements, in regards of the standardized Extraordinary Events.',
    mergerEvents VARCHAR(255) %DESCRIPTION 'Per the 2018 ISDA CDM Equity Confirmation for Security Equity Swap',
    tenderOfferEvents VARCHAR(255) %DESCRIPTION 'Per the 2002 ISDA Equity Derivatives Definitions: ',
    compositionOfCombinedConsideration INT %DESCRIPTION 'Per the 2002 ISDA Equity Derivatives Definitions: ',
    indexAdjustmentEvents VARCHAR(255) %DESCRIPTION 'Per the 2002 ISDA Equity Derivatives Definitions: Adjustments to Indices ',
    additionalDisruptionEvents VARCHAR(255) %DESCRIPTION 'Per the 2002 ISDA Equity Derivatives Definitions | 2018 ISDA CDM Equity Confirmation for Security Equity Swaps',
    failureToDeliver INT %DESCRIPTION 'If true, failure to deliver is applicable.',
    representations VARCHAR(255),
    nationalizationOrInsolvency VARCHAR(255) %DESCRIPTION 'Per the 2002 ISDA Equity Derivatives Definitions | 2018 ISDA CDM Equity Confirmation for Security Equity Swap',
    delisting VARCHAR(255) %DESCRIPTION 'Per the 2002 ISDA Equity Derivatives Definitions | 2018 ISDA CDM Equity Confirmation for Security Equity Swap:'
);

CREATE TABLE cdm_product_asset.VarianceCapFloor (
    VarianceCapFloor_id INT UNIQUE NOT NULL,
    varianceCap INT NOT NULL %DESCRIPTION 'If present and true, then variance cap is applicable.',
    unadjustedVarianceCap FLOAT %DESCRIPTION 'For use when varianceCap is applicable. Contains the scaling factor of the Variance Cap that can differ on a trade-by-trade basis in the European market. For example, a Variance Cap of 2.5^2 x Variance Strike Price has an unadjustedVarianceCap of 2.5.',
    boundedVariance VARCHAR(255) %DESCRIPTION 'Conditions which bound variance. The contract specifies one or more boundary levels. These levels are expressed as prices for confirmation purposes underlier price must be equal to or higher than Lower Barrier is known as Up Conditional Swap underlier price must be equal to or lower than Upper Barrier is known as Down Conditional Swap underlier price must be equal to or higher than Lower Barrier and must be equal to or lower than Upper Barrier is known as Barrier Conditional Swap.'
);

CREATE TABLE cdm_product_asset.SpreadSchedule (
    SpreadSchedule_id INT UNIQUE NOT NULL,
    spreadScheduleType VARCHAR(255) %DESCRIPTION 'An element which purpose is to identify a long or short spread value.',
    price VARCHAR(255) %DESCRIPTION 'The initial rate. An initial rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_base_staticdata_asset_common.TaxonomyClassification (
    TaxonomyClassification_id INT UNIQUE NOT NULL,
    className VARCHAR(255) %DESCRIPTION 'The name defined by the classification system for a specific attribute in the taxonomy',
    value VARCHAR(255) NOT NULL %DESCRIPTION 'The value set by the taxonomy that is specific to the className attribute.',
    description VARCHAR(255) %DESCRIPTION 'A description of the class.',
    ordinal INT %DESCRIPTION 'In the case of multi-layered hierarchical classification systems such as commodity classification, the layer the value and className occupy in the classification hierarchy, where 1 represents the top-layer.'
);

CREATE TABLE cdm_product_asset.IndexAnnexSourceEnum (
    IndexAnnexSourceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.SettlementTerms_cashSettlementTerms (
    SettlementTerms_id INT NOT NULL,
    CashSettlementTerms_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.SettlementTerms (
    SettlementTerms_id INT UNIQUE NOT NULL,
    cashSettlementTerms INT NOT NULL %DESCRIPTION 'Specifies the parameters associated with the cash settlement procedure.',
    physicalSettlementTerms VARCHAR(255) %DESCRIPTION 'Specifies the physical settlement terms which apply to the transaction.',
    settlementType VARCHAR(255) %DESCRIPTION 'Whether the settlement will be cash, physical, by election, ...',
    transferSettlementType VARCHAR(255) %DESCRIPTION 'The qualification as to how the transfer will settle, e.g. a DvP settlement.',
    settlementCurrency VARCHAR(255) %DESCRIPTION 'The settlement currency is to be specified when the Settlement Amount cannot be known in advance. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    settlementDate VARCHAR(255) %DESCRIPTION 'The date on which the settlement amount will be paid, subject to adjustment in accordance with any applicable business day convention. This component would not be present for a mandatory early termination provision where the cash settlement payment date is the mandatory early termination date.',
    settlementCentre VARCHAR(255) %DESCRIPTION 'Optional settlement centre as an enumerated list: Euroclear, Clearstream.',
    settlementProvision VARCHAR(255) %DESCRIPTION 'Optionally defines the parameters that regulate a settlement.',
    standardSettlementStyle VARCHAR(255) %DESCRIPTION 'Settlement Style.'
);

CREATE TABLE cdm_observable_asset_metafields.ReferenceWithMetaMoney (
    ReferenceWithMetaMoney_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_event.RestructuringEnum (
    RestructuringEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.OptionFeature_fxFeature (
    OptionFeature_id INT NOT NULL,
    FxFeature_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.OptionFeature (
    OptionFeature_id INT UNIQUE NOT NULL,
    fxFeature INT NOT NULL %DESCRIPTION 'Describes a quanto or composite FX feature.',
    strategyFeature VARCHAR(255) %DESCRIPTION 'Defines a simple strategy feature.',
    averagingFeature VARCHAR(255) %DESCRIPTION 'Defines an option feature in which an average market observation price is determined on valuation and compared to the strike to determine a settlement amount.',
    barrier VARCHAR(255) %DESCRIPTION 'Specifies a barrier feature.',
    knock VARCHAR(255) %DESCRIPTION 'Specifies a knock in or knock out feature.',
    passThrough VARCHAR(255) %DESCRIPTION 'Specifies the rules for pass-through payments from the underlier, such as dividends.'
);

CREATE TABLE cdm_base_staticdata_asset_common.AssetTypeEnum (
    AssetTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_workflow.WorkflowStep_approval (
    WorkflowStep_id INT NOT NULL,
    WorkflowStepApproval_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.WorkflowStep_timestamp (
    WorkflowStep_id INT NOT NULL,
    EventTimestamp_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.WorkflowStep_eventIdentifier (
    WorkflowStep_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.WorkflowStep_party (
    WorkflowStep_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.WorkflowStep_account (
    WorkflowStep_id INT NOT NULL,
    Account_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.WorkflowStep (
    WorkflowStep_id INT UNIQUE NOT NULL,
    businessEvent VARCHAR(255) %DESCRIPTION 'Life cycle event for the step. The businessEvent is optional when a proposedEvent or rejection are present.',
    counterpartyPositionBusinessEvent VARCHAR(255) %DESCRIPTION 'Documents the life cycle event for a position.',
    proposedEvent VARCHAR(255) %DESCRIPTION 'The proposed event for a workflow step. The proposedEvent is optional when the businessEvent or rejection are present',
    rejected INT %DESCRIPTION 'Flags this step as rejected.',
    approval INT NOT NULL %DESCRIPTION 'Optional party approvals for the current workflow step. A workflow step can have any number of parties associated to it, thus this object is represented as a list. All parties that are expected to provide approval should have an item in this list that references them.',
    previousWorkflowStep VARCHAR(255) %DESCRIPTION 'Optional previous workflow step that provides lineage to workflow steps that precedes it.',
    nextEvent VARCHAR(255) %DESCRIPTION 'The intended next event can be specified, even if the instructions are not known yet.',
    messageInformation VARCHAR(255) %DESCRIPTION 'Contains all information pertaining the FpML messaging header ',
    timestamp INT NOT NULL %DESCRIPTION 'The set of timestamp(s) associated with the event as a collection of [dateTime, qualifier].',
    eventIdentifier INT NOT NULL %DESCRIPTION 'The identifier(s) that uniquely identify a lifecycle event. The unbounded cardinality is meant to provide the ability to associate identifiers that are issued by distinct parties. As an example, each of the parties to the event may choose to associate their own identifiers to the event.',
    action VARCHAR(255) %DESCRIPTION 'Specifies whether the event is a new, a correction or a cancellation.',
    party INT NOT NULL %DESCRIPTION 'The specification of the event parties. This attribute is optional, as not applicable to certain events (e.g. most of the observations).',
    account INT NOT NULL %DESCRIPTION 'Optional account information that could be associated to the event.',
    lineage VARCHAR(255) %DESCRIPTION 'The lineage attribute provides a linkage among lifecycle events through the globalKey hash value. One example is when a given lifecycle event is being corrected or cancelled. In such case, each subsequent event will have lineage into the prior version of that event. The second broad use case is when an event has a dependency upon either another event (e.g. the regular payment associated with a fix/float swap will have a lineage into the reset event, which will in turn have a lineage into the observation event for the floating rate and the contract) or a contract (e.g. the exercise of an option has a lineage into that option).',
    creditLimitInformation VARCHAR(255),
    workflowState VARCHAR(255) %DESCRIPTION 'The event workflow information, i.e. the workflow status, the associated comment and the partyCustomisedWorkflow which purpose is to provide the ability to associate custom workflow information to the CDM.'
);

CREATE TABLE cdm_event_position.PositionStatusEnum (
    PositionStatusEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_schedule.PaymentDates (
    PaymentDates_id INT UNIQUE NOT NULL,
    paymentFrequency VARCHAR(255) %DESCRIPTION 'The frequency at which regular payment dates occur. If the payment frequency is equal to the frequency defined in the calculation period dates component then one calculation period contributes to each payment amount. If the payment frequency is less frequent than the frequency defined in the calculation period dates component then more than one calculation period will contribute to the payment amount. A payment frequency more frequent than the calculation period frequency or one that is not a multiple of the calculation period frequency is invalid. If the payment frequency is of value T (term), the period is defined by the effectiveDate and the terminationDate.',
    firstPaymentDate VARCHAR(255) %DESCRIPTION 'The first unadjusted payment date. This day may be subject to adjustment in accordance with any business day convention specified in paymentDatesAdjustments. This element must only be included if there is an initial stub. This date will normally correspond to an unadjusted calculation period start or end date. This is true even if early or delayed payment is specified to be applicable since the actual first payment date will be the specified number of days before or after the applicable adjusted calculation period start or end date with the resulting payment date then being adjusted in accordance with any business day convention specified in paymentDatesAdjustments.',
    lastRegularPaymentDate VARCHAR(255) %DESCRIPTION 'The last regular payment date when specified as a date, as in the FpML interest rate construct. FpML specifies that this date may be subject to adjustment in accordance with any business day convention specified in the paymentDatesAdjustments attribute.',
    paymentDateSchedule VARCHAR(255) %DESCRIPTION 'The payment dates when specified as relative to a set of dates specified somewhere else in the instance document/transaction, e.g. the valuation dates as typically the case for equity swaps, or when specified as a calculation period schedule.',
    payRelativeTo VARCHAR(255) %DESCRIPTION 'Specifies whether the payments occur relative to each adjusted calculation period start date or end date, each reset date, valuation date or the last pricing date. Calculation period start date means relative to the start of the first calculation period contributing to a given payment. Similarly, calculation period end date means the end of the last calculation period contributing to a given payment. The valuation date is applicable for Brazilian-CDI and equity swaps.',
    paymentDaysOffset VARCHAR(255) %DESCRIPTION 'If early payment or delayed payment is required, specifies the number of days offset that the payment occurs relative to what would otherwise be the unadjusted payment date. The offset can be specified in terms of either calendar or business days. Even in the case of a calendar days offset, the resulting payment date, adjusted for the specified calendar days offset, will still be adjusted in accordance with the specified payment dates adjustments. This element should only be included if early or delayed payment is applicable, i.e. if the periodMultiplier element value is not equal to zero. An early payment would be indicated by a negative periodMultiplier element value and a delayed payment (or payment lag) would be indicated by a positive periodMultiplier element value.',
    paymentDatesAdjustments VARCHAR(255) %DESCRIPTION 'The definition of the business day convention and financial business centers used for adjusting the payment date if it would otherwise fall on a day that is not a business day in the specified business center.'
);

CREATE TABLE cdm_observable_asset.FxRateObservable (
    FxRateObservable_id INT UNIQUE NOT NULL,
    quotedCurrencyPair VARCHAR(255) NOT NULL %DESCRIPTION 'Describes the composition of a rate that has been quoted or is to be quoted.',
    primaryFxSpotRateSource VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the primary source from which a rate should be observed.',
    secondaryFxSpotRateSource VARCHAR(255) %DESCRIPTION 'Specifies an alternative, or secondary, source from which a rate should be observed.'
);

CREATE TABLE cdm_product_asset.CreditDefaultPayout_protectionTerms (
    CreditDefaultPayout_id INT NOT NULL,
    ProtectionTerms_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.CreditDefaultPayout (
    CreditDefaultPayout_id INT UNIQUE NOT NULL,
    generalTerms VARCHAR(255) NOT NULL %DESCRIPTION 'The specification of the non-monetary terms for the Credit Derivative Transaction, including the buyer and seller and selected items from the ISDA 2014 Credit Definition article II, such as the reference obligation and related terms.',
    protectionTerms INT NOT NULL %DESCRIPTION 'Specifies the terms for calculating a payout to protect the buyer of the swap in the case of a qualified credit event. These terms include the applicable credit events, the reference obligation, and in the case of a CDS on mortgage-backed securities, the floatingAmountEvents.',
    transactedPrice VARCHAR(255) %DESCRIPTION 'The qualification of the price at which the contract has been transacted, in terms of market fixed rate, initial points, market price and/or quotation style. In FpML, those attributes are positioned as part of the fee leg.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_product_asset.CommodityPayout (
    CommodityPayout_id INT UNIQUE NOT NULL,
    averagingFeature VARCHAR(255) %DESCRIPTION 'Indicates if the averaging calculation, when applicable, is weighted or unweighted.',
    commodityPriceReturnTerms VARCHAR(255) %DESCRIPTION 'Defines parameters in which the commodity price is assessed.',
    pricingDates VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies specific dates or parametric rules for the dates on which the price will be determined.',
    schedule VARCHAR(255) %DESCRIPTION 'Allows the full representation of a payout by defining a set of schedule periods. It supports standard schedule customization by expressing all the dates, quantities, and pricing data in a non-parametric way.',
    calculationPeriodDates VARCHAR(255) %DESCRIPTION 'Defines the calculation period dates schedule.',
    paymentDates VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the payment date schedule, as defined by the parameters that are needed to specify it, either in a parametric way or by reference to another schedule of dates (e.g. the valuation dates).',
    underlier VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the underlying product that is referenced for pricing of the applicable leg in a swap.  Referenced in the ''2018 ISDA CDM Equity Confirmation for Security Equity Swap'' as Security.',
    fxFeature VARCHAR(255) %DESCRIPTION 'Defines quanto or composite FX features that are included in the swap leg.',
    delivery VARCHAR(255) %DESCRIPTION 'Contains the information relative to the delivery of the asset.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Canonical representation of the payer and receiver parties applicable to each payout leg.',
    priceQuantity VARCHAR(255) %DESCRIPTION 'Each payout leg must implement the quantity concept as a ''resolvable'' type, which allows for different payout legs to be linked to each other (e.g. in the case of cross-curreny products).',
    principalPayment VARCHAR(255) %DESCRIPTION 'The specification of the principal exchange. Optional as only applicable in the case of cross-currency or zero-coupon swaps with a final payment.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Each payout leg must specifies its settlement terms, including the delivery type (i.e. cash vs physical, and their respective terms), the transfer type (DvP etc.) and settlement date, if any.'
);

CREATE TABLE cdm_base_datetime.AveragingSchedule (
    AveragingSchedule_id INT UNIQUE NOT NULL,
    startDate VARCHAR(255) NOT NULL %DESCRIPTION 'Date on which this period begins.',
    endDate VARCHAR(255) NOT NULL %DESCRIPTION 'Date on which this period ends.',
    averagingPeriodFrequency VARCHAR(255) NOT NULL %DESCRIPTION 'The frequency at which averaging period occurs with the regular part of the valuation schedule and their roll date convention.'
);

CREATE TABLE cdm_observable_asset.SingleValuationDate (
    SingleValuationDate_id INT UNIQUE NOT NULL,
    businessDays INT %DESCRIPTION 'A number of business days. Its precise meaning is dependant on the context in which this element is used. ISDA 2003 Term: Business Day.'
);

CREATE TABLE cdm_product_collateral_metafields.ReferenceWithMetaCollateral (
    ReferenceWithMetaCollateral_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_template.CallingPartyEnum (
    CallingPartyEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.ExecutionTypeEnum (
    ExecutionTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.RoundingDirectionEnum (
    RoundingDirectionEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.FPVFinalPriceElectionFallbackEnum (
    FPVFinalPriceElectionFallbackEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_schedule.StubPeriod (
    StubPeriod_id INT UNIQUE NOT NULL,
    calculationPeriodDatesReference VARCHAR(255) NOT NULL %DESCRIPTION 'A pointer style reference to the associated calculation period dates component defined elsewhere in the document.',
    initialStub VARCHAR(255) %DESCRIPTION 'Specifies how the initial stub amount is calculated. A single floating rate tenor different to that used for the regular part of the calculation periods schedule may be specified, or two floating tenors may be specified. If two floating rate tenors are specified then Linear Interpolation (in accordance with the 2000 ISDA Definitions, Section 8.3. Interpolation) is assumed to apply. Alternatively, an actual known stub rate or stub amount may be specified.',
    finalStub VARCHAR(255) %DESCRIPTION 'Specifies how the final stub amount is calculated. A single floating rate tenor different to that used for the regular part of the calculation periods schedule may be specified, or two floating tenors may be specified. If two floating rate tenors are specified then Linear Interpolation (in accordance with the 2000 ISDA Definitions, Section 8.3. Interpolation) is assumed to apply. Alternatively, an actual known stub rate or stub amount may be specified.'
);

CREATE TABLE cdm_base_staticdata_asset_common.ProductIdTypeEnum (
    ProductIdTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.AveragingCalculationMethod (
    AveragingCalculationMethod_id INT UNIQUE NOT NULL,
    isWeighted INT NOT NULL %DESCRIPTION 'Identifies whether the average values will be weighted or unweighted.',
    calculationMethod VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies which of the Pythagorean means is being used to compute an average value.'
);

CREATE TABLE cdm_product_common_settlement.PaymentDetail (
    PaymentDetail_id INT UNIQUE NOT NULL,
    paymentDate VARCHAR(255),
    paymentRule VARCHAR(255) NOT NULL %DESCRIPTION 'The calculation rule.',
    paymentAmount VARCHAR(255) %DESCRIPTION 'A fixed payment amount.'
);

CREATE TABLE cdm_observable_asset.TransactedPrice (
    TransactedPrice_id INT UNIQUE NOT NULL,
    marketFixedRate FLOAT %DESCRIPTION 'An optional element that only has meaning in a credit index trade. This element contains the credit spread (''fair value'') at which the trade was executed. Unlike the fixedRate of an index, the marketFixedRate varies over the life of the index depending on market conditions. The marketFixedRate is the price of the index as quoted by trading desks.',
    initialPoints FLOAT %DESCRIPTION 'An optional element that contains the up-front points expressed as a percentage of the notional. An initialPoints value of 5% would be represented as 0.05. The initialPoints element is an alternative to marketFixedRate in quoting the traded level of a trade. When initialPoints is used, the traded level is the sum of fixedRate and initialPoints. The initialPoints is one of the items that are factored into the initialPayment calculation and is payable by the Buyer to the Seller. Note that initialPoints and marketFixedRate may both be present in the same document when both implied values are desired.',
    marketPrice FLOAT %DESCRIPTION 'An optional element that only has meaning in a credit index trade. This element contains the price at which the trade was executed and is used instead of marketFixedRate on credit trades on certain indicies which are quoted using a price rather than a spread.',
    quotationStyle VARCHAR(255) %DESCRIPTION 'An optional element that contains the up-front points expressed as a percentage of the notional. An initialPoints value of 5% would be represented as 0.05. The initialPoints element is an alternative to marketFixedRate in quoting the traded level of a trade. When initialPoints is used, the traded level is the sum of fixedRate and initialPoints. The initialPoints is one of the items that are factored into the initialPayment calculation and is payable by the Buyer to the Seller. Note that initialPoints and marketFixedRate may both be present in the same document when both implied values are desired.'
);

CREATE TABLE cdm_base_staticdata_asset_common.ProductTaxonomy_secondaryAssetClass (
    ProductTaxonomy_id INT NOT NULL,
    FieldWithMetaAssetClassEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.ProductTaxonomy (
    ProductTaxonomy_id INT UNIQUE NOT NULL,
    primaryAssetClass VARCHAR(255) %DESCRIPTION 'Classifies the most important risk class of the trade.',
    secondaryAssetClass INT NOT NULL %DESCRIPTION ' Classifies additional risk classes of the trade, if any.',
    productQualifier VARCHAR(255) %DESCRIPTION 'Derived from the product payout features using a CDM product qualification function that determines the product type based on the product payout features.',
    source VARCHAR(255) %DESCRIPTION 'The source of the taxonomy that defines the rules for classifying the object. The taxonomy source is taken from a enumerated list of taxonomy names. Optional as the taxonomy source may not be provided.',
    value VARCHAR(255) %DESCRIPTION 'The value according to that taxonomy. Optional as it may not be possible to classify the object in that taxonomy.'
);

CREATE TABLE cdm_legaldocumentation_common.Resource (
    Resource_id INT UNIQUE NOT NULL,
    resourceId VARCHAR(255) NOT NULL %DESCRIPTION 'The unique identifier of the resource within the event. FpML specifies this element of type resourceIdScheme but with no specified value.',
    resourceType VARCHAR(255) %DESCRIPTION 'A description of the type of the resource, e.g. a confirmation.',
    language VARCHAR(255) %DESCRIPTION 'Indicates the language of the resource, described using the ISO 639-2/T Code.',
    sizeInBytes FLOAT %DESCRIPTION 'Indicates the size of the resource in bytes. It could be used by the end user to estimate the download time and storage needs.',
    length VARCHAR(255) %DESCRIPTION 'Indicates the length of the resource. For example, if the resource were a PDF file, the length would be in pages.',
    mimeType VARCHAR(255) %DESCRIPTION 'Indicates the type of media used to store the content. mimeType is used to determine the software product(s) that can read the content. MIME Types are described in RFC 2046.',
    name VARCHAR(255) %DESCRIPTION 'The name of the resource.  It is specified as a NormalizedString in FpML.',
    comments VARCHAR(255) %DESCRIPTION 'Any additional comments that are deemed necessary. For example, which software version is required to open the document? Or, how does this resource relate to the others for this event?',
    string VARCHAR(255) %DESCRIPTION 'Provides extra information as string. In case the extra information is in XML format, a CDATA section must be placed around the source message to prevent its interpretation as XML content.',
    url VARCHAR(255) %DESCRIPTION 'Indicates where the resource can be found, as a URL that references the information on a web server accessible to the message recipient.'
);

CREATE TABLE cdm_event_common.Affirmation_identifier (
    Affirmation_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Affirmation_party (
    Affirmation_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Affirmation_partyRole (
    Affirmation_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Affirmation (
    Affirmation_id INT UNIQUE NOT NULL,
    identifier INT NOT NULL %DESCRIPTION 'The identifier(s) associated with the trade and resulting confirmation.',
    party INT NOT NULL %DESCRIPTION 'The parties associated with the trade.',
    partyRole INT NOT NULL %DESCRIPTION 'The role(s) that party(ies) may have in relation to the trade',
    lineage VARCHAR(255) %DESCRIPTION 'The lineage attribute provides a linkage to previous lifecycle events and associated data.',
    status VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_rates.FieldWithMetaInflationRateIndexEnum (
    FieldWithMetaInflationRateIndexEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.StubPeriodTypeEnum (
    StubPeriodTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.SettlementCentreEnum (
    SettlementCentreEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.PCDeliverableObligationCharac (
    PCDeliverableObligationCharac_id INT UNIQUE NOT NULL,
    applicable INT NOT NULL %DESCRIPTION 'Indicates whether the provision is applicable.',
    partialCashSettlement INT %DESCRIPTION 'Specifies whether either ''Partial Cash Settlement of Assignable Loans'', ''Partial Cash Settlement of Consent Required Loans'' or ''Partial Cash Settlement of Participations'' is applicable. If this element is specified and Assignable Loan is a Deliverable Obligation Characteristic, any Assignable Loan that is deliverable, but where a non-receipt of Consent by the Physical Settlement Date has occurred, the Loan can be cash settled rather than physically delivered. If this element is specified and Consent Required Loan is a Deliverable Obligation Characteristic, any Consent Required Loan that is deliverable, but where a non-receipt of Consent by the Physical Settlement Date has occurred, the Loan can be cash settled rather than physically delivered. If this element is specified and Direct Loan Participation is a Deliverable Obligation Characteristic, any Participation that is deliverable, but where this participation has not been effected (has not come into effect) by the Physical Settlement Date, the participation can be cash settled rather than physically delivered.'
);

CREATE TABLE cdm_base_staticdata_asset_common.FieldWithMetaProductIdentifier (
    FieldWithMetaProductIdentifier_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_asset.ReturnTermsBase (
    ReturnTermsBase_id INT UNIQUE NOT NULL,
    valuationTerms VARCHAR(255) NOT NULL %DESCRIPTION 'Contains all non-date valuation information.',
    annualizationFactor INT %DESCRIPTION 'This specifies the numerator of an annualization factor. Frequently this number is equal to the number of observations of prices in a year e.g. 252.',
    dividendApplicability VARCHAR(255) %DESCRIPTION 'The parameters which define whether dividends are applicable',
    equityUnderlierProvisions VARCHAR(255) %DESCRIPTION 'Contains Equity underlier provisions regarding jurisdiction and fallbacks.',
    sharePriceDividendAdjustment INT %DESCRIPTION 'Indicates whether the price of shares is adjusted for dividends or not.',
    expectedN INT NOT NULL %DESCRIPTION 'Expected number of trading days.',
    initialLevel FLOAT %DESCRIPTION 'Contract will strike off this initial level. Providing just the initialLevel without initialLevelSource, infers that this is AgreedInitialPrice - a specified Initial Index Level.',
    initialLevelSource VARCHAR(255) %DESCRIPTION 'In this context, this is AgreedInitialPrice - a specified Initial Index Level.',
    meanAdjustment INT %DESCRIPTION 'Specifies whether Mean Adjustment is applicable or not in the calculation of the Realized Volatility, Variance or Correlation',
    performance VARCHAR(255) %DESCRIPTION 'Performance calculation, in accordance with Part 1 Section 12 of the 2018 ISDA CDM Equity Confirmation for Security Equity Swap, Para 75. ''Equity Performance''. Cumulative performance is used as a notional multiplier factor on both legs of an Equity Swap.'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaQuotedCurrencyPair (
    FieldWithMetaQuotedCurrencyPair_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.FxRateSourceFixing (
    FxRateSourceFixing_id INT UNIQUE NOT NULL,
    settlementRateSource VARCHAR(255) NOT NULL,
    fixingDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which the fixing is scheduled to occur.'
);

CREATE TABLE cdm_legaldocumentation_common.FieldWithMetaContractualSupplementTypeEnum (
    FieldWithMetaContractualSupplementTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.CreditNotationBoundaryEnum (
    CreditNotationBoundaryEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.BusinessDateRange (
    BusinessDateRange_id INT UNIQUE NOT NULL,
    businessDayConvention VARCHAR(255) NOT NULL %DESCRIPTION 'The convention for adjusting a date if it would otherwise fall on a day that is not a business day, as specified by an ISDA convention (e.g. Following, Precedent).',
    businessCenters VARCHAR(255) %DESCRIPTION 'The business center(s), specified either explicitly or by reference to those specified somewhere else in the instance document.',
    startDate VARCHAR(255) %DESCRIPTION 'The first date of a date range.',
    endDate VARCHAR(255) %DESCRIPTION 'The last date of a date range.'
);

CREATE TABLE cdm_event_common.QuantityChangeInstruction_change (
    QuantityChangeInstruction_id INT NOT NULL,
    PriceQuantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.QuantityChangeInstruction_lotIdentifier (
    QuantityChangeInstruction_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.QuantityChangeInstruction (
    QuantityChangeInstruction_id INT UNIQUE NOT NULL,
    change INT NOT NULL %DESCRIPTION 'Quantity by which the trade is being increased, decreased or replaced, and the price at which such quantity change is agreed. The quantity change should always be specified as a positive number, with the direction (increase/decrease/replacement) being specified by the direction enumeration. A fee can also be associated to the quantity change by specifying a Price component of type CashPrice, including the corresponding settlement date and direction.',
    direction VARCHAR(255) NOT NULL %DESCRIPTION 'Direction of the quantity change specified as either an increase, decrease or replacement.',
    lotIdentifier INT NOT NULL %DESCRIPTION 'Identifier for the new lot (in case of increase) or for the existing lot to be changed(in case of decrease or replacement). This optional attribute is mandatory in case of a decrease or replacement if the initial trade state contains multiple trade lots.'
);

CREATE TABLE cdm_observable_asset.FieldWithMetaFloatingRateOption (
    FieldWithMetaFloatingRateOption_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_base_datetime.AdjustableRelativeOrPeriodicDates (
    AdjustableRelativeOrPeriodicDates_id INT UNIQUE NOT NULL,
    adjustableDates VARCHAR(255) %DESCRIPTION 'A series of dates that shall be subject to adjustment if they would otherwise fall on a day that is not a business day in the specified business centers, together with the convention for adjusting the date.',
    relativeDates VARCHAR(255) %DESCRIPTION 'A series of dates specified as some offset to another series of dates (the anchor dates).',
    periodicDates VARCHAR(255) %DESCRIPTION 'A calculation period schedule.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.FloatingRateCalculationParameters (
    FloatingRateCalculationParameters_id INT UNIQUE NOT NULL,
    calculationMethod VARCHAR(255) NOT NULL %DESCRIPTION 'calculation type (averaging or compounding).',
    observationShiftCalculation VARCHAR(255) %DESCRIPTION 'any obervation shift parameters if applicable.',
    lookbackCalculation VARCHAR(255) %DESCRIPTION 'any lookback  parameters if applicable.',
    lockoutCalculation VARCHAR(255) %DESCRIPTION 'any lockout  parameters if applicable.',
    applicableBusinessDays VARCHAR(255) %DESCRIPTION 'the business days that are applicable for the calculation.',
    observationParameters VARCHAR(255) %DESCRIPTION ' any applicable observation parameters, such as daily caps or floors.'
);

CREATE TABLE cdm_product_asset.FloatingRateBase (
    FloatingRateBase_id INT UNIQUE NOT NULL,
    rateOption VARCHAR(255),
    spreadSchedule VARCHAR(255) %DESCRIPTION 'The ISDA Spread or a Spread schedule expressed as explicit spreads and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    capRateSchedule VARCHAR(255) %DESCRIPTION 'The cap rate or cap rate schedule, if any, which applies to the floating rate. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain level. A cap rate schedule is expressed as explicit cap rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRateSchedule VARCHAR(255) %DESCRIPTION 'The floor rate or floor rate schedule, if any, which applies to the floating rate. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. A floor rate schedule is expressed as explicit floor rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_legaldocumentation_common.SpecifiedEntityClauseEnum (
    SpecifiedEntityClauseEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.EconomicTerms (
    EconomicTerms_id INT UNIQUE NOT NULL,
    effectiveDate VARCHAR(255) %DESCRIPTION 'The first day of the terms of the trade. This day may be subject to adjustment in accordance with a business day convention.',
    terminationDate VARCHAR(255) %DESCRIPTION 'The last day of the terms of the trade. This date may be subject to adjustments in accordance with the business day convention. It can also be specified in relation to another scheduled date (e.g. the last payment date).',
    dateAdjustments VARCHAR(255) %DESCRIPTION 'The business day adjustment convention when it applies across all the payout components. This specification of the business day convention and financial business centers is used for adjusting any calculation period date if it would otherwise fall on a day that is not a business day in the specified business center.',
    payout VARCHAR(255) NOT NULL %DESCRIPTION 'The payout specifies the future cashflow computation methodology which characterizes a financial product.',
    terminationProvision VARCHAR(255) %DESCRIPTION 'Contains optional provisions pertaining to the termination characteristics of a contract.',
    calculationAgent VARCHAR(255) %DESCRIPTION 'The ISDA calculation agent responsible for performing duties as defined in the applicable product definitions.',
    nonStandardisedTerms INT %DESCRIPTION 'Specifies, when boolean value is True, that additional economic terms exist that have not been included in the product representation.',
    collateral VARCHAR(255) %DESCRIPTION 'Represents the collateral obligations of a party.'
);

CREATE TABLE cdm_product_asset.StubValue_floatingRate (
    StubValue_id INT NOT NULL,
    StubFloatingRate_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.StubValue (
    StubValue_id INT UNIQUE NOT NULL,
    floatingRate INT NOT NULL %DESCRIPTION 'The rates to be applied to the initial or final stub may be the linear interpolation of two different rates. While the majority of the time, the rate indices will be the same as that specified in the stream and only the tenor itself will be different, it is possible to specift two different rates. For example, a 2 month stub period may use the linear interpolation of a 1 month and 3 month rate. The different rates would be specified in this component. Note that a maximum of two rates can be specified. If a stub period uses the same floating rate index, including tenor, as the regular calculation periods then this should not be specified again within this component, i.e. the stub calculation period amount component may not need to be specified even if there is an initial or final stub period. If a stub period uses a different floating rate index compared to the regular calculation periods then this should be specified within this component. If specified here, they are likely to have id attributes, allowing them to be referenced from within the cashflows component.',
    stubRate FLOAT %DESCRIPTION 'An actual rate to apply for the initial or final stub period may have been agreed between the principal parties (in a similar way to how an initial rate may have been agreed for the first regular period). If an actual stub rate has been agreed then it would be included in this component. It will be a per annum rate, expressed as a decimal. A stub rate of 5% would be represented as 0.05.',
    stubAmount VARCHAR(255) %DESCRIPTION 'An actual amount to apply for the initial or final stub period may have been agreed between the two parties. If an actual stub amount has been agreed then it would be included in this component.'
);

CREATE TABLE cdm_base_staticdata_party.PersonIdentifier (
    PersonIdentifier_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) NOT NULL %DESCRIPTION 'Provides an identifier associated with a person. The identifier is unique within the public source specified in the source attribute.',
    identifierType VARCHAR(255) %DESCRIPTION 'Defines the source of the identifier.',
    country VARCHAR(255) %DESCRIPTION 'The ISO 3166 standard code for the country issuing the identifier.'
);

CREATE TABLE cdm_legaldocumentation_master.TransactionAdditionalTerms (
    TransactionAdditionalTerms_id INT UNIQUE NOT NULL,
    equityAdditionalTerms VARCHAR(255),
    foreignExchangeAdditionalTerms VARCHAR(255),
    commoditiesAdditionalTerms VARCHAR(255),
    creditAdditionalTerms VARCHAR(255),
    interestRateAdditionalTerms VARCHAR(255),
    digitalAssetAdditionalTerms VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.SettlementRateOption (
    SettlementRateOption_id INT UNIQUE NOT NULL,
    settlementRateOption VARCHAR(255) NOT NULL %DESCRIPTION 'The rate source for the conversion to the settlement currency. This source is specified through a scheme that reflects the terms of the Annex A to the 1998 FX and Currency Option Definitions.',
    priceSourceDisruption VARCHAR(255) %DESCRIPTION 'An attribute defining the parameters to get a new quote when a settlement rate option is disrupted.'
);

CREATE TABLE cdm_product_collateral.AlternativeToInterestAmountEnum (
    AlternativeToInterestAmountEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement_metafields.ReferenceWithMetaCashSettlementTerms (
    ReferenceWithMetaCashSettlementTerms_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset_fro.FloatingRateIndexCalculationDefaults (
    FloatingRateIndexCalculationDefaults_id INT UNIQUE NOT NULL,
    category VARCHAR(255) %DESCRIPTION 'The ISDA FRO category (e.g. screen rate or calculated rate).',
    indexStyle VARCHAR(255) %DESCRIPTION 'The ISDA FRO style (e.g. term rate, swap rate, etc).',
    method VARCHAR(255) %DESCRIPTION 'The ISDA FRO calculation method (e.g. OIS Compounding).'
);

CREATE TABLE cdm_product_asset_metafields.ReferenceWithMetaInterestRatePayout (
    ReferenceWithMetaInterestRatePayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.MultipleCreditNotations_creditNotation (
    MultipleCreditNotations_id INT NOT NULL,
    FieldWithMetaCreditNotation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.MultipleCreditNotations (
    MultipleCreditNotations_id INT UNIQUE NOT NULL,
    condition VARCHAR(255) NOT NULL %DESCRIPTION 'An enumerated element, to qualify whether All or Any credit notation applies.',
    creditNotation INT NOT NULL %DESCRIPTION 'At least two credit notations much be specified.',
    mismatchResolution VARCHAR(255),
    referenceAgency VARCHAR(255)
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservationDatesAndWeights_observationDates (
    CalculatedRateObservationDatesAndWeights_id INT NOT NULL,
    value VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservationDatesAndWeights_weights (
    CalculatedRateObservationDatesAndWeights_id INT NOT NULL,
    value FLOAT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculatedRateObservationDatesAndWeights (
    CalculatedRateObservationDatesAndWeights_id INT UNIQUE NOT NULL,
    observationDates INT NOT NULL %DESCRIPTION 'The observation date upon which the rate is observed.',
    weights INT NOT NULL %DESCRIPTION 'The corresponding weight for each date.'
);

CREATE TABLE cdm_observable_asset.UnitContractValuationModel (
    UnitContractValuationModel_id INT UNIQUE NOT NULL,
    numberOfUnits VARCHAR(255) NOT NULL %DESCRIPTION 'The number of units (index or securities).',
    unitPrice VARCHAR(255) NOT NULL %DESCRIPTION 'The price of each unit.'
);

CREATE TABLE cdm_event_common.ExecutionInstruction_priceQuantity (
    ExecutionInstruction_id INT NOT NULL,
    PriceQuantity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExecutionInstruction_counterparty (
    ExecutionInstruction_id INT NOT NULL,
    Counterparty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExecutionInstruction_ancillaryParty (
    ExecutionInstruction_id INT NOT NULL,
    AncillaryParty_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExecutionInstruction_parties (
    ExecutionInstruction_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExecutionInstruction_partyRoles (
    ExecutionInstruction_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExecutionInstruction_tradeIdentifier (
    ExecutionInstruction_id INT NOT NULL,
    TradeIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExecutionInstruction (
    ExecutionInstruction_id INT UNIQUE NOT NULL,
    product VARCHAR(255) NOT NULL %DESCRIPTION 'Defines the financial product to be executed and contract formed.',
    priceQuantity INT NOT NULL %DESCRIPTION 'Defines the prices (e.g. spread, equity price, FX rate), quantities (e.g. currency amount, no. shares) and settlement terms (e.g. initial fee, broker fee, up-front cds payment or option premium settlement) associated with the constituents of the transacted product.',
    counterparty INT NOT NULL %DESCRIPTION 'Maps two defined parties to counterparty enums for the transacted product.',
    ancillaryParty INT NOT NULL %DESCRIPTION 'Maps any ancillary parties, e.g. parties involved in the transaction that are not one of the two principal parties.',
    parties INT NOT NULL %DESCRIPTION 'Defines all parties to that execution, including agents and brokers.',
    partyRoles INT NOT NULL %DESCRIPTION 'Defines the role(s) that party(ies) may have in relation to the execution.',
    executionDetails VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the type and venue of execution, e.g. via voice, or electronically.',
    tradeDate VARCHAR(255) NOT NULL %DESCRIPTION 'Denotes the trade/execution date.',
    tradeTime VARCHAR(255) %DESCRIPTION 'Denotes the trade time and timezone as agreed by the parties to the trade.',
    tradeIdentifier INT NOT NULL %DESCRIPTION 'Denotes one or more identifiers associated with the transaction.',
    collateral VARCHAR(255) %DESCRIPTION 'Detail the collateral requirement anticipated with the transaction.',
    lotIdentifier VARCHAR(255) %DESCRIPTION 'Lot Identifier associated with the transaction.'
);

CREATE TABLE cdm_event_common.BillingSummary (
    BillingSummary_id INT UNIQUE NOT NULL,
    summaryTransfer VARCHAR(255) %DESCRIPTION 'The settlement terms for the billing summary',
    summaryAmountType VARCHAR(255) NOT NULL %DESCRIPTION 'The account level for the billing summary.'
);

CREATE TABLE cdm_product_template.EvergreenProvision (
    EvergreenProvision_id INT UNIQUE NOT NULL,
    singlePartyOption VARCHAR(255) %DESCRIPTION 'If evergreen termination is not available to both parties then this component specifies the buyer and seller of the option.',
    noticePeriod VARCHAR(255) NOT NULL %DESCRIPTION 'The length of each evergreen extension period relative to the effective date of the preceding contract.',
    noticeDeadlinePeriod VARCHAR(255) %DESCRIPTION 'Defines the minimum period before an evergreen is scheduled to terminate that notice can be given that it will terminate beyond the scheduled termination date.',
    noticeDeadlineDateTime VARCHAR(255) %DESCRIPTION 'A specific date and time for the notice deadline',
    extensionFrequency VARCHAR(255) NOT NULL %DESCRIPTION 'The frequency with which the evergreen contract will be extended if notice is not given.',
    finalPeriodFeeAdjustment VARCHAR(255) %DESCRIPTION 'An optional adjustment to the rate for the last period of the evergreen i.e. the period from when notice is given to stop rolling the contract through to the termination date.'
);

CREATE TABLE cdm_regulation.New (
    New_id INT UNIQUE NOT NULL,
    txId VARCHAR(255) NOT NULL,
    exctgPty VARCHAR(255) NOT NULL,
    invstmtPtyInd VARCHAR(255) NOT NULL,
    submitgPty VARCHAR(255) NOT NULL,
    buyr VARCHAR(255) NOT NULL,
    sellr VARCHAR(255) NOT NULL,
    ordrTrnsmssn VARCHAR(255) NOT NULL,
    tx VARCHAR(255) NOT NULL,
    finInstrm VARCHAR(255) NOT NULL,
    invstmtDcsnPrsn VARCHAR(255) NOT NULL,
    exctgPrsn VARCHAR(255) NOT NULL,
    addtlAttrbts VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_common_settlement.CashSettlementTerms (
    CashSettlementTerms_id INT UNIQUE NOT NULL,
    cashSettlementMethod VARCHAR(255) %DESCRIPTION 'Specifies the type of cash settlement method: cash price, yield curve etc.',
    valuationMethod VARCHAR(255) %DESCRIPTION 'Specifies the parameters required to obtain a valuation, including the source, quotation method (bid, mid etc.) and any applicable quotation amount.',
    valuationDate VARCHAR(255) %DESCRIPTION 'Defines the different methods to specify a valuation date, as used for cash settlement. The Single / Multiple ValuationDate is used for the determination of recovery in a credit event, the RelativeDateOffset is used for cash-settled option, and FxFixingDate is used for cross-currency settlement.',
    valuationTime VARCHAR(255) %DESCRIPTION 'The time of the cash settlement valuation date when the cash settlement amount will be determined according to the cash settlement method, if the parties have not otherwise been able to agree the cash settlement amount. When using quations, this is the time of day in the specified business center when the calculation agent seeks quotations for an amount of the reference obligation for purposes of cash settlement. ISDA 2003 Term: Valuation Time.',
    cashSettlementAmount VARCHAR(255) %DESCRIPTION 'The amount paid by the seller to the buyer for cash settlement on the cash settlement date. If not otherwise specified, would typically be calculated as 100 (or the Reference Price) minus the price of the Reference Obligation (all expressed as a percentage) times Floating Rate Payer Calculation Amount. ISDA 2003 Term: Cash Settlement Amount.',
    recoveryFactor FLOAT %DESCRIPTION 'Used for fixed recovery, specifies the recovery level, determined at contract formation, to be applied on a default. Used to calculate the amount paid by the seller to the buyer for cash settlement on the cash settlement date. Amount calculation is (1 minus the Recovery Factor) multiplied by the Floating Rate Payer Calculation Amount. The currency will be derived from the Floating Rate Payer Calculation Amount.',
    fixedSettlement INT %DESCRIPTION 'Used for Recovery Lock, to indicate whether fixed Settlement is Applicable or Not Applicable. If Buyer fails to deliver an effective Notice of Physical Settlement on or before the Buyer NOPS Cut-off Date, and if Seller fails to deliver an effective Seller NOPS on or before the Seller NOPS Cut-off Date, then either: (a) if Fixed Settlement is specified in the related Confirmation as not applicable, then the Seller NOPS Cut-off Date shall be the Termination Date; or (b) if Fixed Settlement is specified in the related Confirmation as applicable, then: (i) if the Fixed Settlement Amount is a positive number, Seller shall, subject to Section 3.1 (except for the requirement of satisfaction of the Notice of Physical Settlement Condition to Settlement), pay the Fixed Settlement Amount to Buyer on the Fixed Settlement Payment Date; and (ii) if the Fixed Settlement Amount is a negative number, Buyer shall, subject to Section 3.1 (except for the requirement of satisfaction of the Notice of Physical Settlement Condition to Settlement), pay the absolute value of the Fixed Settlement Amount to Seller on the Fixed Settlement Payment Date.',
    accruedInterest INT %DESCRIPTION 'Indicates whether accrued interest is included (true) or not (false). For cash settlement this specifies whether quotations should be obtained inclusive or not of accrued interest. For physical settlement this specifies whether the buyer should deliver the obligation with an outstanding principal balance that includes or excludes accrued interest. ISDA 2003 Term: Include/Exclude Accrued Interest.'
);

CREATE TABLE cdm_product_common_schedule.AveragingPeriod_schedule (
    AveragingPeriod_id INT NOT NULL,
    AveragingSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.AveragingPeriod (
    AveragingPeriod_id INT UNIQUE NOT NULL,
    schedule INT NOT NULL %DESCRIPTION 'A schedule for generating averaging observation dates.',
    averagingDateTimes VARCHAR(255) %DESCRIPTION 'An unweighted list of averaging observation date and times.',
    averagingObservations VARCHAR(255) %DESCRIPTION 'A weighted list of averaging observation date and times.',
    marketDisruption VARCHAR(255) %DESCRIPTION 'The market disruption event as defined by ISDA 2002 Definitions.'
);

CREATE TABLE cdm_observable_asset.CreditRatingOutlookEnum (
    CreditRatingOutlookEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.EquityUnderlierProvisions (
    EquityUnderlierProvisions_id INT UNIQUE NOT NULL,
    multipleExchangeIndexAnnexFallback INT %DESCRIPTION 'For an index option or swap transaction, a flag to indicate whether a relevant Multiple Exchange Index Annex is applicable to the transaction. This annex defines additional provisions which are applicable where an index is comprised of component securities that are traded on multiple exchanges.',
    componentSecurityIndexAnnexFallback INT %DESCRIPTION 'For an index option or swap transaction, a flag to indicate whether a relevant Component Security Index Annex is applicable to the transaction.',
    localJurisdiction VARCHAR(255) %DESCRIPTION 'The ISO 3166 standard code for the country within which the postal address is located.',
    relevantJurisdiction VARCHAR(255) %DESCRIPTION 'The ISO 3166 standard code for the country within which the postal address is located.'
);

CREATE TABLE cdm_product_template.Product (
    Product_id INT UNIQUE NOT NULL,
    contractualProduct VARCHAR(255) %DESCRIPTION 'Specifies the contractual product''s economic terms, product identifier, and product taxonomy.',
    index VARCHAR(255) %DESCRIPTION 'Identifies an index by referencing a product identifier.',
    loan VARCHAR(255) %DESCRIPTION 'Identifies a loan by referencing a product identifier and an optional set of attributes.',
    assetPool VARCHAR(255) %DESCRIPTION 'Identifies an asset pool product for defining pool of assets backing an asset backed security.',
    foreignExchange VARCHAR(255) %DESCRIPTION 'Defines a foreign exchange spot or forward transaction.',
    commodity VARCHAR(255) %DESCRIPTION 'Identifies a commodity by referencing a product identifier.',
    security VARCHAR(255) %DESCRIPTION 'Identifies a security by referencing a product identifier and a security type, plus an optional set of attributes.',
    basket VARCHAR(255) %DESCRIPTION 'Identifies a custom basket by referencing a product identifier and its constituents.'
);

CREATE TABLE cdm_legaldocumentation_master.EquityCorporateEvents (
    EquityCorporateEvents_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.Representations (
    Representations_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.ReferenceInformation_referenceObligation (
    ReferenceInformation_id INT NOT NULL,
    ReferenceObligation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.ReferenceInformation (
    ReferenceInformation_id INT UNIQUE NOT NULL,
    referenceEntity VARCHAR(255) NOT NULL %DESCRIPTION 'The corporate or sovereign entity which is subject to the swap transaction and any successor that assumes all or substantially all of its contractual and other obligations. Reference Entities cannot be senior or subordinated. It is the obligations of the Reference Entities that can be senior or subordinated. ISDA 2014 Credit definitions article II section 2.1: `Reference Entity` means the entity specified as such in the related Confirmation.',
    referenceObligation INT NOT NULL %DESCRIPTION 'The Reference Obligation is a financial instrument that is either issued or guaranteed by the reference entity. It serves to clarify the precise reference entity protection is being offered upon, and its legal position with regard to other related firms (parents/subsidiaries). Furthermore the Reference Obligation is ALWAYS deliverable and establishes the Pari Passu ranking (as the deliverable bonds must rank equal to the reference obligation). ISDA 2003 Term: Reference Obligation.',
    noReferenceObligation INT %DESCRIPTION 'Used to indicate that there is no Reference Obligation associated with this Credit Default Swap and that there will never be one.',
    unknownReferenceObligation INT %DESCRIPTION 'Used to indicate that the Reference obligation associated with the Credit Default Swap is currently not known. This is not valid for Legal Confirmation purposes, but is valid for earlier stages in the trade life cycle (e.g. Broker Confirmation).',
    allGuarantees INT %DESCRIPTION 'Indicates whether an obligation of the Reference Entity, guaranteed by the Reference Entity on behalf of a non-Affiliate, is to be considered an Obligation for the purpose of the transaction. It will be considered an obligation if allGuarantees is applicable (true) and not if allGuarantees is inapplicable (false). ISDA 2003 Term: All Guarantees.',
    referencePrice VARCHAR(255) %DESCRIPTION 'Used to determine (a) for physically settled trades, the Physical Settlement Amount, which equals the Floating Rate Payer Calculation Amount times the Reference Price and (b) for cash settled trades, the Cash Settlement Amount, which equals the greater of (i) the difference between the Reference Price and the Final Price and (ii) zero. ISDA 2003 Term: Reference Price.',
    referencePolicy INT %DESCRIPTION 'Applicable to the transactions on mortgage-backed security, which can make use of a reference policy. Presence of the element with value set to ''true'' indicates that the reference policy is applicable; absence implies that it is not.',
    securedList INT %DESCRIPTION 'With respect to any day, the list of Syndicated Secured Obligations of the Designated Priority of the Reference Entity published by Markit Group Limited or any successor thereto appointed by the Specified Dealers (the ''Secured List Publisher'') on or most recently before such day, which list is currently available at [http://www.markit.com]. ISDA 2003 Term: Relevant Secured List.'
);

CREATE TABLE cdm_regulation.Buyr (
    Buyr_id INT UNIQUE NOT NULL,
    acctOwnr VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_event_common.ValuationInstruction_valuation (
    ValuationInstruction_id INT NOT NULL,
    Valuation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ValuationInstruction (
    ValuationInstruction_id INT UNIQUE NOT NULL,
    valuation INT NOT NULL %DESCRIPTION 'Contains all information related to a valuation.',
    replace INT NOT NULL %DESCRIPTION 'Specifies whether the previous valuation tracks in the valuation history are removed (True) or kept (False).'
);

CREATE TABLE cdm_observable_event.CreditEventNotice_notifyingParty (
    CreditEventNotice_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_event.CreditEventNotice (
    CreditEventNotice_id INT UNIQUE NOT NULL,
    notifyingParty INT NOT NULL %DESCRIPTION 'The notifying party is the party that notifies the other party when a credit event has occurred by means of a credit event notice. If more than one party is referenced as being the notifying party then either party may notify the other of a credit event occurring. ISDA 2003 Term: Notifying Party.',
    businessCenter VARCHAR(255) %DESCRIPTION 'Inclusion of this business center element implies that Greenwich Mean Time in Section 3.3 of the 2003 ISDA Credit Derivatives Definitions is replaced by the local time of the city indicated by the businessCenter element value.',
    publiclyAvailableInformation VARCHAR(255) %DESCRIPTION 'A specified condition to settlement. Publicly available information means information that reasonably confirms any of the facts relevant to determining that a credit event or potential repudiation/moratorium, as applicable, has occurred. The ISDA defined list (2003) is the market standard and is considered comprehensive, and a minimum of two differing public sources must have published the relevant information, to declare a Credit Event. ISDA 2003 Term: Notice of Publicly Available Information Applicable.'
);

CREATE TABLE cdm_product_template.ExerciseNoticeGiverEnum (
    ExerciseNoticeGiverEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.PerformanceTransferTypeEnum (
    PerformanceTransferTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_common_settlement.PercentageRule (
    PercentageRule_id INT UNIQUE NOT NULL,
    paymentPercent FLOAT NOT NULL %DESCRIPTION 'A percentage of the notional amount.',
    notionalAmountReference VARCHAR(255) NOT NULL %DESCRIPTION 'A reference to the notional amount.'
);

CREATE TABLE cdm_product_common.NotionalAdjustmentEnum (
    NotionalAdjustmentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.QuotationRateTypeEnum (
    QuotationRateTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.FloatingRateDefinition_rateObservation (
    FloatingRateDefinition_id INT NOT NULL,
    RateObservation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.FloatingRateDefinition_capRate (
    FloatingRateDefinition_id INT NOT NULL,
    Strike_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.FloatingRateDefinition_floorRate (
    FloatingRateDefinition_id INT NOT NULL,
    Strike_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.FloatingRateDefinition (
    FloatingRateDefinition_id INT UNIQUE NOT NULL,
    calculatedRate FLOAT %DESCRIPTION 'The final calculated rate for a calculation period after any required averaging of rates A calculated rate of 5% would be represented as 0.05.',
    rateObservation INT NOT NULL %DESCRIPTION 'The details of a particular rate observation, including the fixing date and observed rate. A list of rate observation elements may be ordered in the document by ascending adjusted fixing date. An FpML document containing an unordered list of rate observations is still regarded as a conformant document.',
    floatingRateMultiplier FLOAT %DESCRIPTION 'A rate multiplier to apply to the floating rate. The multiplier can be a positive or negative decimal. This element should only be included if the multiplier is not equal to 1 (one).',
    spread FLOAT %DESCRIPTION 'The ISDA Spread, if any, which applies for the calculation period. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    capRate INT NOT NULL %DESCRIPTION 'The cap rate, if any, which applies to the floating rate for the calculation period. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain strike level. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRate INT NOT NULL %DESCRIPTION 'The floor rate, if any, which applies to the floating rate for the calculation period. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. The floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_common_schedule.ObservationDate (
    ObservationDate_id INT UNIQUE NOT NULL,
    unadjustedDate VARCHAR(255) %DESCRIPTION 'A date subject to adjustment.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).',
    weight FLOAT %DESCRIPTION 'Specifies the degree of importance of the observation.',
    observationReference VARCHAR(255) %DESCRIPTION 'Specifies an identification key for the market observation. This attribute can be used as a reference to assign weights to a series of dates defined in a parametricSchedule.'
);

CREATE TABLE cdm_base_datetime_metafields.ReferenceWithMetaBusinessDayAdjustments (
    ReferenceWithMetaBusinessDayAdjustments_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule.ResetFrequency (
    ResetFrequency_id INT UNIQUE NOT NULL,
    weeklyRollConvention VARCHAR(255) %DESCRIPTION 'The day of the week on which a weekly reset date occurs. This element must be included if the reset frequency is defined as weekly and not otherwise.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2, or 3. If the period value is T (Term) then period multiplier must contain the value 1.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month, year or term of the stream.'
);

CREATE TABLE cdm_base_staticdata_asset_common.IndexReferenceInformation_indexId (
    IndexReferenceInformation_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.IndexReferenceInformation (
    IndexReferenceInformation_id INT UNIQUE NOT NULL,
    indexName VARCHAR(255) %DESCRIPTION 'The name of the index expressed as a free format string with an associated scheme.',
    indexId INT NOT NULL %DESCRIPTION 'An index identifier (e.g. RED pair code).'
);

CREATE TABLE cdm_product_collateral.AverageTradingVolumeMethodologyEnum (
    AverageTradingVolumeMethodologyEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.ForeignExchange (
    ForeignExchange_id INT UNIQUE NOT NULL,
    exchangedCurrency1 VARCHAR(255) NOT NULL %DESCRIPTION 'This is the first of the two currency flows that define a single leg of a standard foreign exchange transaction.',
    exchangedCurrency2 VARCHAR(255) NOT NULL %DESCRIPTION 'This is the second of the two currency flows that define a single leg of a standard foreign exchange transaction.',
    tenorPeriod VARCHAR(255) %DESCRIPTION 'A tenor expressed as a period type and multiplier (e.g. 1D, 1Y, etc.)',
    exchangeRate VARCHAR(255) %DESCRIPTION 'The rate of exchange between the two currencies.'
);

CREATE TABLE cdm_event_position.ContractBase (
    ContractBase_id INT UNIQUE NOT NULL,
    contractDetails VARCHAR(255) %DESCRIPTION 'Represents information specific to trades or positions involving contractual products.',
    executionDetails VARCHAR(255) %DESCRIPTION 'Defines specific attributes that relate to trade or position executions.',
    collateral VARCHAR(255) %DESCRIPTION 'Represents the collateral obligations of a party.'
);

CREATE TABLE cdm_legaldocumentation_common_metafields.ReferenceWithMetaLegalAgreement (
    ReferenceWithMetaLegalAgreement_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_observable_asset.CashPriceTypeEnum (
    CashPriceTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.RateObservation (
    RateObservation_id INT UNIQUE NOT NULL,
    resetDate VARCHAR(255) %DESCRIPTION 'The reset date.',
    adjustedFixingDate VARCHAR(255) %DESCRIPTION 'The adjusted fixing date, i.e. the actual date the rate is observed. The date should already be adjusted for any applicable business day convention.',
    observedRate FLOAT %DESCRIPTION 'The actual observed rate before any required rate treatment is applied, e.g. before converting a rate quoted on a discount basis to an equivalent yield. An observed rate of 5% would be represented as 0.05.',
    treatedRate FLOAT %DESCRIPTION 'The observed rate after any required rate treatment is applied. A treated rate of 5% would be represented as 0.05.',
    observationWeight INT %DESCRIPTION 'The number of days weighting to be associated with the rate observation, i.e. the number of days such rate is in effect. This is applicable in the case of a weighted average method of calculation where more than one reset date is established for a single calculation period.',
    rateReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to a floating rate component defined as part of a stub calculation period amount component. It is only required when it is necessary to distinguish two rate observations for the same fixing date which could occur when linear interpolation of two different rates occurs for a stub calculation period.',
    forecastRate FLOAT %DESCRIPTION 'The value representing the forecast rate used to calculate the forecast future value of the accrual period.A value of 1% should be represented as 0.01.',
    treatedForecastRate FLOAT %DESCRIPTION 'The value representing the forecast rate after applying rate treatment rules. A value of 1% should be represented as 0.01.'
);

CREATE TABLE cdm_product_asset.ReferencePoolItem (
    ReferencePoolItem_id INT UNIQUE NOT NULL,
    constituentWeight VARCHAR(255) %DESCRIPTION 'Describes the weight of each of the constituents within the basket. If not provided, it is assumed to be equal weighted.',
    referencePair VARCHAR(255) NOT NULL,
    protectionTermsReference VARCHAR(255) %DESCRIPTION 'Reference to the documentation terms applicable to this item.',
    cashSettlementTermsReference VARCHAR(255) %DESCRIPTION 'Reference to the cash settlement terms applicable to this item.',
    physicalSettlementTermsReference VARCHAR(255) %DESCRIPTION 'Reference to the physical settlement terms applicable to this item.'
);

CREATE TABLE cdm_product_template.SecurityLeg (
    SecurityLeg_id INT UNIQUE NOT NULL,
    buyerSeller VARCHAR(255) NOT NULL %DESCRIPTION 'Whether the leg is a buyer or seller of security',
    settlementDate VARCHAR(255) NOT NULL %DESCRIPTION 'Settlement or Payment Date for the security leg',
    settlementAmount VARCHAR(255) %DESCRIPTION 'Settlement amount for the security leg',
    settlementCurrency VARCHAR(255) %DESCRIPTION 'Settlement Currency for use where the Settlement Amount cannot be known in advance.',
    fxRate VARCHAR(255) %DESCRIPTION 'FX rate in case when cash settlement amount is in a different currency to the security.',
    deliveryDate VARCHAR(255) %DESCRIPTION 'Delivery Date for the transaction. Delivery Date can be populated when it is not equal to the Settlement Date.',
    deliveryMethod VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies a delivery method for the security transaction.'
);

CREATE TABLE cdm_base_datetime.CompoundingTypeEnum (
    CompoundingTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_contract.Agreement (
    Agreement_id INT UNIQUE NOT NULL,
    creditSupportAgreementElections VARCHAR(255) %DESCRIPTION 'Elections to specify a Credit Support Annex or Credit Support Deed for Intial or Variation Margin.',
    collateralTransferAgreementElections VARCHAR(255) %DESCRIPTION 'Elections to specify a Collateral Transfer Agreement.',
    securityAgreementElections VARCHAR(255) %DESCRIPTION 'Elections to specify a Security agreement.',
    masterAgreementSchedule VARCHAR(255) %DESCRIPTION 'Elections to specify a Master Agreement Schedule.',
    transactionAdditionalTerms VARCHAR(255) %DESCRIPTION 'Any additional terms which mainly intend to specify the extraordinary events that may affect a trade and the related contractual rights and obligation of the parties when this happens'
);

CREATE TABLE cdm_product_collateral.IssuerCriteria_issuerType (
    IssuerCriteria_id INT NOT NULL,
    CollateralIssuerType_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.IssuerCriteria_issuerCountryOfOrigin (
    IssuerCriteria_id INT NOT NULL,
    ISOCountryCodeEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.IssuerCriteria_issuerName (
    IssuerCriteria_id INT NOT NULL,
    LegalEntity_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.IssuerCriteria_issuerAgencyRating (
    IssuerCriteria_id INT NOT NULL,
    AgencyRatingCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.IssuerCriteria_sovereignAgencyRating (
    IssuerCriteria_id INT NOT NULL,
    AgencyRatingCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.IssuerCriteria (
    IssuerCriteria_id INT UNIQUE NOT NULL,
    issuerType INT NOT NULL %DESCRIPTION 'Represents a filter based on the type of entity issuing the asset.',
    issuerCountryOfOrigin INT NOT NULL %DESCRIPTION 'Represents a filter on the issuing entity country of origin based on the ISO Standard 3166, which is the same as filtering by eligible Sovereigns.',
    issuerName INT NOT NULL %DESCRIPTION 'Specifies the issuing entity name or LEI.',
    issuerAgencyRating INT NOT NULL %DESCRIPTION 'Represents an agency rating based on default risk and creditors claim in event of default associated with asset issuer.',
    sovereignAgencyRating INT NOT NULL %DESCRIPTION 'Represents an agency rating based on default risk of the country of the issuer.',
    counterpartyOwnIssuePermitted INT %DESCRIPTION 'Represents a filter based on whether it is permitted for the underlying asset to be issued by the posting entity or part of their corporate family.'
);

CREATE TABLE cdm_event_common.MarginCallResponse_marginCallResponseAction (
    MarginCallResponse_id INT NOT NULL,
    MarginCallResponseAction_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallResponse_party (
    MarginCallResponse_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallResponse_partyRole (
    MarginCallResponse_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallResponse (
    MarginCallResponse_id INT UNIQUE NOT NULL,
    marginCallResponseAction INT NOT NULL %DESCRIPTION 'Specifies the margin call action details, including collateral to be moved and direction.',
    marginResponseType VARCHAR(255) NOT NULL %DESCRIPTION 'Indicates the response type, such as, is the margin call response a ''full'' ''part'' agreement or ''dispute''.',
    agreedAmountBaseCurrency VARCHAR(255) NOT NULL %DESCRIPTION 'Indicates the amount that posting entity agrees to remit in response to margin call (in base currency).',
    instructionType VARCHAR(255) %DESCRIPTION 'Identifies the enumeration values to specify the call notification type, direction, specific action type.',
    party INT NOT NULL %DESCRIPTION 'Represents the parties to the margin call. The cardinality is optional to address the case where both parties of the event are specified and a third party if applicable.',
    partyRole INT NOT NULL %DESCRIPTION 'Represents the role each specified party takes in the margin call. further to the principal roles, payer and receiver.',
    clearingBroker VARCHAR(255) %DESCRIPTION 'Indicates the name of the Clearing Broker FCM/DCM.',
    callIdentifier VARCHAR(255) %DESCRIPTION 'Represents a unique Identifier for a margin call message, that can be referenced throughout all points of the process.',
    callAgreementType VARCHAR(255) %DESCRIPTION 'Specifies the legal agreement type the margin call is generated from and governed by.',
    agreementMinimumTransferAmount VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement minimum transfer amount in base currency.',
    agreementThreshold VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement threshold amount in base currency.',
    agreementRounding VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement rounding in base currency.',
    regMarginType VARCHAR(255) %DESCRIPTION 'Identifies margin type and if related regulatory mandate',
    regIMRole VARCHAR(255) %DESCRIPTION 'Indicates the role of the party in an regulatory initial margin call instruction (i.e Pledgor party or Secured party).',
    baseCurrencyExposure VARCHAR(255) %DESCRIPTION 'Represents the current mark to market value or IM calculation value of the trade portfolio as recorded by the principle (in base currency), to be referenced in a margin call.',
    collateralPortfolio VARCHAR(255) %DESCRIPTION 'Represents attributes to define the details of collateral assets within a collateral portfolio to be used in margin call messaging and contribute to collateral balances e.g securities in a collateral account recorded by the principal as held or posted.',
    independentAmountBalance VARCHAR(255) %DESCRIPTION 'Represents additional credit support amount over and above mark to market value.'
);

CREATE TABLE cdm_product_asset.AssetDeliveryPeriods_profile (
    AssetDeliveryPeriods_id INT NOT NULL,
    AssetDeliveryProfile_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.AssetDeliveryPeriods (
    AssetDeliveryPeriods_id INT UNIQUE NOT NULL,
    profile INT NOT NULL %DESCRIPTION 'Defines the delivery profile of the asset, including the load type and the delivery intervals.',
    startDate VARCHAR(255) %DESCRIPTION 'Delivery start date',
    endDate VARCHAR(255) %DESCRIPTION 'Delivery end date'
);

CREATE TABLE cdm_product_template.PassThroughItem (
    PassThroughItem_id INT UNIQUE NOT NULL,
    payerReceiver VARCHAR(255) NOT NULL %DESCRIPTION 'This attribute doesn''t exists in the FpML construct, which makes use of the PayerReceiver.model group.',
    passThroughPercentage FLOAT NOT NULL %DESCRIPTION 'Percentage of payments from the underlier which are passed through.'
);

CREATE TABLE cdm_product_collateral.DeliveryAmount (
    DeliveryAmount_id INT UNIQUE NOT NULL,
    standardElection VARCHAR(255) %DESCRIPTION 'The standard election as specified by an enumeration.',
    customElection VARCHAR(255) %DESCRIPTION 'The custom election that might be specified by the parties to the agreement.'
);

CREATE TABLE cdm_product_asset.FloatingRateSpecification (
    FloatingRateSpecification_id INT UNIQUE NOT NULL,
    initialRate VARCHAR(255) %DESCRIPTION 'The initial floating rate reset agreed between the principal parties involved in the trade. This is assumed to be the first required reset rate for the first regular calculation period. It should only be included when the rate is not equal to the rate published on the source implied by the floating rate index. An initial rate of 5% would be represented as 0.05.',
    finalRateRounding VARCHAR(255) %DESCRIPTION 'The rounding convention to apply to the final rate used in determination of a calculation period amount.',
    averagingMethod VARCHAR(255) %DESCRIPTION 'If averaging is applicable, this component specifies whether a weighted or unweighted average method of calculation is to be used. The component must only be included when averaging applies.',
    negativeInterestRateTreatment VARCHAR(255) %DESCRIPTION 'The specification of any provisions for calculating payment obligations when a floating rate is negative (either due to a quoted negative floating rate or by operation of a spread that is subtracted from the floating rate).',
    floatingRateMultiplierSchedule VARCHAR(255) %DESCRIPTION 'A rate multiplier or multiplier schedule to apply to the floating rate. A multiplier schedule is expressed as explicit multipliers and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in the calculationPeriodDatesAdjustments. The multiplier can be a positive or negative decimal. This element should only be included if the multiplier is not equal to 1 (one) for the term of the stream.',
    rateTreatment VARCHAR(255) %DESCRIPTION 'The specification of any rate conversion which needs to be applied to the observed rate before being used in any calculations. The two common conversions are for securities quoted on a bank discount basis which will need to be converted to either a Money Market Yield or Bond Equivalent Yield. See the Annex to the 2000 ISDA Definitions, Section 7.3. Certain General Definitions Relating to Floating Rate Options, paragraphs (g) and (h) for definitions of these terms.',
    calculationParameters VARCHAR(255) %DESCRIPTION 'Support for modular calculated rates, such such as lockout compound calculations.',
    fallbackRate VARCHAR(255) %DESCRIPTION 'Definition of any fallback rate that may be applicable.',
    rateOption VARCHAR(255),
    spreadSchedule VARCHAR(255) %DESCRIPTION 'The ISDA Spread or a Spread schedule expressed as explicit spreads and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    capRateSchedule VARCHAR(255) %DESCRIPTION 'The cap rate or cap rate schedule, if any, which applies to the floating rate. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain level. A cap rate schedule is expressed as explicit cap rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRateSchedule VARCHAR(255) %DESCRIPTION 'The floor rate or floor rate schedule, if any, which applies to the floating rate. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. A floor rate schedule is expressed as explicit floor rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_template_metafields.ReferenceWithMetaForwardPayout (
    ReferenceWithMetaForwardPayout_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_rates.InflationRateIndexEnum (
    InflationRateIndexEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.CommodityReferencePriceEnum (
    CommodityReferencePriceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset.CashPrice (
    CashPrice_id INT UNIQUE NOT NULL,
    cashPriceType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the type of Cash Price.',
    premiumExpression VARCHAR(255) %DESCRIPTION 'Specifies a premium when expressed in a way other than an amount, and any required forward starting price definition.',
    feeType VARCHAR(255) %DESCRIPTION 'Specifies the event type associated with a fee.'
);

CREATE TABLE cdm_base_staticdata_party.PartyRoleEnum (
    PartyRoleEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_position.AvailableInventory_party (
    AvailableInventory_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AvailableInventory_partyRole (
    AvailableInventory_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AvailableInventory_availableInventoryRecord (
    AvailableInventory_id INT NOT NULL,
    AvailableInventoryRecord_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_position.AvailableInventory (
    AvailableInventory_id INT UNIQUE NOT NULL,
    messageInformation VARCHAR(255) %DESCRIPTION 'Allows details related to the availability messaging use case to be defined',
    party INT NOT NULL %DESCRIPTION 'Defines all parties involved for the list of inventory records in this set of inventory. For example, when used to describe securities lending availability, this could hold the sender of the availability, the intended recipient, the beneficial owner(s), the lender (which may differ from the sender as the lender may have the same piece of availability going through multiple agents), an agent or a venue.',
    partyRole INT NOT NULL %DESCRIPTION 'Defines the role(s) that party(ies) may have in relation to the inventory.',
    availableInventoryRecord INT NOT NULL %DESCRIPTION 'An array holding the list of inventory being described. Each element in the inventoryRecord array represents an individual piece of inventory i.e. a security.'
);

CREATE TABLE cdm_legaldocumentation_csa.CollateralTransferAgreementElections (
    CollateralTransferAgreementElections_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Transfer_identifier (
    Transfer_id INT NOT NULL,
    FieldWithMetaIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Transfer (
    Transfer_id INT UNIQUE NOT NULL,
    settlementOrigin VARCHAR(255) %DESCRIPTION 'Represents the origin to the transfer as a reference for lineage purposes, whether it originated from trade level settlement terms or from payment terms on an economic payout.',
    resetOrigin VARCHAR(255) %DESCRIPTION 'Represents the reset and observation values that were used to determine the transfer amount.',
    transferExpression VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies a transfer expression (cash price, performance amount, scheduled payment amount, etc.) to define the nature of the transfer amount and its source.',
    identifier INT NOT NULL %DESCRIPTION 'Represents a unique reference to the transfer.',
    quantity VARCHAR(255) %DESCRIPTION 'Represents the amount of the asset to be transferred.',
    observable VARCHAR(255) %DESCRIPTION 'Represents the object that is subject to the transfer, it could be an asset or a reference.',
    payerReceiver VARCHAR(255) %DESCRIPTION 'Represents the parties to the transfer and their role.',
    settlementDate VARCHAR(255) %DESCRIPTION 'Represents the date on which the transfer to due.'
);

CREATE TABLE cdm_product_common_schedule.DateRelativeToValuationDates_valuationDatesReference (
    DateRelativeToValuationDates_id INT NOT NULL,
    ReferenceWithMetaPerformanceValuationDates_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_schedule.DateRelativeToValuationDates (
    DateRelativeToValuationDates_id INT UNIQUE NOT NULL,
    valuationDatesReference INT NOT NULL %DESCRIPTION 'A set of href pointers to valuation period dates defined somewhere else in the document.'
);

CREATE TABLE cdm_product_common_schedule.FxLinkedNotionalSchedule (
    FxLinkedNotionalSchedule_id INT UNIQUE NOT NULL,
    varyingNotionalCurrency VARCHAR(255) NOT NULL %DESCRIPTION 'The currency of the varying notional amount, i.e. the notional amount being determined periodically based on observation of a spot currency exchange rate. The list of valid currencies is not presently positioned as an enumeration as part of the CDM because that scope is limited to the values specified by ISDA and FpML. As a result, implementers have to make reference to the relevant standard, such as the ISO 4217 standard for currency codes.',
    varyingNotionalFixingDates VARCHAR(255) NOT NULL %DESCRIPTION 'The dates on which spot currency exchange rates are observed for purposes of determining the varying notional currency amount that will apply to a calculation period.',
    fxSpotRateSource VARCHAR(255) NOT NULL %DESCRIPTION 'The information source and time at which the spot currency exchange rate will be observed.',
    fixingTime VARCHAR(255) %DESCRIPTION 'The time at which the spot currency exchange rate will be observed. It is specified as a time in a business day calendar location, e.g. 11:00am London time.',
    varyingNotionalInterimExchangePaymentDates VARCHAR(255) NOT NULL %DESCRIPTION 'The dates on which interim exchanges of notional are paid. Interim exchanges will arise as a result of changes in the spot currency exchange amount or changes in the constant notional schedule (e.g. amortisation).'
);

CREATE TABLE cdm_base_datetime.FieldWithMetaBusinessCenterEnum (
    FieldWithMetaBusinessCenterEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_legaldocumentation_master.MasterConfirmationBase (
    MasterConfirmationBase_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.State (
    State_id INT UNIQUE NOT NULL,
    closedState VARCHAR(255) %DESCRIPTION 'Represents the qualification of what led to the trade''s closure alongside the dates on which this closure took effect.',
    positionState VARCHAR(255) %DESCRIPTION 'Identifies the state of the position, to distinguish if just executed, formed, already settled, closed, etc.'
);

CREATE TABLE cdm_product_asset.CreditIndexReferenceInformation_excludedReferenceEntity (
    CreditIndexReferenceInformation_id INT NOT NULL,
    ReferenceInformation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.CreditIndexReferenceInformation_indexId (
    CreditIndexReferenceInformation_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.CreditIndexReferenceInformation (
    CreditIndexReferenceInformation_id INT UNIQUE NOT NULL,
    indexSeries INT %DESCRIPTION 'A CDS index series identifier, e.g. 1, 2, 3 etc.',
    indexAnnexVersion INT %DESCRIPTION 'A CDS index series version identifier, e.g. 1, 2, 3 etc.',
    indexAnnexDate VARCHAR(255) %DESCRIPTION 'A CDS index series annex date.',
    indexAnnexSource VARCHAR(255) %DESCRIPTION 'A CDS index series annex source.',
    excludedReferenceEntity INT NOT NULL %DESCRIPTION 'Excluded reference entity.',
    tranche VARCHAR(255) %DESCRIPTION 'This element contains CDS tranche terms.',
    settledEntityMatrix VARCHAR(255) %DESCRIPTION 'Used to specify the Relevant Settled Entity Matrix when there are settled entities at the time of the trade.',
    indexFactor FLOAT %DESCRIPTION 'Index Factor is the index version factor or percent, expressed as an absolute decimal value between 0 and 1, that multiplied by the original notional amount yields the notional amount covered by the seller of protection.',
    seniority VARCHAR(255) %DESCRIPTION 'Seniority of debt instruments comprising the index.',
    indexName VARCHAR(255) %DESCRIPTION 'The name of the index expressed as a free format string with an associated scheme.',
    indexId INT NOT NULL %DESCRIPTION 'An index identifier (e.g. RED pair code).'
);

CREATE TABLE cdm_event_common.Instruction (
    Instruction_id INT UNIQUE NOT NULL,
    primitiveInstruction VARCHAR(255) %DESCRIPTION 'Specifies the primitive instructions that will be used to call primitive event functions.',
    before VARCHAR(255) %DESCRIPTION 'Specifies the trade state that will be acted on by the primitive event functions.'
);

CREATE TABLE cdm_product_template.Duration (
    Duration_id INT UNIQUE NOT NULL,
    durationType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the Duration Terms of the Security Financing transaction. e.g. Open or Term.',
    evergreenProvision VARCHAR(255) %DESCRIPTION 'A data defining: the right of a party to exercise an Evergreen option'
);

CREATE TABLE cdm_event_common.Lineage_tradeReference (
    Lineage_id INT NOT NULL,
    ReferenceWithMetaTrade_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Lineage_eventReference (
    Lineage_id INT NOT NULL,
    ReferenceWithMetaWorkflowStep_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Lineage_portfolioStateReference (
    Lineage_id INT NOT NULL,
    ReferenceWithMetaPortfolioState_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Lineage (
    Lineage_id INT UNIQUE NOT NULL,
    tradeReference INT NOT NULL,
    eventReference INT NOT NULL %DESCRIPTION 'The reference to the instantiation of an Event object, either through a globalKey or an xml-derived id/href mechanism. The definition associated to the Lineage class provides more details with respect to those referencing approaches, their expected usage and available implementation.',
    portfolioStateReference INT NOT NULL %DESCRIPTION 'The reference to the previous state of a Portfolio, in a chain of Events leading up to a build of that Portfolio as the holding of Product(s) in specific Quantity(ies). As part of the PortfolioState object, a pointer to the previous PortfolioState is provided through a Lineage object, together with pointer(s) to the Event or set of Events leading up to the current (new) state.'
);

CREATE TABLE cdm_product_template.OptionalEarlyTermination_exerciseNotice (
    OptionalEarlyTermination_id INT NOT NULL,
    ExerciseNotice_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.OptionalEarlyTermination (
    OptionalEarlyTermination_id INT UNIQUE NOT NULL,
    singlePartyOption VARCHAR(255) %DESCRIPTION 'If optional early termination is not available to both parties then this component specifies the buyer and seller of the option. In FpML, this attribute is of type SinglePsrtyOption, which actually consists of the BuyerSeller.model.',
    mutualEarlyTermination INT %DESCRIPTION 'Used for specifying whether the Mutual Early Termination Right that is detailed in the Master Confirmation will apply.',
    americanExercise VARCHAR(255) %DESCRIPTION 'American exercise. FpML implementations consists in an exercise substitution group.',
    bermudaExercise VARCHAR(255) %DESCRIPTION 'Bermuda exercise. FpML implementations consists in an exercise substitution group.',
    europeanExercise VARCHAR(255) %DESCRIPTION 'European exercise. FpML implementations consists in an exercise substitution group.',
    exerciseNotice INT NOT NULL %DESCRIPTION 'Definition of the party to whom notice of exercise should be given.',
    followUpConfirmation INT %DESCRIPTION 'A flag to indicate whether follow-up confirmation of exercise (written or electronic) is required following telephonic notice by the buyer to the seller or seller''s agent.',
    calculationAgent VARCHAR(255) %DESCRIPTION 'The ISDA Calculation Agent responsible for performing duties associated with an optional early termination.',
    cashSettlement VARCHAR(255) %DESCRIPTION 'If specified, this means that cash settlement is applicable to the transaction and defines the parameters associated with the cash settlement procedure. If not specified, then physical settlement is applicable.',
    optionalEarlyTerminationAdjustedDates VARCHAR(255) %DESCRIPTION 'An early termination provision to terminate the trade at fair value where one or both parties have the right to decide on termination.'
);

CREATE TABLE cdm_product_collateral.AgencyRatingCriteria_creditNotation (
    AgencyRatingCriteria_id INT NOT NULL,
    CreditNotation_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.AgencyRatingCriteria (
    AgencyRatingCriteria_id INT UNIQUE NOT NULL,
    qualifier VARCHAR(255) NOT NULL %DESCRIPTION 'Indicates whether all or any agency ratings apply.',
    creditNotation INT NOT NULL %DESCRIPTION 'Indicates the agency rating criteria specified for the asset or issuer.',
    mismatchResolution VARCHAR(255) %DESCRIPTION 'Indicator for options to be used if several agency ratings (>1) are specified and its necessary to identify specific charateristics. i.e (lowest or highest).',
    referenceAgency VARCHAR(255) %DESCRIPTION 'identifies the dominant reference agency if there is a missmatch and several reference agencies exsist.',
    boundary VARCHAR(255) %DESCRIPTION 'Indicates the boundary of a credit agency rating i.e minimum or maximum.'
);

CREATE TABLE cdm_observable_asset_metafields.ReferenceWithMetaQuotedCurrencyPair (
    ReferenceWithMetaQuotedCurrencyPair_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_event_common.PositionIdentifier_assignedIdentifier (
    PositionIdentifier_id INT NOT NULL,
    AssignedIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.PositionIdentifier (
    PositionIdentifier_id INT UNIQUE NOT NULL,
    identifierType VARCHAR(255) %DESCRIPTION 'The enumerated classification of the identifier. Optional as a position identifier may be party-specific, in which case it may not correspond to any established classification.',
    issuerReference VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified by reference to a party specified as part of the transaction.',
    issuer VARCHAR(255) %DESCRIPTION 'The identifier issuer, when specified explicitly alongside the identifier value (instead of being specified by reference to a party).',
    assignedIdentifier INT NOT NULL %DESCRIPTION 'The identifier value. This level of indirection between the issuer and the identifier and its version provides the ability to associate multiple identifiers to one issuer, consistently with the FpML PartyTradeIdentifier.'
);

CREATE TABLE cdm_base_staticdata_asset_common.IdentifiedProduct (
    IdentifiedProduct_id INT UNIQUE NOT NULL,
    productIdentifier VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_event_workflow.WarehouseIdentityEnum (
    WarehouseIdentityEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.RoundingModeEnum (
    RoundingModeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.FieldWithMetaNaturalPersonRoleEnum (
    FieldWithMetaNaturalPersonRoleEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_event_common.MarginCallBase_party (
    MarginCallBase_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallBase_partyRole (
    MarginCallBase_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.MarginCallBase (
    MarginCallBase_id INT UNIQUE NOT NULL,
    instructionType VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the enumeration values to specify the call notification type, direction, specific action type.',
    party INT NOT NULL %DESCRIPTION 'Represents the parties to the margin call. The cardinality is optional to address the case where both parties of the event are specified and a third party if applicable.',
    partyRole INT NOT NULL %DESCRIPTION 'Represents the role each specified party takes in the margin call. further to the principal roles, payer and receiver.',
    clearingBroker VARCHAR(255) %DESCRIPTION 'Indicates the name of the Clearing Broker FCM/DCM.',
    callIdentifier VARCHAR(255) %DESCRIPTION 'Represents a unique Identifier for a margin call message, that can be referenced throughout all points of the process.',
    callAgreementType VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the legal agreement type the margin call is generated from and governed by.',
    agreementMinimumTransferAmount VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement minimum transfer amount in base currency.',
    agreementThreshold VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement threshold amount in base currency.',
    agreementRounding VARCHAR(255) %DESCRIPTION 'Specifies the collateral legal agreement rounding in base currency.',
    regMarginType VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies margin type and if related regulatory mandate',
    regIMRole VARCHAR(255) %DESCRIPTION 'Indicates the role of the party in an regulatory initial margin call instruction (i.e Pledgor party or Secured party).',
    baseCurrencyExposure VARCHAR(255) %DESCRIPTION 'Represents the current mark to market value or IM calculation value of the trade portfolio as recorded by the principle (in base currency), to be referenced in a margin call.',
    collateralPortfolio VARCHAR(255) %DESCRIPTION 'Represents attributes to define the details of collateral assets within a collateral portfolio to be used in margin call messaging and contribute to collateral balances e.g securities in a collateral account recorded by the principal as held or posted.',
    independentAmountBalance VARCHAR(255) %DESCRIPTION 'Represents additional credit support amount over and above mark to market value.'
);

CREATE TABLE cdm_product_asset.DiscountingTypeEnum (
    DiscountingTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.UK_EMIR_EligibleCollateralEnum (
    UK_EMIR_EligibleCollateralEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.EuropeanExercise_expirationDate (
    EuropeanExercise_id INT NOT NULL,
    AdjustableOrRelativeDate_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.EuropeanExercise (
    EuropeanExercise_id INT UNIQUE NOT NULL,
    expirationDate INT NOT NULL %DESCRIPTION 'The last day within an exercise period for an American style option. For a European style option it is the only day within the exercise period.',
    relevantUnderlyingDate VARCHAR(255) %DESCRIPTION 'The effective date on the underlying product if the option is exercised.  For example, for a swaption it is the swap effective date, for an option on an FX spot or forward it is the value date for settlement, and in an extendible/cancelable provision it is the swap termination date, which is the date on which the termination is effective.',
    earliestExerciseTime VARCHAR(255) %DESCRIPTION 'The earliest time at which notice of exercise can be given by the buyer to the seller (or seller''s agent) on the expiration date.',
    expirationTime VARCHAR(255) NOT NULL %DESCRIPTION 'The latest time for exercise on expirationDate.',
    expirationTimeType VARCHAR(255) %DESCRIPTION 'The time of day at which the equity option expires, for example the official closing time of the exchange.',
    partialExercise VARCHAR(255) %DESCRIPTION 'As defined in the 2000 ISDA Definitions, Section 12.3. Partial Exercise, the buyer of the option has the right to exercise all or less than all the notional amount of the underlying swap on the expiration date, but may not exercise less than the minimum notional amount, and if an integral multiple amount is specified, the notional amount exercised must be equal to, or be an integral multiple of, the integral multiple amount.',
    exerciseFee VARCHAR(255) %DESCRIPTION 'A fee to be paid on exercise. This could be represented as an amount or a rate and notional reference on which to apply the rate.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementVariableSet_variableSet (
    MasterAgreementVariableSet_id INT NOT NULL,
    MasterAgreementVariableSet_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementVariableSet (
    MasterAgreementVariableSet_id INT UNIQUE NOT NULL,
    variableSet INT NOT NULL %DESCRIPTION 'For some variants a table of variables is required. To support this use case we need to be able to specify variables within variables. Including a variable set here gives us infinite nesting opportunities - realistically we are only ever expecting that a table would need to be defined for any particular clause, so we would expect two levels of nesting as a maximum i.e. variableSet->variableSet->name/value.',
    name VARCHAR(255) %DESCRIPTION 'The name of the variable',
    value VARCHAR(255) %DESCRIPTION 'The value for this variable'
);

CREATE TABLE cdm_product_collateral.CheckEligibilityResult_matchingEligibleCriteria (
    CheckEligibilityResult_id INT NOT NULL,
    EligibleCollateralCriteria_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_collateral.CheckEligibilityResult (
    CheckEligibilityResult_id INT UNIQUE NOT NULL,
    isEligible INT NOT NULL %DESCRIPTION 'True if the asset is eligible',
    matchingEligibleCriteria INT NOT NULL %DESCRIPTION 'Eligible Collateral Criteria that matched the eligibility query',
    eligibilityQuery VARCHAR(255) %DESCRIPTION 'eligibility query was was checked against the eligible collateral specification',
    specification VARCHAR(255) NOT NULL %DESCRIPTION 'The eligible collateral specification that was queried'
);

CREATE TABLE cdm_base_staticdata_asset_common_metafields.ReferenceWithMetaProductIdentifier (
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_base_staticdata_asset_common.DeliveryDateParameters (
    DeliveryDateParameters_id INT UNIQUE NOT NULL,
    deliveryNearby VARCHAR(255) %DESCRIPTION 'Provides a container for the parametric representation that specifies which nearby contract date would be used as a refrence for a price.',
    deliveryDate VARCHAR(255) %DESCRIPTION 'Specifies the specific contract date for the contract that should be referenced for a price.',
    deliveryDateRollConvention VARCHAR(255) %DESCRIPTION 'Specifies, for a Commodity Transaction that references a listed future, the day on which the specified future will roll to the next nearby month prior to the expiration of the referenced future. If the future will not roll at all - i.e. the price will be taken from the expiring contract, 0 days should be specified here. If the future will roll to the next nearby on the last trading day - i.e. the price will be taken from the next nearby on the last trading day, then 1 business day should be specified and so on.',
    deliveryDateExpirationConvention VARCHAR(255) %DESCRIPTION 'Specifies, for a Commodity Transaction that references a listed future, the day on which the specified future will expire ahead of the actual expiration of the referenced future. For example: Z21 Contract expires on 19Nov21, with an adjust of 2D the ''expire'' will be 16Nov21. DeliveryDateRollConvention takes precedence. Example: Pricing on the Z21 Contract with NearbyContractDay and a deliveryDateRoll of 10D, Sampling of the F22 Contract will occur on 8Nov21 through the last Date of the Z21 Contract. With an ExpConvention of 5D, the last sampling date on the F22 contract will be 12Nov21.'
);

CREATE TABLE cdm_observable_asset.ValuationMethodEnum (
    ValuationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.DividendPeriod (
    DividendPeriod_id INT UNIQUE NOT NULL,
    startDate VARCHAR(255) %DESCRIPTION 'Dividend period start date.',
    endDate VARCHAR(255) %DESCRIPTION 'Dividend period end date.',
    dateAdjustments VARCHAR(255) NOT NULL %DESCRIPTION 'Date adjustments for all unadjusted dates in this dividend period.',
    basketConstituent VARCHAR(255) %DESCRIPTION 'For basket undeliers, reference to the basket component which is paying dividends in the specified period.',
    dividendPaymentDate VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies when the dividend will be paid to the receiver of the equity return. Has the meaning as defined in the ISDA 2002 Equity Derivatives Definitions. Is not applicable in the case of a dividend reinvestment election.',
    dividendValuationDate VARCHAR(255) %DESCRIPTION 'Specifies the dividend valuation dates of the swap.'
);

CREATE TABLE cdm_base_datetime.TimeZone (
    TimeZone_id INT UNIQUE NOT NULL,
    time VARCHAR(255) NOT NULL %DESCRIPTION 'The observation time.',
    location VARCHAR(255) %DESCRIPTION 'FpML specifies the timezoneLocationScheme by reference to the Time Zone Database (a.k.a. tz database) maintained by IANA, the Internet Assigned Numbers Authority.'
);

CREATE TABLE cdm_observable_asset_calculatedrate.CalculationMethodEnum (
    CalculationMethodEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_legaldocumentation_common.FieldWithMetaMatrixTypeEnum (
    FieldWithMetaMatrixTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_asset.StubFloatingRate_spreadSchedule (
    StubFloatingRate_id INT NOT NULL,
    SpreadSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.StubFloatingRate_capRateSchedule (
    StubFloatingRate_id INT NOT NULL,
    StrikeSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.StubFloatingRate_floorRateSchedule (
    StubFloatingRate_id INT NOT NULL,
    StrikeSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_asset.StubFloatingRate (
    StubFloatingRate_id INT UNIQUE NOT NULL,
    floatingRateIndex VARCHAR(255) NOT NULL %DESCRIPTION 'The floating rate index.',
    indexTenor VARCHAR(255) %DESCRIPTION 'The ISDA Designated Maturity, i.e. the tenor of the floating rate.',
    floatingRateMultiplierSchedule VARCHAR(255) %DESCRIPTION 'A rate multiplier or multiplier schedule to apply to the floating rate. A multiplier schedule is expressed as explicit multipliers and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in the calculationPeriodDatesAdjustments. The multiplier can be a positive or negative decimal. This element should only be included if the multiplier is not equal to 1 (one) for the term of the stream.',
    spreadSchedule INT NOT NULL %DESCRIPTION 'The ISDA Spread or a Spread schedule expressed as explicit spreads and dates. In the case of a schedule, the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The spread is a per annum rate, expressed as a decimal. For purposes of determining a calculation period amount, if positive the spread will be added to the floating rate and if negative the spread will be subtracted from the floating rate. A positive 10 basis point (0.1%) spread would be represented as 0.001.',
    rateTreatment VARCHAR(255) %DESCRIPTION 'The specification of any rate conversion which needs to be applied to the observed rate before being used in any calculations. The two common conversions are for securities quoted on a bank discount basis which will need to be converted to either a Money Market Yield or Bond Equivalent Yield. See the Annex to the 2000 ISDA Definitions, Section 7.3. Certain General Definitions Relating to Floating Rate Options, paragraphs (g) and (h) for definitions of these terms.',
    capRateSchedule INT NOT NULL %DESCRIPTION 'The cap rate or cap rate schedule, if any, which applies to the floating rate. The cap rate (strike) is only required where the floating rate on a swap stream is capped at a certain level. A cap rate schedule is expressed as explicit cap rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The cap rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A cap rate of 5% would be represented as 0.05.',
    floorRateSchedule INT NOT NULL %DESCRIPTION 'The floor rate or floor rate schedule, if any, which applies to the floating rate. The floor rate (strike) is only required where the floating rate on a swap stream is floored at a certain strike level. A floor rate schedule is expressed as explicit floor rates and dates and the step dates may be subject to adjustment in accordance with any adjustments specified in calculationPeriodDatesAdjustments. The floor rate is assumed to be exclusive of any spread and is a per annum rate, expressed as a decimal. A floor rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_product_template.AmericanExercise (
    AmericanExercise_id INT UNIQUE NOT NULL,
    commencementDate VARCHAR(255) NOT NULL %DESCRIPTION 'The first day of the exercise period for an American style option.',
    expirationDate VARCHAR(255) NOT NULL %DESCRIPTION 'The last day within an exercise period for an American style option. For a European style option it is the only day within the exercise period.',
    relevantUnderlyingDate VARCHAR(255) %DESCRIPTION 'The effective date on the underlying product if the option is exercised.  For example, for a swaption it is the swap effective date, for an option on an FX spot or forward it is the value date for settlement, and in an extendible/cancelable provision it is the swap termination date, which is the date on which the termination is effective.''',
    earliestExerciseTime VARCHAR(255) %DESCRIPTION 'The earliest time at which notice of exercise can be given by the buyer to the seller (or seller''s agent) to, and including, the expiration date.',
    latestExerciseTime VARCHAR(255) %DESCRIPTION 'For a Bermuda or American style option, the latest time on an exercise business day (excluding the expiration date) within the exercise period that notice can be given by the buyer to the seller or seller''s agent. Notice of exercise given after this time will be deemed to have been given on the next exercise business day.',
    expirationTime VARCHAR(255) NOT NULL %DESCRIPTION 'The latest time for exercise on expirationDate.',
    expirationTimeType VARCHAR(255) %DESCRIPTION 'The time of day at which the equity option expires, for example the official closing time of the exchange.',
    multipleExercise VARCHAR(255) %DESCRIPTION 'As defined in the 2000 ISDA Definitions, Section 12.4. Multiple Exercise, the buyer of the option has the right to exercise all or less than all the unexercised notional amount of the underlying swap on one or more days in the exercise period, but on any such day may not exercise less than the minimum notional amount or more that the maximum notional amount, and if an integral multiple amount is specified, the notional amount exercised must be equal to, or be an integral multiple of, the integral multiple amount.',
    exerciseFeeSchedule VARCHAR(255) %DESCRIPTION 'The fees associated with an exercise date. The fees are conditional on the exercise occurring. The fees can be specified as actual currency amounts or as percentages of the notional amount being exercised.'
);

CREATE TABLE cdm_product_template.BasketConstituent_quantity (
    BasketConstituent_id INT NOT NULL,
    ReferenceWithMetaNonNegativeQuantitySchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.BasketConstituent_initialValuationPrice (
    BasketConstituent_id INT NOT NULL,
    ReferenceWithMetaPriceSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.BasketConstituent_interimValuationPrice (
    BasketConstituent_id INT NOT NULL,
    ReferenceWithMetaPriceSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.BasketConstituent_finalValuationPrice (
    BasketConstituent_id INT NOT NULL,
    ReferenceWithMetaPriceSchedule_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_template.BasketConstituent (
    BasketConstituent_id INT UNIQUE NOT NULL,
    quantity INT NOT NULL %DESCRIPTION 'Specifies a quantity schedule to be associated to an individual underlier that is a basket constituent. The multiple cardinality is aligned to the one of the PriceQuantity->quantity that this quantity is referencing.',
    initialValuationPrice INT NOT NULL %DESCRIPTION 'Specifies an initial price schedule to be associated to an individual underlier that is a basket constituent. The multiple cardinality is aligned to the one of the PriceQuantity->price that this price is referencing.',
    interimValuationPrice INT NOT NULL %DESCRIPTION 'Specifies an interim price schedule to be associated to an individual underlier that is a basket constituent. The multiple cardinality is aligned to the one of the PriceQuantity->price that this price is referencing.',
    finalValuationPrice INT NOT NULL %DESCRIPTION 'Specifies a final price schedule to be associated to an individual underlier that is a basket constituent. The multiple cardinality is aligned to the one of the PriceQuantity->price that this price is referencing.',
    contractualProduct VARCHAR(255) %DESCRIPTION 'Specifies the contractual product''s economic terms, product identifier, and product taxonomy.',
    index VARCHAR(255) %DESCRIPTION 'Identifies an index by referencing a product identifier.',
    loan VARCHAR(255) %DESCRIPTION 'Identifies a loan by referencing a product identifier and an optional set of attributes.',
    assetPool VARCHAR(255) %DESCRIPTION 'Identifies an asset pool product for defining pool of assets backing an asset backed security.',
    foreignExchange VARCHAR(255) %DESCRIPTION 'Defines a foreign exchange spot or forward transaction.',
    commodity VARCHAR(255) %DESCRIPTION 'Identifies a commodity by referencing a product identifier.',
    security VARCHAR(255) %DESCRIPTION 'Identifies a security by referencing a product identifier and a security type, plus an optional set of attributes.',
    basket VARCHAR(255) %DESCRIPTION 'Identifies a custom basket by referencing a product identifier and its constituents.'
);

CREATE TABLE cdm_product_template.Strike (
    Strike_id INT UNIQUE NOT NULL,
    strikeRate FLOAT NOT NULL %DESCRIPTION 'The rate for a cap or floor.',
    buyer VARCHAR(255) %DESCRIPTION 'The buyer of the option.',
    seller VARCHAR(255) %DESCRIPTION 'The party that has sold.'
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClauseVariant_counterparty (
    MasterAgreementClauseVariant_id INT NOT NULL,
    CounterpartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClauseVariant_otherParty (
    MasterAgreementClauseVariant_id INT NOT NULL,
    PartyRoleEnum_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClauseVariant_variableSet (
    MasterAgreementClauseVariant_id INT NOT NULL,
    MasterAgreementVariableSet_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_legaldocumentation_master.MasterAgreementClauseVariant (
    MasterAgreementClauseVariant_id INT UNIQUE NOT NULL,
    identifier VARCHAR(255) NOT NULL %DESCRIPTION 'Unique identifier for this variant',
    name VARCHAR(255) %DESCRIPTION 'Optional textual description of the variant.',
    counterparty INT NOT NULL %DESCRIPTION 'Optional counterparty role. This can be used where a clause needs to assign a different variant to the different parties on the agreement based upon their role i.e. Party A or Party B.',
    otherParty INT NOT NULL %DESCRIPTION 'Optional party. This can be used where a clause needs to assign different variants to different parties who may or may not be on the agreement.',
    variableSet INT NOT NULL %DESCRIPTION 'For some variants of some clauses additional details are required to work out what has been elected. This array can be used to define the name and value of these variables. Please refer to the agreement documentation for more details of the variables that are available for any clause.'
);

CREATE TABLE cdm_legaldocumentation_common.FieldWithMetaResourceTypeEnum (
    FieldWithMetaResourceTypeEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_template.StrikeSchedule (
    StrikeSchedule_id INT UNIQUE NOT NULL,
    buyer VARCHAR(255) %DESCRIPTION 'The buyer of the option.',
    seller VARCHAR(255) %DESCRIPTION 'The party that has sold.',
    price VARCHAR(255) %DESCRIPTION 'The initial rate. An initial rate of 5% would be represented as 0.05.'
);

CREATE TABLE cdm_legaldocumentation_common.ContractualDefinitionsEnum (
    ContractualDefinitionsEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.Exposure (
    Exposure_id INT UNIQUE NOT NULL,
    tradePortfolio VARCHAR(255) NOT NULL %DESCRIPTION 'Represents a Portfolio that describes all the positions held at a given time, in various states which can be either traded, settled, etc., with lineage information to the previous state.',
    aggregateValue VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the aggregate value of the portfolio in base currency.',
    calculationDateTime VARCHAR(255) %DESCRIPTION 'Indicates the date when the exposure is calculated if different from valuation date.',
    valuationDateTime VARCHAR(255) NOT NULL %DESCRIPTION 'Indicates the valuation date of the exposure underlying the calculation.'
);

CREATE TABLE cdm_observable_asset.QuoteBasisEnum (
    QuoteBasisEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.AffirmationStatusEnum (
    AffirmationStatusEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.DividendAmountTypeEnum (
    DividendAmountTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_party.PersonIdentifierTypeEnum (
    PersonIdentifierTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_math.QuantifierEnum (
    QuantifierEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.SettlementOrigin (
    SettlementOrigin_id INT UNIQUE NOT NULL,
    commodityPayout VARCHAR(255) %DESCRIPTION 'Represents a reference to an Commodity Payout.',
    creditDefaultPayout VARCHAR(255) %DESCRIPTION 'Represents a reference to a Credit Default Payout.',
    forwardPayout VARCHAR(255) %DESCRIPTION 'Represents a reference to a Forward Payout.',
    interestRatePayout VARCHAR(255) %DESCRIPTION 'Represents a reference to an Interest Rate Payout.',
    optionPayout VARCHAR(255) %DESCRIPTION 'Represents a reference to an Option Payout.',
    assetPayout VARCHAR(255) %DESCRIPTION 'Represents a reference to an Asset Payout.',
    settlementTerms VARCHAR(255) %DESCRIPTION 'Represents a reference to settlement terms, which may have been specified at execution.',
    performancePayout VARCHAR(255) %DESCRIPTION 'Represents a reference to a Performance Payout.',
    fixedPricePayout VARCHAR(255) %DESCRIPTION 'Represents a reference to a Fixed Price Payout'
);

CREATE TABLE cdm_base_datetime.FieldWithMetaTimeZone (
    FieldWithMetaTimeZone_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_event_common.TradePricingReport (
    TradePricingReport_id INT UNIQUE NOT NULL,
    trade VARCHAR(255) NOT NULL %DESCRIPTION 'Represents the cosensus based pricing parameters on a trade basis.',
    pricingTime VARCHAR(255) NOT NULL %DESCRIPTION 'The regional exchange close time for the underlying contract,including time zone, at which the trades should be priced. This provides an indication for which regional snapshot should be used for pricing primarily for Global markets where there are multiple regional close times.',
    discountingIndex VARCHAR(255) %DESCRIPTION 'It specifies the interest payable on collateral delivered under a CSA covering the trade.'
);

CREATE TABLE cdm_base_staticdata_party.TelephoneNumber (
    TelephoneNumber_id INT UNIQUE NOT NULL,
    telephoneNumberType VARCHAR(255) %DESCRIPTION 'The type of telephone number, e.g. work, mobile.',
    number VARCHAR(255) NOT NULL %DESCRIPTION 'The actual telephone number.'
);

CREATE TABLE cdm_legaldocumentation_common.OtherAgreementTerms (
    OtherAgreementTerms_id INT UNIQUE NOT NULL,
    isSpecified INT NOT NULL %DESCRIPTION 'The qualification of whether some other related agreement is specified (True) or not (False).',
    legalDocument VARCHAR(255) %DESCRIPTION 'The specification of this other agreement, when the qualification is True.'
);

CREATE TABLE cdm_product_template.ExerciseFeeSchedule (
    ExerciseFeeSchedule_id INT UNIQUE NOT NULL,
    notionalReference VARCHAR(255) NOT NULL %DESCRIPTION 'A pointer style reference to the associated notional schedule defined elsewhere in the document.',
    feeAmountSchedule VARCHAR(255) %DESCRIPTION 'The exercise fee amount schedule. The fees are expressed as currency amounts. The currency of the fee is assumed to be that of the notional schedule referenced.',
    feeRateSchedule VARCHAR(255) %DESCRIPTION 'The exercise free rate schedule. The fees are expressed as percentage rates of the notional being exercised. The currency of the fee is assumed to be that of the notional schedule referenced.',
    feePaymentDate VARCHAR(255) NOT NULL %DESCRIPTION 'The date on which exercise fee(s) will be paid. It is specified as a relative date.',
    payer VARCHAR(255) %DESCRIPTION 'Specifies the counterparty responsible for making the payments defined by this structure.  The party is one of the two principal parties to the transaction.',
    receiver VARCHAR(255) %DESCRIPTION 'Specifies the party that receives the payments corresponding to this structure.  The party is one of the two counterparties to the transaction.'
);

CREATE TABLE cdm_base_staticdata_party.LegalEntity_entityId (
    LegalEntity_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_party.LegalEntity (
    LegalEntity_id INT UNIQUE NOT NULL,
    entityId INT NOT NULL %DESCRIPTION 'A legal entity identifier (e.g. RED entity code).',
    name VARCHAR(255) NOT NULL %DESCRIPTION 'The legal entity name.'
);

CREATE TABLE cdm_regulation.DerivInstrmAttrbts (
    DerivInstrmAttrbts_id INT UNIQUE NOT NULL,
    xpryDt VARCHAR(255) NOT NULL,
    pricMltplr VARCHAR(255) NOT NULL,
    undrlygInstrm VARCHAR(255) NOT NULL,
    dlvryTp VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_datetime.PeriodExtendedEnum (
    PeriodExtendedEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_event_common.EventIntentEnum (
    EventIntentEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_observable_asset_metafields.ReferenceWithMetaFloatingRateOption (
    ReferenceWithMetaFloatingRateOption_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_event_workflow.MessageInformation_sentTo (
    MessageInformation_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.MessageInformation_copyTo (
    MessageInformation_id INT NOT NULL,
    FieldWithMetaString_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_workflow.MessageInformation (
    MessageInformation_id INT UNIQUE NOT NULL,
    messageId VARCHAR(255) NOT NULL %DESCRIPTION 'A unique identifier assigned to the message.',
    sentBy VARCHAR(255) %DESCRIPTION 'The identifier for the originator of a message instance.',
    sentTo INT NOT NULL %DESCRIPTION 'The identifier(s) for the recipient(s) of a message instance.',
    copyTo INT NOT NULL %DESCRIPTION 'A unique identifier (within the specified coding scheme) giving the details of some party to whom a copy of this message will be sent for reference.'
);

CREATE TABLE cdm_product_common_schedule.PayRelativeToEnum (
    PayRelativeToEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_asset.RollSourceCalendarEnum (
    RollSourceCalendarEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE com_rosetta_model_metafields.ReferenceWithMetaString (
    ReferenceWithMetaString_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_regulation.Swp (
    Swp_id INT UNIQUE NOT NULL,
    swpIn VARCHAR(255) NOT NULL,
    swpOut VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_base_math.ArithmeticOperationEnum (
    ArithmeticOperationEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_identifier.FieldWithMetaIdentifier (
    FieldWithMetaIdentifier_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_event_common.Confirmation_identifier (
    Confirmation_id INT NOT NULL,
    Identifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Confirmation_party (
    Confirmation_id INT NOT NULL,
    Party_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Confirmation_partyRole (
    Confirmation_id INT NOT NULL,
    PartyRole_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.Confirmation (
    Confirmation_id INT UNIQUE NOT NULL,
    identifier INT NOT NULL %DESCRIPTION 'The identifier(s) associated with the trade and resulting confirmation.',
    party INT NOT NULL %DESCRIPTION 'The parties associated with the trade.',
    partyRole INT NOT NULL %DESCRIPTION 'The role(s) that party(ies) may have in relation to the trade',
    lineage VARCHAR(255) %DESCRIPTION 'The lineage attribute provides a linkage to previous lifecycle events and associated data.',
    status VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_observable_asset.RelativePrice_bondEquityModel (
    RelativePrice_id INT NOT NULL,
    BondEquityModel_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_observable_asset.RelativePrice (
    RelativePrice_id INT UNIQUE NOT NULL,
    spread FLOAT NOT NULL %DESCRIPTION 'The spread to a benchmark.',
    bondEquityModel INT NOT NULL %DESCRIPTION 'Bond equity model for convertible bonds.'
);

CREATE TABLE cdm_legaldocumentation_master.NationalizationOrInsolvencyOrDelistingEventEnum (
    NationalizationOrInsolvencyOrDelistingEventEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_product_template.EarlyTerminationProvision (
    EarlyTerminationProvision_id INT UNIQUE NOT NULL,
    mandatoryEarlyTermination VARCHAR(255) %DESCRIPTION 'A mandatory early termination provision to terminate the swap at fair value.',
    mandatoryEarlyTerminationDateTenor VARCHAR(255) %DESCRIPTION 'Period after trade date of the mandatory early termination date.',
    optionalEarlyTermination VARCHAR(255) %DESCRIPTION 'An option for either or both parties to terminate the swap at fair value.',
    optionalEarlyTerminationParameters VARCHAR(255) %DESCRIPTION 'Definition of the first early termination date and the frequency of the termination dates subsequent to that. American exercise is defined by having a frequency of one day.'
);

CREATE TABLE cdm_legaldocumentation_common.ContractualTermsSupplement (
    ContractualTermsSupplement_id INT UNIQUE NOT NULL,
    contractualTermsSupplementType VARCHAR(255) NOT NULL %DESCRIPTION 'Identifies the form of applicable contractual supplement.',
    publicationDate VARCHAR(255) %DESCRIPTION 'Specifies the publication date of the applicable version of the contractual supplement.'
);

CREATE TABLE cdm_product_asset.RateSpecification (
    RateSpecification_id INT UNIQUE NOT NULL,
    fixedRate VARCHAR(255) %DESCRIPTION 'The fixed rate or fixed rate specification expressed as explicit fixed rates and dates.',
    floatingRate VARCHAR(255) %DESCRIPTION 'The floating interest rate specification, which includes the definition of the floating rate index. the tenor, the initial value, and, when applicable, the spread, the rounding convention, the averaging method and the negative interest rate treatment.',
    inflationRate VARCHAR(255) %DESCRIPTION 'An inflation rate calculation definition.'
);

CREATE TABLE cdm_regulation.Othr (
    Othr_id INT UNIQUE NOT NULL,
    finInstrmGnlAttrbts VARCHAR(255) NOT NULL,
    derivInstrmAttrbts VARCHAR(255) NOT NULL,
    id VARCHAR(255) NOT NULL,
    schmeNm VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_regulation.Qty (
    Qty_id INT UNIQUE NOT NULL,
    unit VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_product_asset.DividendDateReferenceEnum (
    DividendDateReferenceEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_staticdata_asset_common.Equity (
    Equity_id INT UNIQUE NOT NULL,
    productIdentifier VARCHAR(255)
);

CREATE TABLE cdm_product_common_settlement.CumulationFeature (
    CumulationFeature_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Index_productTaxonomy (
    Index_id INT NOT NULL,
    ProductTaxonomy_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Index_productIdentifier (
    Index_id INT NOT NULL,
    ReferenceWithMetaProductIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_base_staticdata_asset_common.Index (
    Index_id INT UNIQUE NOT NULL,
    productTaxonomy INT NOT NULL %DESCRIPTION 'Specifies the product taxonomy, which is composed of a taxonomy value and a taxonomy source.',
    productIdentifier INT NOT NULL %DESCRIPTION 'Comprises an identifier and a source. The associated metadata key denotes the ability to associate a hash value to the ProductIdentifier instantiations for the purpose of model cross-referencing, in support of functionality such as the event effect and the lineage.'
);

CREATE TABLE cdm_event_common.ExerciseInstruction_replacementTradeIdentifier (
    ExerciseInstruction_id INT NOT NULL,
    TradeIdentifier_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_event_common.ExerciseInstruction (
    ExerciseInstruction_id INT UNIQUE NOT NULL,
    exerciseQuantity VARCHAR(255) NOT NULL %DESCRIPTION 'Contains instructions for exercising the option including a quantity change, and optionally a transfer.',
    exerciseOption VARCHAR(255) %DESCRIPTION 'Specifies the Option Payout being exercised on the trade.',
    exerciseDate VARCHAR(255) %DESCRIPTION 'Specifies the date on which an option contained within the financial product would be exercised. The date may be omitted if the contractual product allows for only a single date of exercise (European exercise).',
    exerciseTime VARCHAR(255) %DESCRIPTION 'Specifies the time at which an option contained within the financial product woulld be exercised. The time may be omitted if the contractual product allows for only a single time of exercise (European exercise). ',
    replacementTradeIdentifier INT NOT NULL %DESCRIPTION 'Specifies the trade identifier to apply to the replacement trade for physical exercise.'
);

CREATE TABLE cdm_product_common_settlement.PricingDates_specifiedDates (
    PricingDates_id INT NOT NULL,
    AdjustableDates_id INT UNIQUE NOT NULL
);

CREATE TABLE cdm_product_common_settlement.PricingDates (
    PricingDates_id INT UNIQUE NOT NULL,
    specifiedDates INT NOT NULL %DESCRIPTION 'Defines specified dates on which the price will be determined.',
    parametricDates VARCHAR(255) %DESCRIPTION 'Defines rules for the dates on which the price will be determined.'
);

CREATE TABLE cdm_base_datetime.PeriodBound (
    PeriodBound_id INT UNIQUE NOT NULL,
    period VARCHAR(255) NOT NULL %DESCRIPTION 'Specifies the period is to be used as the bound, e.g. 5Y.',
    inclusive INT NOT NULL %DESCRIPTION 'Specifies whether the period bound is inclusive, e.g. for a lower bound, false would indicate greater than, whereas true would indicate greater than or equal to.'
);

CREATE TABLE cdm_product_asset.FieldWithMetaSettledEntityMatrixSourceEnum (
    FieldWithMetaSettledEntityMatrixSourceEnum_id INT UNIQUE NOT NULL,
    value VARCHAR(255),
    meta VARCHAR(255)
);

CREATE TABLE cdm_product_common_schedule_metafields.ReferenceWithMetaPaymentDates (
    ReferenceWithMetaPaymentDates_id INT UNIQUE NOT NULL,
    globalReference VARCHAR(255),
    externalReference VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE cdm_product_asset.LoadTypeEnum (
    LoadTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


CREATE TABLE cdm_base_datetime.AdjustedRelativeDateOffset (
    AdjustedRelativeDateOffset_id INT UNIQUE NOT NULL,
    relativeDateAdjustments VARCHAR(255) %DESCRIPTION 'The business day convention and financial business centers used for adjusting the relative date if it would otherwise fall on a day that is not a business date in the specified business centers.',
    businessDayConvention VARCHAR(255) %DESCRIPTION 'The convention for adjusting a date if it would otherwise fall on a day that is not a business day, as specified by an ISDA convention (e.g. Following, Precedent).',
    businessCenters VARCHAR(255),
    businessCentersReference VARCHAR(255) %DESCRIPTION 'A pointer style reference to a set of financial business centers defined elsewhere in the document. This set of business centers is used to determine whether a particular day is a business day or not.',
    dateRelativeTo VARCHAR(255) %DESCRIPTION 'Specifies the anchor as an href attribute. The href attribute value is a pointer style reference to the element or component elsewhere in the document where the anchor date is defined.',
    adjustedDate VARCHAR(255) %DESCRIPTION 'The date once the adjustment has been performed. (Note that this date may change if the business center holidays change).',
    dayType VARCHAR(255) %DESCRIPTION 'In the case of an offset specified as a number of days, this element defines whether consideration is given as to whether a day is a good business day or not. If a day type of business days is specified then non-business days are ignored when calculating the offset. The financial business centers to use for determination of business days are implied by the context in which this element is used. This element must only be included when the offset is specified as a number of days. If the offset is zero days then the dayType element should not be included.',
    periodMultiplier INT %DESCRIPTION 'A time period multiplier, e.g. 1, 2 or 3 etc. A negative value can be used when specifying an offset relative to another date, e.g. -2 days.',
    period VARCHAR(255) %DESCRIPTION 'A time period, e.g. a day, week, month or year of the stream. If the periodMultiplier value is 0 (zero) then period must contain the value D (day).'
);

CREATE TABLE cdm_product_asset.DividendPayoutRatio (
    DividendPayoutRatio_id INT UNIQUE NOT NULL,
    totalRatio FLOAT NOT NULL %DESCRIPTION 'Specifies the total actual dividend payout ratio associated with the equity underlier. A ratio of 90% should be expressed at 0.90.',
    cashRatio FLOAT %DESCRIPTION 'Specifies the cash actual dividend payout ratio associated with the equity underlier. A ratio of 90% should be expressed at 0.90.',
    nonCashRatio FLOAT %DESCRIPTION 'Specifies the non cash actual dividend payout ratio associated with the equity underlier. A ratio of 90% should be expressed at 0.90.',
    basketConstituent VARCHAR(255) %DESCRIPTION 'In the case of a basket underlier, specifies to which component of the basket this particular set of dividend payout ratios correspond.'
);

CREATE TABLE cdm_product_asset.FloatingAmountProvisions (
    FloatingAmountProvisions_id INT UNIQUE NOT NULL,
    wacCapInterestProvision INT %DESCRIPTION 'As specified by the ISDA Supplement for use with trades on mortgage-backed securities, ''WAC Cap'' means a weighted average coupon or weighted average rate cap provision (however defined in the Underlying Instruments) of the Underlying Instruments that limits, increases or decreases the interest rate or interest entitlement, as set out in the Underlying Instruments on the Effective Date without regard to any subsequent amendment The presence of the element with value set to ''true'' signifies that the provision is applicable. From a usage standpoint, this provision is typically applicable in the case of CMBS and not applicable in case of RMBS trades.',
    stepUpProvision INT %DESCRIPTION 'As specified by the ISDA Standard Terms Supplement for use with trades on mortgage-backed securities. The presence of the element with value set to ''true'' signifies that the provision is applicable. If applicable, the applicable step-up terms are specified as part of that ISDA Standard Terms Supplement. From a usage standpoint, this provision is typically applicable in the case of RMBS and not applicable in case of CMBS trades.'
);

CREATE TABLE cdm_regulation.Term (
    Term_id INT UNIQUE NOT NULL,
    unit VARCHAR(255) NOT NULL,
    val VARCHAR(255) NOT NULL
);

CREATE TABLE cdm_observable_common.TimeTypeEnum (
    TimeTypeEnum VARCHAR(255) UNIQUE NOT NULL,
    Description VARCHAR(max)
);


