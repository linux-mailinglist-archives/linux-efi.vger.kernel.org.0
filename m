Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7497F703E50
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbjEOUOu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbjEOUOo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 16:14:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB111558;
        Mon, 15 May 2023 13:14:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsDiE004418;
        Mon, 15 May 2023 20:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Z+jvB1l/Dfys8EkQgWpuh9a3Mj0fYPR4k6PevxC8uu8=;
 b=ZV+waKZugR9BmTONuo1vnW0bOBpCDR+/HxVDhsSBuVe8Llmh60p7pdk6FU4tdQy5fKx8
 H5I8TcHQk3orOfONHlx3ujrl8kuPmIUWaZl6OmmjASWZl1BfW67W2d45JvzMZFg1mLs+
 GpgRA38wT1H7+BVAiqy/zlzOIyqNVkKITXHxaKnH/M8N1/9/I5o6VMxCuepeSsQ8XCue
 lo+j/wvkcFroO8UeWaCJdgYedHMTIsyKaQo+YuIzzR3PFRFV/ouf1WzPQT8cvVOjhM1U
 w2oBD/SLpCoUnRgPHAC1f3zDZ11RfQDnTwxyh8uWJ/7XKi+a8TzKZpQMkoevsyNcCoVF oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3s9mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:13:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FIXLCH038953;
        Mon, 15 May 2023 20:13:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1095jg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDm6VMaEDWi6KlOXIwAaCyGjR4+Qi1yHcmoZe8RhOf3xRGWjLRlDGVz++J3qU/Sxoek6FBaT0Q01tAYl0rFfeKCKdAeUlbn65LFQcsnHjlknf8EilXr3vcvENLG9zE8WnACFNegzJ/M67RWV55SABNtC8+A1vjttFSCBwb14+qYEioDjFC7iquGym3TFEtqBVPROkVsYSJFEkvNtmU8RWfaEhfxVW4BefllArltKTu7VfEx1TaEZN8anKwSAk4PoJiScIpggZA/9HF3iRb6+9rW9+6pVKN3VmjOKnpq0oqmx5vjiF/ciG7duVOlzpJX0nEuQzaHo9BaIdPVV9fL8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+jvB1l/Dfys8EkQgWpuh9a3Mj0fYPR4k6PevxC8uu8=;
 b=NWOBKrv7sWr9d5YoY2Ech1TV14zw3LaCh9iLHp9aLWwUGcygKGm2UDPUaNAvYQLZiH1+10+rh0FZtpsO0Gb1IO7tlKxUae6HcDsLLK7mCxPzVq0OPZFHhG7QrQV9SbRqjt9lkBpb5s9+mRyNpniXDvjfBf483lfFDWPnlOLbXca0Y2VF+OfvkyQsCLDF257kxrlhCmI8M0pvJmWtQsGn1D8wNmtkb8nqCJnP8/dpTUm1L/ehUeQkHtEmrJJxHMG2em2oAieQQh7s8SWknHLB46rjWgdj0278DG/JrqBb7qbKhF8TvlxhtAbwyh6qLej8L9v7BjlYpZT0KjDTo8jKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+jvB1l/Dfys8EkQgWpuh9a3Mj0fYPR4k6PevxC8uu8=;
 b=F6PNetnWmvf4GINrygww3vx9AwAJoNRYkqqGYsQnQACB4CiWCPV/qvYN7seAeEpEFldewPUeKoUzsAuRqe5P6k3P5noHwzpsoI44Nvq7Tpbm0wGTNAU1S3aqtiL7piG8iEw5swKE0YW+3lVEs9IVivt6P8q8KFDz6E5A/NgbhYo=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:13:35 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:13:35 +0000
Message-ID: <d0f4704a-8050-9274-e4ac-b2b3157cf482@oracle.com>
Date:   Mon, 15 May 2023 16:13:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com> <87ednlbf50.ffs@tglx>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <87ednlbf50.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:610:75::32) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c26605-e3a9-4d41-5e0a-08db5580dce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJK4ESw0+nbyjeifQttlXrsc4aUBc5Q02aj2LyOvYQyuMHx9ea3xCCUrlf456EeFSjk6E3cFaPTH7ZBWmXH9RMeY3p51HckWasKnRbYGc5FOn1DcVd9mGcNdBfpsz8Ecg50Scx+WZ5H8/L9nhNaE50fkeVygzfUwgBCoCe5nB1IkGGf/ETrul2qhgEirHVs2d9mDOzQTpBklPF0p2Dn5/snD5j8MLqV/Wj8yhuHg9IASVxEFK8O/VkcTYgoiADYqmj/I/CW9jEPMYQw+GCCnBYDOckGdbskJNrNA1wGyO83HVfSRIizKFqMLF4NqIza4g3umAS1roSiLfsh8GfQgO8R8zykInH5lvdVdlNUcZaLYtxfoKVcxhecELsT7iVz3iXZslFJ0rjSMHOVqylgRqqsIaTWgdstjPCK45c2IyO9D3oozz7hMB/l87VkhyJ0nxMlo7BdtkXbYicZoAkZrr3gcdsIiEUoi7NGq0Odn7AS8WGRGbz1WAWZ7HnJhFFRtKM++lqGNLuoQdXwtFdy9hwkG0wxj+Z4dvnupYXJ1dJLHUDspe6IFOxgkfZRQWfXHPOdFlYbUO+NOBIaJKVU1DD3WMS40YBLDLbw17170Lf9WRRoY1Aq/Wu5p3TBiVpTyceZXdphQ/lCL0B4sYLWgdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(31686004)(66556008)(66476007)(4326008)(478600001)(66946007)(6506007)(53546011)(186003)(6512007)(38100700002)(83380400001)(2616005)(36756003)(8936002)(8676002)(2906002)(6666004)(316002)(6486002)(44832011)(31696002)(86362001)(5660300002)(41300700001)(7416002)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pldlExZ2pLUmdOSzg2L2Q1b25pdnlQbDUvOXdjSHNnYmJhckNESldDMU43?=
 =?utf-8?B?dDdMTzdqR05TSUE0cDhubnBtbEFLNzdsQ1F3M3NiNENRc3ZrZjBMdTRJMnlH?=
 =?utf-8?B?dEpGVkJSSGVrQ1BDcE05ZTUvT21vQzVyRkwvTnBSamZ3OTZzemg3c0s3aXpn?=
 =?utf-8?B?anNLQnAvSWwwUGNMbkh3RjlZeTF1djZCelVEYXkzVXZCZThHRkdTcU1YRExt?=
 =?utf-8?B?ZHdQQXhBNGZqSE5NVE1mZ0dEWDhMcVFORlE4R25kS21KYktCVHpiazVNZGp2?=
 =?utf-8?B?T0padFFtZ3JxYk1Id3VmbDM2RFA3a21rNWMwR3l4K2NEMFdpVGFST1dCWkt6?=
 =?utf-8?B?Q1k4MHliYVVuYXI4ejc3Nkl6NG1CckVvR0RzZEVaUGgzbWg0VTE2WDBBV3A3?=
 =?utf-8?B?cmR6L0RsUWZvcytFeFBIWmtlajBScGZVQU9XVDVtYTlxYWhXR2kzV0FIaDM1?=
 =?utf-8?B?eUsrUXZkdVFNMGJDOWxxSGNJT3F1VnlUelJNNUhuRmU5a0R6V0dJL24wWXFG?=
 =?utf-8?B?bWtyZFREbWVIWVBld2xJWWR0QVh2U2pRSnpNa2poVXBIV3BVa1pCTlhXR1VO?=
 =?utf-8?B?NTZqR1BLYVhSR013TnpEUFRhSGswUi9lR2Y4ZVE4WVBXRmwvaWRZTkdWUSt5?=
 =?utf-8?B?UHEyRTMvMHJoaDlsdUVGc3UwbzNydGdIL0tPNkVvcVdNblpXOU15d3lwcUU4?=
 =?utf-8?B?dnorNWpDQ1ZrbjBJRkt3dDNBZDhETDZ5aVRiRFFUZGdkNVJsOEcyUFZCR3o2?=
 =?utf-8?B?amZmVkpaOHlRbjVpMWRveUpxaUhLRTRBeTZMV3BPUHRvOEJuRnNYQjY4M2xK?=
 =?utf-8?B?STBRNCtJMHNWUWZmTXdEeHd3QTFESTZoZDVKVzI0N3dhcUtvNjZEeVBFNDdG?=
 =?utf-8?B?N2I5SkRjMzhyQXcxdkR3RGt6RWF6ZTV0a1ZHaDBJYk1ZRjA1U09Idjk0MHpG?=
 =?utf-8?B?cW4yMnYrWWRMYjMwRk8wdXk0eWRObi9TMXViM25pMzNBMkprdlJnL3RUZ3RJ?=
 =?utf-8?B?U2RFK2p1Q3JjVXkzUlQyS1VQVUpsZkQvZXl2WjJ0eEdOR0IyV3FiM3ducTdW?=
 =?utf-8?B?YXNVMGxNQ2FZVU1IODJqMU1maTdSTXcySllIaUdHTWI1UVFtYWNUWDZTL0pJ?=
 =?utf-8?B?WlZXcWFFWER2Znd3NTBNRUpSeGpCcTJ6RmhlU1hHaXpncDl5Mkp5OFRGRXNX?=
 =?utf-8?B?SWtJc1cvcEtocmJQUGpSN0RVSnlrZk4rcjJWdnN0NmowOHd3U2pCcjVzcTlX?=
 =?utf-8?B?WmRCdEFsRisvcno1V2ZCYllINXZNaWt6TTJqSzNTV0pacHludEg4Sys1dHMz?=
 =?utf-8?B?bE13UzNucFkrUlEzV014N251SmhyU29ZTFgvKzZpaGo0T205WE9qOVBQY1R4?=
 =?utf-8?B?YlF2dktNOTdVb2VNeWZuU2ZUTTFsS1FIalN2blY0OS9Zdi85SzFuZTBUQWVI?=
 =?utf-8?B?Nzh5Yit5Mk9vaTR2cThuOStWN0dRVG1xbjFCZUkwTFJUMlFRZEloTWpQR3N4?=
 =?utf-8?B?d0JRQ1A5eElsVit1ckIzdFk3Tk9lK0k5ZmdzU1IreEVEZ05IRXVwZ29DKzUy?=
 =?utf-8?B?ZEJHVTJZMlQ3L2hEa0ZHUWgrNnJ1WkVrWFgycUJaMXZvbHhodzVrc2g2cFlZ?=
 =?utf-8?B?d3RESFc4c1FSeWVMVmlJVGNkTWtQL2U0M2Y3Q0ZlWTVKUXdJVEx0QmxNVHJR?=
 =?utf-8?B?MzN0QVFXS3dhL3JSWkExWUNoc252UmF0TkJWeTRVbCsyRk5OWVcwMmpLRVBE?=
 =?utf-8?B?NXFqWHVqUFlpblJIMU5TcG5GSkxxNTd0KzEyY2xRL0UydnQvZEdrbnpSeUI0?=
 =?utf-8?B?WWZ0aFJ3clo4dnl4S1dlSGE3N1Z2L1VJcmVuWVJqRDNLNzV3RnFxYUlvV0hq?=
 =?utf-8?B?eXd4aklxbFRINm9zR0NjaE53ZmcrUmFLdW5jdHA4VlhQdVBhbVVWZ25MbG9z?=
 =?utf-8?B?aWlCTWpxT2V1OFROUGFvMEdmOGlwOGFrMXpsdUM0bkw5Qm41NEIrcVdBTytk?=
 =?utf-8?B?bWZDM2JLZENoWk00YTEzZTRRaGZYMit1Mm0xbmY0VWpsYXFMWkkvVlNqQlNM?=
 =?utf-8?B?c20vWXlMZlZKYXZFcmhBd0VjRk1JTStBaFJNTEQwelY5a1BLaVoza2VrMVdj?=
 =?utf-8?B?dC9hOGZHcjRFUWVwa1A5eXJuL2M3ckRlTFcvNjg2b3hQVkhPc2ZpTEhEN0pa?=
 =?utf-8?Q?oY2bWTLl+W68M4Ktglv4WnA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UmRlNEtPNkJicUo0VWFCUUFRL1UybmlwSUhMNlhHa2V1L0c3bjdVY1Z0cE1z?=
 =?utf-8?B?L1JoYTd1bVhtNmVHaGFqT3RQWnAxdzZqU3JOT3pUSTJZdjQ3ZWxJTFhmQ05a?=
 =?utf-8?B?VVJtdTJOOFZmTGVkWXQrU2RieUFTbUxTWDhaUVZJQzYzYjJkNG1Nc3V6cHEr?=
 =?utf-8?B?Y3NBcUxUaks5bjB2ZERsOXFicCtMY01LaDNxdzVOdlUxa1RqcG1UWlU1TFA0?=
 =?utf-8?B?OUI5aUEyY2o4SWI1K0M5d2RBQ2tJVkQ5djdkNktjdHpSZmZhNStKWVlMN1RR?=
 =?utf-8?B?bWxibk1qdUpmd1ZueEhxejgwTGFiL3JqZjRKeHlRRm9QTEZBYlF0eWVKVFZI?=
 =?utf-8?B?UW5oR1VXZ09kOHlnNXdvM3UvT0ZCRXdjODdjV1h2T3FBSG82eEpmNkN3dzF2?=
 =?utf-8?B?N3VFSmZxdHREM205eDY0SFFmQjlBZisrbjhycFN5VmR6aE1WTUdmL0xYSXJJ?=
 =?utf-8?B?bU43aXNiUUhWS0hLVzV3LzNadVVrN0JDUjN1RC9nalJzSVozdEtSVGgxdmU0?=
 =?utf-8?B?MUtyUStJNUd3SnFLd1ZiZTJYOTh1RG1GVDlkdUR1cTMxTGJ5K0N6Q2V0bmEx?=
 =?utf-8?B?ZTk5MFJwdGk5dFhFSEpXOUFicVN4dytwUVQ3VVpWUExYLzFwQ2w2TWVPRkVU?=
 =?utf-8?B?ZG1TRVhqRTZOU0ZOMzYwbktvVjhnaldkTnBoMkg5Y28rb1IrQjZPNlZFdkRN?=
 =?utf-8?B?L1ZjNFgzMlpOUWQ0emxyWkViS0tKd2R2bW5HTW1Jcms0blhGU3JsZDI4eVQw?=
 =?utf-8?B?SUdnMkdZOXFmVEhpdTJMa0ppVVE5UnZhSGhHdTJpZ3hFdkIveERMcXd0SFVP?=
 =?utf-8?B?MURVOTNJRWlXTGoxY0Q4bnBLUGZmbGlnZ1hQUkdTL3pGTmxtcFBsTmxDdFBw?=
 =?utf-8?B?WUJTU0cwMS9OdnM0cVRhblM5bks2RTF6NmRpZXVGM0FDTFlvU0VQcUdMTENE?=
 =?utf-8?B?TzdLdHFNTUF5Q0M0ZlNzM1Q5bXdNcmlZOHNRSkkzOUpma3BYU1lUcnB0R09h?=
 =?utf-8?B?Uk8wc3RmaUE0aEFPR2lXM09UcDFUYWkrRGJjZDYzU24xVHhPem1YZWFRMUpY?=
 =?utf-8?B?elN5eGV4ZStGMDVPSlFkTjFpZG9iT0ZGSFQ0Q1M5K1VnZUNjUnU0SHR4YUhr?=
 =?utf-8?B?WkVDcXhnSlNJbngrVEx5bkYrTVFCd1BmWEdJMFhUUXhzWlc1RGVwQmtDOWZL?=
 =?utf-8?B?WnZMa0kwMjhSUjBicWs4bFJ5TXJ1MmYwVHIxK1ViUUxNWG1iSmwxaU9lQ014?=
 =?utf-8?B?WldOTmFjVktjbGJzUndHZEFwNjRQMkh4bC9TVVdib0I3Vk1VNnBXY1FzTUhR?=
 =?utf-8?B?OFVTYzNKaEdsWVhBd1dnLzN2dHZrekM5WGNiK0hNU0FMVllxN28rM2lhTkhS?=
 =?utf-8?B?RHhWNkQ5TGhCVzYxN1RGNE9rM0NOaUdzdGtyS0N4UnVSVlk5ckhNWE9idTBH?=
 =?utf-8?B?N2Zsbnc0cW81M0NTN0VQbmJrUStaK3ZTL3dKWENYODFIblR0NWR2Y0xINEgv?=
 =?utf-8?B?WUJlWmp5a0dDN0t1SjNUa0xmNHorNE5qaHNXQXZWVjB6ZlVuelFyS04rOW8x?=
 =?utf-8?B?MkdtY05FUkF5TldJc2dMbU1uVE42eDZJUW5yc1FabWQrZ1lFdERqVkpuazR4?=
 =?utf-8?B?S1ZIS0pNQ0RMamQzVnZBei85T1d0TWhRd0F1R0wxMXRQWFJvaXFEN2JHRmh0?=
 =?utf-8?B?eG9ZenAyRzRsTFFRYjVZaE52MFFtQXl6VnZ2OWl1akZuUlBGc2h1aUtXMHRm?=
 =?utf-8?Q?K2Oaoew1JfIVvdU9as=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c26605-e3a9-4d41-5e0a-08db5580dce3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:13:35.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAs/koux0cdzSpvXR6GXkIwbcjd7hWp6OqR95cLUaI/mNdkxgFRkZXRALJhXUUSZc/NlmQ7ze5g1cpU0ZVBmJsBYF9LQ6hU5JecRYMmmOHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150167
X-Proofpoint-GUID: hA06V3dh-hsqXALNJYPJmuu82NBrvjAA
X-Proofpoint-ORIG-GUID: hA06V3dh-hsqXALNJYPJmuu82NBrvjAA
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 14:04, Thomas Gleixner wrote:
> 
> On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
>> +
>> +/* CPUID: leaf 1, ECX, SMX feature bit */
>> +#define X86_FEATURE_BIT_SMX	(1 << 6)
>> +
>> +/* Can't include apiddef.h in asm */
> 
> Why not? All it needs is a #ifndef __ASSEMBLY__ guard around the C parts.

I guess I was reluctant to fiddle with another header file but I can do 
this.

> 
>> +#define XAPIC_ENABLE	(1 << 11)
>> +#define X2APIC_ENABLE	(1 << 10)
>> +
>> +/* Can't include traps.h in asm */
> 
> NMI_VECTOR is defined in irq_vectors.h which just has a include
> <linux/threads.h> for no real good reason.

Ack

> 
>> +#define X86_TRAP_NMI	2
> 
> <SNIP>
> 
>> +/*
>> + * See the comment in head_64.S for detailed informatoin on what this macro
>> + * is used for.
>> + */
>> +#define rva(X) ((X) - sl_stub_entry)
> 
> I'm having a hard time to find that comment in head_64.S. At least it's
> not in this patch.

The is a macro very much like this one and large comment in head_64.S. I 
am just referencing that. If you would rather see that comment 
duplicated here, I can.

> 
>> +.Lsl_ap_cs:
>> +	/* Load the relocated AP IDT */
> [ 11 more citation lines. Click/Enter to show. ]
>> +	lidt	(sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
>> +
>> +	/* Fixup MTRRs and misc enable MSR on APs too */
>> +	call	sl_txt_load_regs
>> +
>> +	/* Enable SMI with GETSEC[SMCTRL] */
>> +	GETSEC $(SMX_X86_GETSEC_SMCTRL)
>> +
>> +	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
>> +	leal	rva(.Lnmi_enabled_ap)(%ebx), %eax
>> +	pushfl
>> +	pushl	$(__SL32_CS)
>> +	pushl	%eax
>> +	iret
> 
> So from here on any NMI which hits the AP before it can reach the wait
> loop will corrupt EDX...
> 
>> +/* This is the beginning of the relocated AP wake code block */
>> +	.global sl_txt_ap_wake_begin
> [ 10 more citation lines. Click/Enter to show. ]
>> +sl_txt_ap_wake_begin:
>> +
>> +	/*
>> +	 * Wait for NMI IPI in the relocated AP wake block which was provided
>> +	 * and protected in the memory map by the prelaunch code. Leave all
>> +	 * other interrupts masked since we do not expect anything but an NMI.
>> +	 */
>> +	xorl	%edx, %edx
>> +
>> +1:
>> +	hlt
>> +	testl	%edx, %edx
>> +	jz	1b
> 
> This really makes me nervous. A stray NMI and the AP starts going.
> 
> Can't this NMI just bring the AP out of HLT w/o changing any state and
> the AP evaluates a memory location which indicates whether it should
> start up or not.

Given you comments on patch 09, perhaps all this NMI business becomes 
obsolete.

> 
>> +	/*
>> +	 * This is the long absolute jump to the 32b Secure Launch protected
>> +	 * mode stub code in the rmpiggy. The jump address will be fixed in
> 
> Providing an actual name for the stub might spare to rummage through
> code to figure out where this is supposed to jump to.

That can be done.

> 
>> +	 * the SMP boot code when the first AP is brought up. This whole area
>> +	 * is provided and protected in the memory map by the prelaunch code.
> [ 2 more citation lines. Click/Enter to show. ]
>> +	 */
>> +	.byte	0xea
>> +sl_ap_jmp_offset:
>> +	.long	0x00000000
>> +	.word	__SL32_CS
> 
> Thanks,
> 
> 	tglx

Thanks
Ross
