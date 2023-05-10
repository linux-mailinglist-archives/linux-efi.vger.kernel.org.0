Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0C6FE1B7
	for <lists+linux-efi@lfdr.de>; Wed, 10 May 2023 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbjEJPmn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbjEJPmm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 11:42:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504594;
        Wed, 10 May 2023 08:42:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ADxZCa014394;
        Wed, 10 May 2023 15:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YpXn1eMOzwd57K4Jpxso1Ol4x+m/B6JVYLxXpwagRvY=;
 b=goxotIj554jhfFAu4VVCuM0vfctRhk+5m7ZboJE1+Whce/lkwuwheQmlXd3Wk8+Av3Ov
 9mOYxOyCbq/w2fGkCXcfacpbsRLIajV8wYNzDrpfC2BO0+PJYg+LemDn7baeMscZo7IM
 xm3z3ZJ7CyhynKbSdQd4Xd3JUyu37ZuDxFJwz+weqZ7jnaJkBiLAwi7LrHtkgvNZ1hXp
 jW3yeA8bMNuezit9YOaatoYVu384c9PZz88dI5NUFS1kUgLRWPOeIF4dbABAC+Tsqqcn
 kIX6AMp+QDwco7+wdXEkV7QNauaigGa9Vh02bM6j8XouQ8cjF+wXtUZrBprRksaEBfk6 Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dcyw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 15:41:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34AEwgoA018212;
        Wed, 10 May 2023 15:41:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77hj6hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 15:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwyKAnOx9dYdIBzEw8kDw4cv5U3mxShlGMzxIK/M336OmvI4qvunw4zv5uRdSPeC6hfCXwkKRxbVhZpUOXehL32pLGYMhGn4sy8E+vd8nx7gkbs2NbbuGCP5c9HHWTMRVw4SGeCC2wTW37dJf6YHW+7fO73Q3++HfGlSyqfuo3r39Cn8rPt7g5fO7rTL0GT4Fi6r6uJfoC+XmXDxzBlGnPUEQETgobyGkme3eMw660cLts4zo4zMzRexu/WCHeHxw0Usjq3wYabAUWafTWG6yBzzlxwMJ84B8RF6+ZBxlI79rHDLyOlk2oO5AHyjKa2vKRK0IpMme7SzgCJVc2wDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpXn1eMOzwd57K4Jpxso1Ol4x+m/B6JVYLxXpwagRvY=;
 b=mKX1TpN/+J4IjYyAd1CP9mJ4kotSnllvd1jj9cUg4Iq/lwbV8w0XimABdafC6FprQ922Gdx2dj7o+1yxn1gPFeRkNkp1YEBZk1+nChcWY1oswXJ47Pt4/RGSpTRcq52tXPSlwu4VH5fDiOhUkpNDws/Lhlq0sXxo+E6SnkouHOjb91N5WrNnQkjsgcdinHGlESoGD4K87NbwIpIDSffwuqVk2NjQF6/IVUMC7xzQkjpFxS8NlK3Psj/HaR2yuvmJpbkbG9ZT6RBtJvYm9VlSDhfeyMQJCf6bnJfiPkI3uIiFCZQ9IBa+UVvDv+A4Djgc6Ij4KMSMKcGZCHsEUeDBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpXn1eMOzwd57K4Jpxso1Ol4x+m/B6JVYLxXpwagRvY=;
 b=G3+f/n/j19tbx0VePWC/x+IMPRqqidGMTgHO8lJ+TxSNLZYdJu2a9cbsc3vPg6+yMbVv/JGhwAucNLaeuy9FgylXkzrEQkW4pg329Jq1igNawPN3e8ZROApXUAf6octIGSNjlFMKo8JJc0e4WYurfyHDuh7aNkeRBkczEzBkTXo=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 15:41:42 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 15:41:42 +0000
Message-ID: <c27c25b9-3382-5438-33ef-e72811a7a2c9@oracle.com>
Date:   Wed, 10 May 2023 11:41:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <ZFYUaQ0KYJhkv2Y0@debian.me>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFYUaQ0KYJhkv2Y0@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|SJ0PR10MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 90514d8d-70f8-46a3-5096-08db516d0d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5G1xix8Y3T1TSjdNlbeQ170PvBWlb1ZfMsYYAFXE7UmxYtVprOGovgM6LGvXDfppExejMabF57smFQ73YtRHW5INGQ2BDOcbliRANZGwSgt+WXadU16iv4urhMCcFiVu9X5EFMpwfjgAOe2dI4PSPUGRdKNFdr1EpwOyW0a5ZyJM+z98rTkNGcGnoFP1FvwwjzzFHLI8JCD3kjcoWqmj0VmMSlMg1M/qE+f+0eW2teT+Q5erEOOrt/1Vx1AQGq/Y5qDXoVR/md3RDUtEYWnDSnDlVH6Qk5LQEQMJ82DiDl2FKF+mEkFOXjf7/8/SVAbIqT90/wlKzyGFk3j7+vRZ1/w++lxVkHDiQHo/FdyS6lPegesRjhEh4LCKW7RwLbVX/OoJp9dH3LOoA7bjjnpiwQ4NQ9FHD43XUJu2JZXNn1lz4uu+X2ycZBa3A5YarjIeEU6gkH7FmKdgVDO36fbEZhONSgh3aVkiFffSLKNOnnkH/xXtGZNj7duksbmW271nlH+V1sqptmOordV8eGsGrwmT5v5YatPujNiaPsnx15gcG5HeuJF6dimDqiaODhyXFTGSPHP1xj7iHJPlA8jABKSss8Lqye0cuILDx8lI1KCHkRM3bnG2NrzombT0zmyECQ1Q2LsXMGvn+/wCNpqU085rzk/+TTsaLgXJsx3NEnaAvStdsi+CVPrIWL0RuXtvW9EeLRXfmPP73R1mdTQvA+5NY0ZAH25YFpUuRz9EU1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(6666004)(66899021)(2616005)(7416002)(30864003)(2906002)(966005)(478600001)(36756003)(186003)(44832011)(6486002)(316002)(6506007)(41300700001)(6512007)(53546011)(83380400001)(38100700002)(31686004)(66556008)(66476007)(66946007)(31696002)(5660300002)(4326008)(86362001)(8676002)(8936002)(45980500001)(43620500001)(15398625002)(43740500002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNmekJlY1VrekdMQ05uQjNMbGo3OVNuYW9UODhaNFllUnhTS3dHRkZEU3M4?=
 =?utf-8?B?a3EyUkhlbU9jK09JbVZVZlg0MTEvSXVKUndTWXB4dWJwemUvTU56bHJhMTJX?=
 =?utf-8?B?bytWUTREQ0pLUm9qNTVNb01LYkxQOENIMzg5Z0Y1SnBWV0ZDem1nNmJXSExN?=
 =?utf-8?B?SDd2MmRvQkREblBDR05yWlp3Qzl5MDNEOFFydmZtMEduYjNYWnFFRWh0blB2?=
 =?utf-8?B?NVVwQ1BjZGFCRmc2MEZWK0kyRlVzZ0dFZzZ3SmpjNDQ2elFKMzNuWkZtVm03?=
 =?utf-8?B?SEhDaFhXS1g1T3VYWTBBZ0lMWFJRamVZNU5icjBvM1IrRDI1VEw4U2l3VTgx?=
 =?utf-8?B?L2l0Z2JWaFhidlJYOUFMUFdLd3FDdHZsN0ZXbDlPZTE4OFFmekVHZllNWW5N?=
 =?utf-8?B?MWFxMHBMaGdHT25DNU9EWlk1eUpYWXE5TTFreXBMbW1BMWFVQUFXNXRua2Fv?=
 =?utf-8?B?ZEZVSFZQdm1aSU1Xb2JGRTdqRnNEcVhCQ0s0N2NHRmw2Uk9JRFk2eVdvTjlo?=
 =?utf-8?B?UHFTeGRPdCtpNWZOVWVBS251bDVTOTdIZTRIRC9YRjQ5Q3JTZW1OelBDY283?=
 =?utf-8?B?VkIvd1JyM0lYWjdUNzBiUnUrSzhFVFRtaUNtZ3VKb2I0cGJtVFlnOHZBMXVV?=
 =?utf-8?B?Z3JWQXdwdE9ZZUxwUWpmMWxuWGJnS3EyV0JKMU1vRVB0Qlp5N2hadW41M0ZK?=
 =?utf-8?B?OXJKaHRRcXJrcnFPcHVOWmZRK2pMdWhBTDI4WlZEcWNlaXh5NEYwbHJUZE1l?=
 =?utf-8?B?enZyWUVUWk9SWkIyZi9VN0JCazh2dC95bHFXRm02SlBIc3RUbTM1Z0hhMEdk?=
 =?utf-8?B?VUhoZUx5VFZnMzhpZ2NscjFCZjBlTm1rbHVuUnEwUTVnN24vS3ZqblcxTUZM?=
 =?utf-8?B?S3h4NHBBRjhka1BvbExpNkt1YU1RR2VpRjh0R2lCZjBlZ3lSM3duakVFNml2?=
 =?utf-8?B?eXBwakdjRytYdUJKYllNZW9ZZldrdWFqTDJBRE1jd1c2c3Axam50MmdZcklq?=
 =?utf-8?B?NDlUSTJaVEpkbFlvSnp2N1BFNXR4YnZ2bW95ZjlJcllEcXVmcVlXUHFMM2V5?=
 =?utf-8?B?OUorQzFWeXFZQmhETDQ5OGZsMTVHdC9KN09TUUFNZXJUcHEweDRNMmxWSXlo?=
 =?utf-8?B?WnJPTUwwYm4rUFJ4bnZDcGNaR283bTBnV2s2VmV2a0N5UGs4d2UyeTV5aDNL?=
 =?utf-8?B?WGdqKzJuQTVvRjFlRndQVTBSQTAvUi9BZG5FQUVhdmdpZ1dKc2M0aTN5N3FJ?=
 =?utf-8?B?aWhucmRjbXdPR1IyaDlKNmRtdFY0MUl3bzVWeHVnREFWcm9GRXNuUGxxMDl0?=
 =?utf-8?B?d0RTbUQ5SmxYK1dSaXB1dElkY3BQYzlRdHF0QktOWW1xRWwzYk4rTVF3R256?=
 =?utf-8?B?ZUVYcHpzZTVJUGNJUURtL2U4cmFpcXFjN2kvL1NxMHRwU1hMZUIyVGRiQjds?=
 =?utf-8?B?SDhTbWszN0VRT1hheFhXdW5MWkgydFNJVWdHWXErQmh6MGZFT1orNWFMcFVI?=
 =?utf-8?B?UDB0cU5KSTdkMWowT2prVTJVVW5BSDRweTE2SXRJTCthQlgybVRtT2xtNXFL?=
 =?utf-8?B?QitVNUdyNmc5b2dYclp5bGhqanNTdGtuRFhmQkU3Qlg5S1BNdDdZcW8zTHZG?=
 =?utf-8?B?OE12NUluM2tNaUZ3TTFGQnJmM0ZmRHpEVzdocUFRNUdjTXR4bE42WitIMUNH?=
 =?utf-8?B?ZzV4TmxZbzZOVHhyUTF2bzZhMkdCYVlvWnlUOFdkcTdUWWNVdGltd3pLdWk2?=
 =?utf-8?B?NGxtZFMrS1QvMXhNTkRIV252VjY0TXpnSnFMZ2puT052TXBQV3lleGU2Sy9S?=
 =?utf-8?B?N2xrY2w1czA3N2kreGdnekRtVGErTHgzTjlDVmlsYlh0MGFwMWR5RStnbkNY?=
 =?utf-8?B?RVUwdjloNE0rekZOcCtxS2Zwd29jUTZ3ZEk1T09SOEVhckxWZHFiWk9reGVD?=
 =?utf-8?B?enlCZTNvNWNMcU1XekV4S3RyTjk2cXkwM3hGNVB3OXlUSjNKeGM0NFBUNkdm?=
 =?utf-8?B?TXN0NW0rRXBZTXo1N0R4ZDlyLzB4WGI4RDd0amZKWXJZamJUdTBsaCtIU3hx?=
 =?utf-8?B?NW5JdFljZWVaaU9YUDFETHlkd1lmS0I5eDJmWGh4bTZMN3VRekhmMGtpd0t0?=
 =?utf-8?B?SE9wb1VlQ2VIUmRxZ1NYQ3diUDRBK1RqVG1kU1M1T2VWdjBCTmovaDBnckZ1?=
 =?utf-8?Q?Iqk/fz+Y5A+cie7o3OWjOcc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dURyWFh5dS9COVlQYllWOGJ2bGt6UllrZXBJaG1xcmh2ZjdGdXd3NWYyTDFM?=
 =?utf-8?B?VkJFWWtPeWN0K3EyVDRBZDRlSkN1ekJNYkFCUkdMOHJjKzVqaHJndjNCanBP?=
 =?utf-8?B?RE05RXpLSFBGQlRHd0JrTlhhbUR3OE9vSndqbTFRQlgySDFONUNNR29WeWds?=
 =?utf-8?B?QUEzUjl2RkdWWk55MGpTZHpCTXZPMXNZQmxJQWpMZFlxTU5NdGxqYTIycWVx?=
 =?utf-8?B?Qlh4YVArRWJlM0VsZUswUDNLbWVta012bjBnTDJMc1ljb0lRSmNmZ1NLSjFE?=
 =?utf-8?B?VC9GbXY3N085Tlg5RVdIaEJBR0czS3lTdzJSdFBZRkVndHBMNjNSYy91Qk9a?=
 =?utf-8?B?WGtzMzg4NG5hY0xWZDBOUVBkcE9EUG1iZjQwOXMvZHhZblFPWm9iMVh6OHIr?=
 =?utf-8?B?UlJmcVNwRTVrcDlnaGE3SjlTTHU5bUpRRy9RQXhGV2RLRFVMQ09sdGVqYnpj?=
 =?utf-8?B?MmxZZWdRRXhYbWpuam1VNGxZamFkWGNJV3R3NXJaa0xKZ1REbWU2bzhPVzZW?=
 =?utf-8?B?UWIvUkJmY1hRVlZ4QU9BMXp3a2JxMlhoL0NJWE1xMisyS1RYMGtGUFRMcU9m?=
 =?utf-8?B?RzR4TXd1QTRhRC9ldjJyZWxMZ1hTQzVBaXlTUHl1c05LSkxrUWNnU3d2dWNJ?=
 =?utf-8?B?dXpsVFRyYXdwZmVvOXRSbWtoRGpsSEE4NzJnanptcUNlck9rS0RNZTRpblVo?=
 =?utf-8?B?and5U1hNenduNjFiclBaemcvMktiNytzdEJSMDZkdkhVMzdxL2QxSm5FU2V0?=
 =?utf-8?B?aFBhdlp2VjZ4elBPV2pKUHptd2MzQlJna1ZrdWhSMWRQSTdDWGpkUDcwd0dC?=
 =?utf-8?B?TXBKUDArYXZtRXl2eno0MDMxZi9OZFNhSjRjaXJSaHZkQlFYUEg5NTVEYWRO?=
 =?utf-8?B?VWovTG5ZWEZ1RlZYL3pNL2N2SE1IZDZqbWg2YmxVRHd6T1c3ZWsxcGdCQ3Vm?=
 =?utf-8?B?YjF5d1dwNXBxVTlPUGJtL1BQdFA3cTlMeGU1dXNhVFBjcm1UQlBqcDhWcUJN?=
 =?utf-8?B?amx1Vm1xbWNxdXJ2RXJwQTJGTGNpR3Q4d1B0MnJZclJNK1lvNHZGUlQ4QkRV?=
 =?utf-8?B?cTFpYzBsdWF1WmVEVUx4UjEyYys1SG1zQ0U5UWhzWUpXSnZoTGdTSXlLVlMv?=
 =?utf-8?B?Wmpvb2U0YVYwd2JZa2dkeWlDbTZwQjBhQU16M2RWZFl0Z1VmUXNWSzU5NFpN?=
 =?utf-8?B?OHFIQ3RiWjdjMmpIeTJYZ2dPd0M2SFNCL1JTcnAxcS81cFV6OFg2eElHdDIz?=
 =?utf-8?B?VWpadmFsSHVUaWtsZU1YQU5OY3dOMHMrRFNwbUFrTHBjNTBLWUlLQ1RlbWRi?=
 =?utf-8?B?eW01MEM5SDJYKzA1U1RJTm53RXVEV1gwUHM3ODhUSXF2R0lGQjIrcHdwWHFv?=
 =?utf-8?B?VEFOeHVoQytBYjR6dFIrM0pSb2xsWFBBK1RlTDYwUUYzZHhlTkhMcVBFc1NS?=
 =?utf-8?B?Y3ZZT3U2eUN2cE1wTEcwYTc3dW5CS2t1NmhvMzBxZml5TzR2T2xmSW9tWDY3?=
 =?utf-8?B?eTdLNVFtelFiTE5ZczZUdWwzOXRBcG5xeEE1VURkZWpEejZ4Q00vVUpMRGZi?=
 =?utf-8?B?RmVjSktZMXhvQllYMU8veWIxcjVvbUphMlhaN202Smh4UkxQdjVaTE1mSkZX?=
 =?utf-8?B?M1hMN0prVlFxVlpTMld4Y0ZIbjlVUkxzK1Rhc0d4NnpnMGc4YXl3VVdoM0lj?=
 =?utf-8?B?Mkt4Lzl2VnVWdzdsSGZaYjBMT0dQbU9zSTZMY05qNEJ0VlpnZzRiVmNPeDk5?=
 =?utf-8?Q?JXW90RS7PDki1zDqXQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90514d8d-70f8-46a3-5096-08db516d0d57
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 15:41:42.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnRwRCajmdPhdZeTAVzoYWpb+ukvCD19Iyo75C3FzZG3ghhW3guF0ZsyPixVlgrTXZs3SbkkCZL/E1ZlnaetbyCLrlkpVuaUMdM0gjXl220=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100127
X-Proofpoint-ORIG-GUID: NOY4qt2tKeXuKTliMfA2WOzgQ5QAkhbO
X-Proofpoint-GUID: NOY4qt2tKeXuKTliMfA2WOzgQ5QAkhbO
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/6/23 04:48, Bagas Sanjaya wrote:
> On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
>> +=====================================
>> +System Launch Integrity documentation
>> +=====================================
>> +
>> +.. toctree::
> 
> By convention, doc toctree have 2-level depth (only page title and
> first-level headings are visible). You may consider adding
> `:maxdepth: 2` option.

Will do.

> 
>> diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
>> new file mode 100644
>> index 0000000..73cf063
>> --- /dev/null
>> +++ b/Documentation/security/launch-integrity/principles.rst
>> @@ -0,0 +1,313 @@
>> +=======================
>> +System Launch Integrity
>> +=======================
>> +
>> +This document serves to establish a common understanding of what is system
>> +launch, the integrity concern for system launch, and why using a Root of Trust
>> +(RoT) from a Dynamic Launch may be desired. Through out this document
>> +terminology from the Trusted Computing Group (TCG) and National Institue for
>> +Science and Technology (NIST) is used to ensure a vendor nutrual language is
>> +used to describe and reference security-related concepts.
>> +
>> +System Launch
>> +=============
>> +
>> +There is a tendency to only consider the classical power-on boot as the only
>> +means to launch an Operating System (OS) on a computer system, but in fact most
>> +modern processors support two methods to launch the system. To provide clarity a
>> +common definition of a system launch should be established. This definition is
>> +that a during a single power life cycle of a system, a System Launch consists
>> +of an initialization event, typically in hardware, that is followed by an
>> +executing software payload that takes the system from the initialized state to
>> +a running state. Driven by the Trusted Computing Group (TCG) architecture,
>> +modern processors are able to support two methods to launch a system, these two
>> +types of system launch are known as Static Launch and Dynamic Launch.
>> +
>> +Static Launch
>> +-------------
>> +
>> +Static launch is the system launch associated with the power cycle of the CPU.
>> +Thus static launch refers to the classical power-on boot where the
>> +initialization event is the release of the CPU from reset and the system
>> +firmware is the software payload that brings the system up to a running state.
>> +Since static launch is the system launch associated with the beginning of the
>> +power lifecycle of a system, it is therefore a fixed, one-time system launch.
>> +It is because of this that static launch is referred to and thought of as being
>> +"static".
>> +
>> +Dynamic Launch
>> +--------------
>> +
>> +Modern CPUs architectures provides a mechanism to re-initialize the system to a
>> +"known good" state without requiring a power event. This re-initialization
>> +event is the event for a dynamic launch and is referred to as the Dynamic
>> +Launch Event (DLE). The DLE functions by accepting a software payload, referred
>> +to as the Dynamic Configuration Environment (DCE), that execution is handed to
>> +after the DLE is invoked. The DCE is responsible for bringing the system back
>> +to a running state. Since the dynamic launch is not tied to a power event like
>> +the static launch, this enables a dynamic launch to be initiated at any time
>> +and multiple times during a single power life cycle. This dynamism is the
>> +reasoning behind referring to this system launch as being dynamic.
>> +
>> +Because a dynamic launch can be conducted at any time during a single power
>> +life cycle, they are classified into one of two types, an early launch or a
>> +late launch.
>> +
>> +:Early Launch: When a dynamic launch is used as a transition from a static
>> +   launch chain to the final Operating System.
>> +
>> +:Late Launch: The usage of a dynamic launch by an executing Operating System to
>> +   transition to a “known good” state to perform one or more operations, e.g. to
>> +   launch into a new Operating System.
>> +
>> +System Integrity
>> +================
>> +
>> +A computer system can be considered a collection of mechanisms that work
>> +together to produce a result. The assurance that the mechanisms are functioning
>> +correctly and producing the expected result is the integrity of the system. To
>> +ensure a system's integrity there are a subset of these mechanisms, commonly
>> +referred to as security mechanisms, that are present to help ensure the system
>> +produces the expected result or at least detect the potential of an unexpected
>> +result may have happened. Since the security mechanisms are relied upon to
>> +ensue the integrity of the system, these mechanisms are trusted. Upon
>> +inspection these security mechanisms each have a set of properties and these
>> +properties can be evaluated to determine how susceptible a mechanism might be
>> +to failure. This assessment is referred to as the Strength of Mechanism and for
>> +trusted mechanism enables for the trustworthiness of that mechanism to be
>> +quantified.
>> +
>> +For software systems there are two system states for which the integrity is
>> +critical, when the software is loaded into memory and when the software is
>> +executing on the hardware. Ensuring that the expected software is load into
>> +memory is referred to as load-time integrity while ensuring that the software
>> +executing is the expected software is the runtime integrity of that software.
>> +
>> +Load-time Integrity
>> +-------------------
>> +
>> +It is critical to understand what load-time integrity establishes about a
>> +system and what is assumed, i.e. what is being trusted. Load-time integrity is
>> +when a trusted entity, i.e. an entity with an assumed integrity, takes an
>> +action to assess an entity being loaded into memory before it is used. A
>> +variety of mechanisms may be used to conduct the assessment, each with
>> +different properties. A particular property is whether the mechanism creates an
>> +evidence of the assessment. Often either cryptographic signature checking or
>> +hashing are the common assessment operations used.
>> +
>> +A signature checking assessment functions by requiring a representation of the
>> +accepted authorities and uses those representations to assess if the entity has
>> +been signed by an accepted authority. The benefit to this process is that
>> +assessment process includes an adjudication of the assessment. The drawbacks
>> +are that 1) the adjudication is susceptible to tampering by the Trusted
>> +Computing Base (TCB), 2) there is no evidence to assert that an untampered
>> +adjudication was completed, and 3) the system must be an active participant in
>> +the key management infrastructure.
>> +
>> +A cryptographic hashing assessment does not adjudicate the assessment but
>> +instead generates evidence of the assessment to be adjudicated independently.
>> +The benefits to this approach is that the assessment may be simple such that it
>> +is able to be implemented as an immutable mechanism, e.g. in hardware.
>> +Additionally it is possible for the adjudication to be conducted where it
>> +cannot be tampered with by the TCB. The drawback is that a compromised
>> +environment will be allowed to execute until an adjudication can be completed.
>> +
>> +Ultimately load-time integrity provides confidence that the correct entity was
>> +loaded and in the absence of a run-time integrity mechanism assumes, i.e
>> +trusts, that the entity will never become corrupted.
>> +
>> +Runtime Integrity
>> +-----------------
>> +
>> +Runtime integrity in the general sense is when a trusted entity makes an
>> +assessment of an entity at any point in time during the assessed entity's
>> +execution. A more concrete explanation is the taking of an integrity assessment
>> +of an active process executing on the system at any point during the process'
>> +execution. Often the load-time integrity of an operating system's user-space,
>> +i.e. the operating environment, is confused to be the runtime integrity of the
>> +system since it is an integrity assessment of the "runtime" software. The
>> +reality is that actual runtime integrity is a very difficult problem and thus
>> +not very many solutions are public and/or available. One example of a runtime
>> +integrity solution would be John Hopkins Advanced Physics Labratory's (APL)
>> +Linux Kernel Integrity Module (LKIM).
>> +
>> +Trust Chains
>> +============
>> +
>> +Bulding upon the understanding of security mechanisms to establish load-time
>> +integrity of an entity, it is possible to chain together load-time integrity
>> +assessments to establish the integrity of the whole system. This process is
>> +known as transitive trust and provides the concept of building a chain of
>> +load-time integrity assessments, commonly referred to as a trust chain. These
>> +assessments may be used to adjudicate the load-time integrity of the whole
>> +system. This trust chain is started by a trusted entity that does the first
>> +assessment. This first entity is referred to as the Root of Trust(RoT) with the
>> +entities name being derived from the mechanism used for the assessment, i.e.
>> +RoT for Verification (RTV) and RoT for Measurement (RTM).
>> +
>> +A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
>> +and therefore it too has a Strength of Mechanism. The factors that contribute
>> +to a trust chain's strength are,
>> +
>> +  - The strength of the chain's RoT
>> +  - The strength of each member of the trust chain
>> +  - The length, i.e. the number of members, of the chain
>> +
>> +Therefore to provide the strongest trust chains, they should start with a
>> +strong RoT and should consist of members being of low complexity and minimizing
>> +the number of members participating as is possible. In a more colloquial sense,
>> +a trust chain is only as strong as it weakests link and more links increase
>> +the probability of a weak link.
>> +
>> +Dynamic Launch Components
>> +=========================
>> +
>> +The TCG architecture for dynamic launch is composed of a component series that
>> +are used to setup and then carry out the launch. These components work together
>> +to construct a RTM trust chain that is rooted in the dynamic launch and thus
>> +commonly referred to as the Dynamic Root of Trust for Measurement (DRTM) chain.
>> +
>> +What follows is a brief explanation of each component in execution order. A
>> +subset of these components are what establishes the dynamic launch's trust
>> +chain.
>> +
>> +Dynamic Configuration Environment Preamble
>> +------------------------------------------
>> +
>> +The Dynamic Configuration Environment (DCE) Preamble is responsible for setting
>> +up the system environment in preparation for a dynamic launch. The DCE Preamble
>> +is not a part of the DRTM trust chain.
>> +
>> +Dynamic Launch Event
>> +--------------------
>> +
>> +The dynamic launch event is the event, typically a CPU instruction, that triggers
>> +the system's dynamic launch mechanism to begin the launch. The dynamic launch
>> +mechanism is also the RoT for the DRTM trust chain.
>> +
>> +Dynamic Configuration Environment
>> +---------------------------------
>> +
>> +The dynamic launch mechanism may have resulted in a reset of a portion of the
>> +system. To bring the system back to an adequate state for system software the
>> +dynamic launch will hand over control to the DCE. Prior to handing over this
>> +control, the dynamic launch will measure the DCE. Once the DCE is complete it
>> +will proceed to measure and then execute the Dynamic Launch Measured
>> +Environment (DLME).
>> +
>> +Dynamic Launch Measured Environment
>> +-----------------------------------
>> +
>> +The DLME is the first system kernel to have control of the system but may not
>> +be the last. Depending on the usage and configuration, the DLME may be the
>> +final/target operating system or it may be a boot loader that will load the
>> +final/target operating system.
>> +
>> +Why DRTM
>> +========
>> +
>> +It is a fact that DRTM increases the load-time integrity of the system by
>> +providing a trust chain that has an immutable hardware RoT, uses a limited
>> +number of small, special purpose code to establish the trust chain that starts
>> +the target operating system. As mentioned in the Trust Chain section, these are
>> +the main three factors in driving up the strength of a trust chain. As can been
>> +seen by the BootHole exploit, which in fact did not effect the integrity of
>> +DRTM solutions, the sophistication of attacks targeting system launch is at an
>> +all time high. There is no reason a system should not employ every integrity
>> +measure hardware makes available. This is the crux of a defense-in-depth
>> +approach to system security. In the past the now closed SMI gap was often
>> +pointed to as invalidating DRTM, which in fact was nothing but a strawman
>> +argument. As has continued to be demonstrated, if/when SMM is corrupted it can
>> +always circumvent all load-time integrity, SRTM and DRTM, because it is a
>> +run-time integrity problem. Regardless, Intel and AMD have both deployed
>> +runtime integrity for SMI and SMM which is tied directly to DRTM such that this
>> +perceived deficiency is now non-existent and the world is moving forward with
>> +an expectation that DRTM must be present.
>> +
>> +Glossary
>> +========
>> +
>> +.. glossary::
>> +  integrity
>> +    Guarding against improper information modification or destruction, and
>> +    includes ensuring information non-repudiation and authenticity.
>> +
>> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
>> +
>> +  mechanism
>> +    A process or system that is used to produce a particular result.
>> +
>> +    - NIST Special Publication 800-160 (VOLUME 1 ) - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1.pdf
>> +
>> +  risk
>> +    A measure of the extent to which an entity is threatened by a potential
>> +    circumstance or event, and typically a function of: (i) the adverse impacts
>> +    that would arise if the circumstance or event occurs; and (ii) the
>> +    likelihood of occurrence.
>> +
>> +    - NIST SP 800-30 Rev. 1 - https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-30r1.pdf
>> +
>> +  security mechanism
>> +    A device or function designed to provide one or more security services
>> +    usually rated in terms of strength of service and assurance of the design.
>> +
>> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
>> +
>> +  Strength of Mechanism
>> +    A scale for measuring the relative strength of a security mechanism
>> +
>> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
>> +
>> +  transitive trust
>> +    Also known as "Inductive Trust", in this process a Root of Trust gives a
>> +    trustworthy description of a second group of functions. Based on this
>> +    description, an interested entity can determine the trust it is to place in
>> +    this second group of functions. If the interested entity determines that
>> +    the trust level of the second group of functions is acceptable, the trust
>> +    boundary is extended from the Root of Trust to include the second group of
>> +    functions. In this case, the process can be iterated. The second group of
>> +    functions can give a trustworthy description of the third group of
>> +    functions, etc. Transitive trust is used to provide a trustworthy
>> +    description of platform characteristics, and also to prove that
>> +    non-migratable keys are non-migratable
>> +
>> +    - TCG Glossary - https://trustedcomputinggroup.org/wp-content/uploads/TCG-Glossary-V1.1-Rev-1.0.pdf
>> +
>> +  trust
>> +    The confidence one element has in another that the second element will
>> +    behave as expected`
>> +
>> +    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
>> +
>> +  trust anchor
>> +    An authoritative entity for which trust is assumed.
>> +
>> +    - NIST SP 800-57 Part 1 Rev. 5 - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf
>> +
>> +  trusted
>> +    An element that another element relies upon to fulfill critical
>> +    requirements on its behalf.
>> +
>> +    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
>> +
>> +  trusted computing base (TCB)
>> +    Totality of protection mechanisms within a computer system, including
>> +    hardware, firmware, and software, the combination responsible for enforcing
>> +    a security policy.
>> +
>> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
>> +
>> +  trusted computer system
>> +    A system that has the necessary security functions and assurance that the
>> +    security policy will be enforced and that can process a range of
>> +    information sensitivities (i.e. classified, controlled unclassified
>> +    information (CUI), or unclassified public information) simultaneously.
>> +
>> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
>> +
>> +  trustworthiness
>> +    The attribute of a person or enterprise that provides confidence to others
>> +    of the qualifications, capabilities, and reliability of that entity to
>> +    perform specific tasks and fulfill assigned responsibilities.
>> +
>> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
>> diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst
>> new file mode 100644
>> index 0000000..2e71543
>> --- /dev/null
>> +++ b/Documentation/security/launch-integrity/secure_launch_details.rst
>> @@ -0,0 +1,564 @@
>> +===================================
>> +Secure Launch Config and Interfaces
>> +===================================
>> +
>> +Configuration
>> +=============
>> +
>> +The settings to enable Secure Launch using Kconfig are under::
>> +
>> +  "Processor type and features" --> "Secure Launch support"
>> +
>> +A kernel with this option enabled can still be booted using other supported
>> +methods.
>> +
>> +To reduce the Trusted Computing Base (TCB) of the MLE [1]_, the build
>> +configuration should be pared down as narrowly as one's use case allows.
>> +The fewer drivers (less active hardware) and features reduces the attack
>> +surface. E.g. in the extreme, the MLE could only have local disk access
>> +and no other hardware support. Or only network access for remote attestation.
>> +
>> +It is also desirable if possible to embed the initrd used with the MLE kernel
>> +image to reduce complexity.
>> +
>> +The following are a few important configuration necessities to always consider:
>> +
>> +KASLR Configuration
>> +-------------------
>> +
>> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
>> +built with KASLR disabled::
>> +
>> +  "Processor type and features" -->
>> +      "Build a relocatable kernel" -->
>> +          "Randomize the address of the kernel image (KASLR) [ ]"
>> +
>> +This unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
>> +
>> +If not possible, KASLR must be disabled on the kernel command line when doing
>> +a Secure Launch as follows::
>> +
>> +  nokaslr
>> +
>> +IOMMU Configuration
>> +-------------------
>> +
>> +When doing a Secure Launch, the IOMMU should always be enabled and the drivers
>> +loaded. However, IOMMU passthrough mode should never be used. This leaves the
>> +MLE completely exposed to DMA after the PMR's [2]_ are disabled. The current default
>> +mode is to use IOMMU in lazy translated mode but strict translated mode is the preferred
>> +IOMMU mode and this should be selected in the build configuration::
>> +
>> +  "Device Drivers" -->
>> +      "IOMMU Hardware Support" -->
>> +          "IOMMU default domain type" -->
>> +              "(X) Translated - Strict"
>> +
>> +In addition, the Intel IOMMU should be on by default. The following sets this as the
>> +default in the build configuration::
>> +
>> +  "Device Drivers" -->
>> +      "IOMMU Hardware Support" -->
>> +          "Support for Intel IOMMU using DMA Remapping Devices [*]"
>> +
>> +and::
>> +
>> +  "Device Drivers" -->
>> +      "IOMMU Hardware Support" -->
>> +          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
>> +              "Enable Intel DMA Remapping Devices by default  [*]"
>> +
>> +It is recommended that no other command line options should be set to override
>> +the defaults above.
>> +
>> +Secure Launch Resource Table
>> +============================
>> +
>> +The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard format
>> +for providing information for the pre-launch environment and to pass
>> +information to the post-launch environment. The table is populated by one or
>> +more bootloaders in the boot chain and used by Secure Launch on how to setup
>> +the environment during post-launch. The details for the SLRT are documented
>> +in the TrenchBoot Secure Launch Specifcation [3]_.
>> +
>> +Intel TXT Interface
>> +===================
>> +
>> +The primary interfaces between the various components in TXT are the TXT MMIO
>> +registers and the TXT heap. The MMIO register banks are described in Appendix B
>> +of the TXT MLE [1]_ Development Guide.
>> +
>> +The TXT heap is described in Appendix C of the TXT MLE [1]_ Development
>> +Guide. Most of the TXT heap is predefined in the specification. The heap is
>> +initialized by firmware and the pre-launch environment and is subsequently used
>> +by the SINIT ACM. One section, called the OS to MLE Data Table, is reserved for
>> +software to define. This table is set up per the recommendation detailed in
>> +Appendix B of the TrenchBoot Secure Launch Specification::
>> +
>> +        /*
>> +         * Secure Launch defined OS/MLE TXT Heap table
>> +         */
>> +        struct txt_os_mle_data {
>> +                u32 version;
>> +                u32 boot_params_addr;
>> +                struct slr_table *slrt;
>> +                u64 txt_info;
>> +                u32 ap_wake_block;
>> +                u32 ap_wake_block_size;
>> +                u8 mle_scratch[64];
>> +        } __packed;
>> +
>> +Description of structure:
>> +
>> +=====================  ========================================================================
>> +Field                  Use
>> +=====================  ========================================================================
>> +version                Structure version, current value 1
>> +boot_params_addr       Physical base address of the Linux boot parameters
>> +slrt                   Physical address of the Secure Launch Resource Table
>> +txt_info               Pointer into the SLRT for easily locating TXT specific table
>> +ap_wake_block          Physical address of the block of memory for parking APs after a launch
>> +ap_wake_block_size     Size of the AP wake block
>> +mle_scratch            Scratch area used post-launch by the MLE kernel. Fields:
>> +
>> +                        - SL_SCRATCH_AP_EBX area to share %ebx base pointer among CPUs
>> +                        - SL_SCRATCH_AP_JMP_OFFSET offset to abs. ljmp fixup location for APs
>> +=====================  ========================================================================
>> +
>> +Error Codes
>> +-----------
>> +
>> +The TXT specification defines the layout for TXT 32 bit error code values.
>> +The bit encodings indicate where the error originated (e.g. with the CPU,
>> +in the SINIT ACM, in software). The error is written to a sticky TXT
>> +register that persists across resets called TXT.ERRORCODE (see the TXT
>> +MLE Development Guide). The errors defined by the Secure Launch feature are
>> +those generated in the MLE software. They have the format::
>> +
>> +  0xc0008XXX
>> +
>> +The low 12 bits are free for defining the following Secure Launch specific
>> +error codes.
>> +
>> +======  ================
>> +Name:   SL_ERROR_GENERIC
>> +Value:  0xc0008001
>> +======  ================
>> +
>> +Description:
>> +
>> +Generic catch all error. Currently unused.
>> +
>> +======  =================
>> +Name:   SL_ERROR_TPM_INIT
>> +Value:  0xc0008002
>> +======  =================
>> +
>> +Description:
>> +
>> +The Secure Launch code failed to get an access to the TPM hardware interface.
>> +This is most likely to due to misconfigured hardware or kernel. Ensure the
>> +TPM chip is enabled and the kernel TPM support is built in (it should not be
>> +built as a module).
>> +
>> +======  ==========================
>> +Name:   SL_ERROR_TPM_INVALID_LOG20
>> +Value:  0xc0008003
>> +======  ==========================
>> +
>> +Description:
>> +
>> +The Secure Launch code failed to find a valid event log descriptor for TPM
>> +version 2.0 or the event log descriptor is malformed. Usually this indicates
>> +that incompatible versions of the pre-launch environment and the MLE kernel.
>> +The pre-launch environment and the kernel share a structure in the TXT heap and
>> +if this structure (the OS-MLE table) is mismatched, this error is often seen.
>> +This TXT heap area is setup by the pre-launch environment so the issue may
>> +originate there. It could be the sign of an attempted attack.
>> +
>> +======  ===========================
>> +Name:   SL_ERROR_TPM_LOGGING_FAILED
>> +Value:  0xc0008004
>> +======  ===========================
>> +
>> +Description:
>> +
>> +There was a failed attempt to write a TPM event to the event log early in the
>> +Secure Launch process. This is likely the result of a malformed TPM event log
>> +buffer. Formatting of the event log buffer information is done by the
>> +pre-launch environment so the issue most likely originates there.
>> +
>> +======  ============================
>> +Name:   SL_ERROR_REGION_STRADDLE_4GB
>> +Value:  0xc0008005
>> +======  ============================
>> +
>> +Description:
>> +
>> +During early validation a buffer or region was found to straddle the 4GB
>> +boundary. Because of the way TXT does DMA memory protection, this is an
>> +unsafe configuration and is flagged as an error. This is most likely a
>> +configuration issue in the pre-launch environment. It could also be the sign of
>> +an attempted attack.
>> +
>> +======  ===================
>> +Name:   SL_ERROR_TPM_EXTEND
>> +Value:  0xc0008006
>> +======  ===================
>> +
>> +Description:
>> +
>> +There was a failed attempt to extend a TPM PCR in the Secure Launch platform
>> +module. This is most likely to due to misconfigured hardware or kernel. Ensure
>> +the TPM chip is enabled and the kernel TPM support is built in (it should not
>> +be built as a module).
>> +
>> +======  ======================
>> +Name:   SL_ERROR_MTRR_INV_VCNT
>> +Value:  0xc0008007
>> +======  ======================
>> +
>> +Description:
>> +
>> +During early Secure Launch validation an invalid variable MTRR count was found.
>> +The pre-launch environment passes a number of MSR values to the MLE to restore
>> +including the MTRRs. The values are restored by the Secure Launch early entry
>> +point code. After measuring the values supplied by the pre-launch environment,
>> +a discrepancy was found validating the values. It could be the sign of an
>> +attempted attack.
>> +
>> +======  ==========================
>> +Name:   SL_ERROR_MTRR_INV_DEF_TYPE
>> +Value:  0xc0008008
>> +======  ==========================
>> +
>> +Description:
>> +
>> +During early Secure Launch validation an invalid default MTRR type was found.
>> +See SL_ERROR_MTRR_INV_VCNT for more details.
>> +
>> +======  ======================
>> +Name:   SL_ERROR_MTRR_INV_BASE
>> +Value:  0xc0008009
>> +======  ======================
>> +
>> +Description:
>> +
>> +During early Secure Launch validation an invalid variable MTRR base value was
>> +found. See SL_ERROR_MTRR_INV_VCNT for more details.
>> +
>> +======  ======================
>> +Name:   SL_ERROR_MTRR_INV_MASK
>> +Value:  0xc000800a
>> +======  ======================
>> +
>> +Description:
>> +
>> +During early Secure Launch validation an invalid variable MTRR mask value was
>> +found. See SL_ERROR_MTRR_INV_VCNT for more details.
>> +
>> +======  ========================
>> +Name:   SL_ERROR_MSR_INV_MISC_EN
>> +Value:  0xc000800b
>> +======  ========================
>> +
>> +Description:
>> +
>> +During early Secure Launch validation an invalid miscellaneous enable MSR value
>> +was found. See SL_ERROR_MTRR_INV_VCNT for more details.
>> +
>> +======  =========================
>> +Name:   SL_ERROR_INV_AP_INTERRUPT
>> +Value:  0xc000800c
>> +======  =========================
>> +
>> +Description:
>> +
>> +The application processors (APs) wait to be woken up by the SMP initialization
>> +code. The only interrupt that they expect is an NMI; all other interrupts
>> +should be masked. If an AP gets some other interrupt other than an NMI it will
>> +cause this error. This error is very unlikely to occur.
>> +
>> +======  =========================
>> +Name:   SL_ERROR_INTEGER_OVERFLOW
>> +Value:  0xc000800d
>> +======  =========================
>> +
>> +Description:
>> +
>> +A buffer base and size passed to the MLE caused an integer overflow when
>> +added together. This is most likely a configuration issue in the pre-launch
>> +environment. It could also be the sign of an attempted attack.
>> +
>> +======  ==================
>> +Name:   SL_ERROR_HEAP_WALK
>> +Value:  0xc000800e
>> +======  ==================
>> +
>> +Description:
>> +
>> +An error occurred in TXT heap walking code. The underlying issue is a failure to
>> +early_memremap() portions of the heap, most likely due to a resource shortage.
>> +
>> +======  =================
>> +Name:   SL_ERROR_HEAP_MAP
>> +Value:  0xc000800f
>> +======  =================
>> +
>> +Description:
>> +
>> +This error is essentially the same as SL_ERROR_HEAP_WALK but occurred during the
>> +actual early_memremap() operation.
>> +
>> +======  =========================
>> +Name:   SL_ERROR_REGION_ABOVE_4GB
>> +Value:  0xc0008010
>> +======  =========================
>> +
>> +Description:
>> +
>> +A memory region used by the MLE is above 4GB. In general this is not a problem
>> +because memory > 4Gb can be protected from DMA. There are certain buffers that
>> +should never be above 4Gb though and one of these caused the violation. This is
>> +most likely a configuration issue in the pre-launch environment. It could also
>> +be the sign of an attempted attack.
>> +
>> +======  ==========================
>> +Name:   SL_ERROR_HEAP_INVALID_DMAR
>> +Value:  0xc0008011
>> +======  ==========================
>> +
>> +Description:
>> +
>> +The backup copy of the ACPI DMAR table which is supposed to be located in the
>> +TXT heap could not be found. This is due to a bug in the platform's ACM module
>> +or in firmware.
>> +
>> +======  =======================
>> +Name:   SL_ERROR_HEAP_DMAR_SIZE
>> +Value:  0xc0008012
>> +======  =======================
>> +
>> +Description:
>> +
>> +The backup copy of the ACPI DMAR table in the TXT heap is to large to be stored
>> +for later usage. This error is very unlikely to occur since the area reserved
>> +for the copy is far larger than the DMAR should be.
>> +
>> +======  ======================
>> +Name:   SL_ERROR_HEAP_DMAR_MAP
>> +Value:  0xc0008013
>> +======  ======================
>> +
>> +Description:
>> +
>> +The backup copy of the ACPI DMAR table in the TXT heap could not be mapped. The
>> +underlying issue is a failure to early_memremap() the DMAR table, most likely
>> +due to a resource shortage.
>> +
>> +======  ====================
>> +Name:   SL_ERROR_HI_PMR_BASE
>> +Value:  0xc0008014
>> +======  ====================
>> +
>> +Description:
>> +
>> +On a system with more than 4G of RAM, the high PMR [2]_ base address should be set
>> +to 4G. This error is due to that not being the case. This PMR value is set by
>> +the pre-launch environment so the issue most likely originates there. It could also
>> +be the sign of an attempted attack.
>> +
>> +======  ====================
>> +Name:   SL_ERROR_HI_PMR_SIZE
>> +Value:  0xc0008015
>> +======  ====================
>> +
>> +Description:
>> +
>> +On a system with more than 4G of RAM, the high PMR [2]_ size should be set to cover
>> +all RAM > 4G. This error is due to that not being the case. This PMR value is
>> +set by the pre-launch environment so the issue most likely originates there. It
>> +could also be the sign of an attempted attack.
>> +
>> +======  ====================
>> +Name:   SL_ERROR_LO_PMR_BASE
>> +Value:  0xc0008016
>> +======  ====================
>> +
>> +Description:
>> +
>> +The low PMR [2]_ base should always be set to address zero. This error is due to
>> +that not being the case. This PMR value is set by the pre-launch environment
>> +so the issue most likely originates there. It could also be the sign of an attempted
>> +attack.
>> +
>> +======  ====================
>> +Name:   SL_ERROR_LO_PMR_MLE
>> +Value:  0xc0008017
>> +======  ====================
>> +
>> +Description:
>> +
>> +This error indicates the MLE image is not covered by the low PMR [2]_ range. The
>> +PMR values are set by the pre-launch environment so the issue most likely originates
>> +there. It could also be the sign of an attempted attack.
>> +
>> +======  =======================
>> +Name:   SL_ERROR_INITRD_TOO_BIG
>> +Value:  0xc0008018
>> +======  =======================
>> +
>> +Description:
>> +
>> +The external initrd provided is larger than 4Gb. This is not a valid
>> +configuration for a Secure Launch due to managing DMA protection.
>> +
>> +======  =========================
>> +Name:   SL_ERROR_HEAP_ZERO_OFFSET
>> +Value:  0xc0008019
>> +======  =========================
>> +
>> +Description:
>> +
>> +During a TXT heap walk an invalid/zero next table offset value was found. This
>> +indicates the TXT heap is malformed. The TXT heap is initialized by the
>> +pre-launch environment so the issue most likely originates there. It could also
>> +be a sign of an attempted attack. In addition, ACM is also responsible for
>> +manipulating parts of the TXT heap so the issue could be due to a bug in the
>> +platform's ACM module.
>> +
>> +======  =============================
>> +Name:   SL_ERROR_WAKE_BLOCK_TOO_SMALL
>> +Value:  0xc000801a
>> +======  =============================
>> +
>> +Description:
>> +
>> +The AP wake block buffer passed to the MLE via the OS-MLE TXT heap table is not
>> +large enough. This value is set by the pre-launch environment so the issue most
>> +likely originates there. It also could be the sign of an attempted attack.
>> +
>> +======  ===========================
>> +Name:   SL_ERROR_MLE_BUFFER_OVERLAP
>> +Value:  0xc000801b
>> +======  ===========================
>> +
>> +Description:
>> +
>> +One of the buffers passed to the MLE via the OS-MLE TXT heap table overlaps
>> +with the MLE image in memory. This value is set by the pre-launch environment
>> +so the issue most likely originates there. It could also be the sign of an attempted
>> +attack.
>> +
>> +======  ==========================
>> +Name:   SL_ERROR_BUFFER_BEYOND_PMR
>> +Value:  0xc000801c
>> +======  ==========================
>> +
>> +Description:
>> +
>> +One of the buffers passed to the MLE via the OS-MLE TXT heap table is not
>> +protected by a PMR. This value is set by the pre-launch environment so the
>> +issue most likey  originates there. It could also be the sign of an attempted
>> +attack.
>> +
>> +======  =============================
>> +Name:   SL_ERROR_OS_SINIT_BAD_VERSION
>> +Value:  0xc000801d
>> +======  =============================
>> +
>> +Description:
>> +
>> +The version of the OS-SINIT TXT heap table is bad. It must be 6 or greater.
>> +This value is set by the pre-launch environment so the issue most likely
>> +originates there. It could also be the sign of an attempted attack. It is also
>> +possible though very unlikely that the platform is so old that the ACM being
>> +used requires an unsupported version.
>> +
>> +======  =====================
>> +Name:   SL_ERROR_EVENTLOG_MAP
>> +Value:  0xc000801e
>> +======  =====================
>> +
>> +Description:
>> +
>> +An error occurred in the Secure Launch module while mapping the TPM event log.
>> +The underlying issue is memremap() failure, most likely due to a resource
>> +shortage.
>> +
>> +======  ========================
>> +Name:   SL_ERROR_TPM_NUMBER_ALGS
>> +Value:  0xc000801f
>> +======  ========================
>> +
>> +Description:
>> +
>> +The TPM 2.0 event log reports an unsupported number of hashing algorithms.
>> +Secure launch currently only supports a maximum of two: SHA1 and SHA256.
>> +
>> +======  ===========================
>> +Name:   SL_ERROR_TPM_UNKNOWN_DIGEST
>> +Value:  0xc0008020
>> +======  ===========================
>> +
>> +Description:
>> +
>> +The TPM 2.0 event log reports an unsupported hashing algorithm. Secure launch
>> +currently only supports two algorithms: SHA1 and SHA256.
>> +
>> +======  ==========================
>> +Name:   SL_ERROR_TPM_INVALID_EVENT
>> +Value:  0xc0008021
>> +======  ==========================
>> +
>> +Description:
>> +
>> +An invalid/malformed event was found in the TPM event log while reading it.
>> +Since only trusted entities are supposed to be writing the event log, this
>> +would indicate either a bug or a possible attack.
>> +
>> +======  =====================
>> +Name:   SL_ERROR_INVALID_SLRT
>> +Value:  0xc0008022
>> +======  =====================
>> +
>> +Description:
>> +
>> +The Secure Launch Resource Table is invalid or malformed and is unusable.
>> +This implies the pre-launch code did not properly setup the SLRT.
>> +
>> +======  ===========================
>> +Name:   SL_ERROR_SLRT_MISSING_ENTRY
>> +Value:  0xc0008023
>> +======  ===========================
>> +
>> +Description:
>> +
>> +The Secure Launch Resource Table is missing a required entry within it.
>> +This implies the pre-launch code did not properly setup the SLRT.
>> +
>> +======  =================
>> +Name:   SL_ERROR_SLRT_MAP
>> +Value:  0xc0008024
>> +======  =================
>> +
>> +Description:
>> +
>> +An error occurred in the Secure Launch module while mapping the Secure Launch
>> +Resource table. The underlying issue is memremap() failure, most likely due to
>> +a resource shortage.
>> +
>> +.. [1]
>> +    MLE: Measured Launch Environment is the binary runtime that is measured and
>> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
>> +    requirements for the MLE in detail.
>> +
>> +.. [2]
>> +    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Registers.
>> +    There are two of these registers and they allow all DMA to be blocked
>> +    to large areas of memory. The low PMR can cover all memory below 4Gb on 2Mb
>> +    boundaries. The high PMR can cover all RAM on the system, again on 2Mb
>> +    boundaries. This feature is used during a Secure Launch by TXT.
>> +
>> +.. [3]
>> +    Secure Launch Specification: https://trenchboot.org/specifications/Secure_Launch/
>> diff --git a/Documentation/security/launch-integrity/secure_launch_overview.rst b/Documentation/security/launch-integrity/secure_launch_overview.rst
>> new file mode 100644
>> index 0000000..ba91d73
>> --- /dev/null
>> +++ b/Documentation/security/launch-integrity/secure_launch_overview.rst
>> @@ -0,0 +1,220 @@
>> +======================
>> +Secure Launch Overview
>> +======================
>> +
>> +Overview
>> +========
>> +
>> +Prior to the start of the TrenchBoot project, the only active Open Source
>> +project supporting dynamic launch was Intel's tboot project to support their
>> +implementation of dynamic launch known as Intel Trusted eXecution Technology
>> +(TXT). The approach taken by tboot was to provide an exokernel that could
>> +handle the launch protocol implemented by Intel's special loader, the SINIT
>> +Authenticated Code Module (ACM [2]_) and remained in memory to manage the SMX
>> +CPU mode that a dynamic launch would put a system. While it is not precluded
>> +from being used for doing a late launch, tboot's primary use case was to be
>> +used as an early launch solution. As a result the TrenchBoot project started
>> +the development of Secure Launch kernel feature to provide a more generalized
>> +approach. The focus of the effort is twofold, the first is to make the Linux
>> +kernel directly aware of the launch protocol used by Intel, AMD/Hygon, Arm, and
>> +potentially OpenPOWER. The second is to make the Linux kernel be able to
>> +initiate a dynamic launch. It is through this approach that the Secure Launch
>> +kernel feature creates a basis for the Linux kernel to be used in a variety of
>> +dynamic launch use cases.
>> +
>> +.. note::
>> +    A quick note on terminology. The larger open source project itself is
>> +    called TrenchBoot, which is hosted on GitHub (links below). The kernel
>> +    feature enabling the use of the x86 technology is referred to as "Secure
>> +    Launch" within the kernel code.
>> +
>> +Goals
>> +=====
>> +
>> +The first use case that the TrenchBoot project focused on was the ability for
>> +the Linux kernel to be started by a dynamic launch, in particular as part of an
>> +early launch sequence. In this case the dynamic launch will be initiated by any
>> +boot loader with associated support added to it, for example the first targeted
>> +boot loader in this case was GRUB2. An integral part of establishing a
>> +measurement-based launch integrity involves measuring everything that is
>> +intended to be executed (kernel image, initrd, etc) and everything that will
>> +configure that kernel to execute (command line, boot params, etc). Then storing
>> +those measurements in a protected manner. Both the Intel and AMD dynamic launch
>> +implementations leverage the Trusted Platform Module (TPM) to store those
>> +measurements. The TPM itself has been designed such that a dynamic launch
>> +unlocks a specific set of Platform Configuration Registers (PCR) for holding
>> +measurement taken during the dynamic launch.  These are referred to as the DRTM
>> +PCRs, PCRs 17-22. Further details on this process can be found in the
>> +documentation for the GETSEC instruction provided by Intel's TXT and the SKINIT
>> +instruction provided by AMD's AMD-V. The documentation on these technologies
>> +can be readily found online; see the `Resources`_ section below for references.
>> +
>> +.. note::
>> +    Currently only Intel TXT is supported in this first release of the Secure
>> +    Launch feature. AMD/Hygon SKINIT and Arm support will be added in a
>> +    subsequent release.
>> +
>> +To enable the kernel to be launched by GETSEC a stub, the Secure Launch stub,
>> +must be built into the setup section of the compressed kernel to handle the
>> +specific state that the dynamic launch process leaves the BSP. Also the Secure
>> +Launch stub must measure everything that is going to be used as early as
>> +possible. This stub code and subsequent code must also deal with the specific
>> +state that the dynamic launch leaves the APs as well.
>> +
>> +Design Decisions
>> +================
>> +
>> +A number of design decisions were made during the development of the Secure
>> +Launch feature. The two primary guiding decisions were:
>> +
>> + - Keeping the Secure Launch code as separate from the rest of the kernel
>> +   as possible.
>> + - Modifying the existing boot path of the kernel as little as possible.
>> +
>> +The following illustrate how the implementation followed these design
>> +decisions:
>> +
>> + - All the entry point code necessary to properly configure the system post
>> +   launch is found in st_stub.S in the compressed kernel image. This code
>> +   validates the state of the system, restores necessary system operating
>> +   configurations and properly handles post launch CPU states.
>> + - After the sl_stub.S is complete, it jumps directly to the unmodified
>> +   startup_32 kernel entry point.
>> + - A single call is made to a function sl_main() prior to the main kernel
>> +   decompression step. This code performs further validation and takes the
>> +   needed DRTM measurements.
>> + - After the call to sl_main(), the main kernel is decompressed and boots as
>> +   it normally would.
>> + - Final setup for the Secure Launch kernel is done in a separate Secure
>> +   Launch module that is loaded via a late initcall. This code is responsible
>> +   for extending the measurements taken earlier into the TPM DRTM PCRs and
>> +   setting up the securityfs interface to allow access the TPM event log and
>> +   public TXT registers.
>> + - On the reboot and kexec paths, calls are made to a function to finalize the
>> +   state of the Secure Launch kernel.
>> +
>> +The one place where Secure Launch code is mixed directly in with kernel code is
>> +in the SMP boot code. This is due to the unique state that the dynamic launch
>> +leaves the APs in. On Intel this involves using a method other than the
>> +standard INIT-SIPI sequence.
>> +
>> +A final note is that originally the extending of the PCRs was completed in the
>> +Secure Launch stub when the measurements were taken. An alternative solution
>> +had to be implemented due to the TPM maintainers objecting to the PCR
>> +extensions being done with a minimal interface to the TPM that was an
>> +independent implementation of the mainline kernel driver. Since the mainline
>> +driver relies heavily on kernel interfaces not available in the compressed
>> +kernel, it was not possible to reuse the mainline TPM driver. This resulted in
>> +the decision to move the extension operations to the Secure Launch module in
>> +the mainline kernel where the TPM driver would be available.
>> +
>> +Basic Boot Flow
>> +===============
>> +
>> +Outlined here is summary of the boot flow for Secure Launch. A more detailed
>> +review of Secure Launch process can be found in the Secure Launch
>> +Specification, a link is located in the `Resources`_ section.
>> +
>> +Pre-launch: *Phase where the environment is prepared and configured to initiate the
>> +secure launch by the boot chain.*
>> +
>> + - The SLRT is initialized and dl_stub is placed in memory.
>> + - Load the kernel, initrd and ACM [2]_ into memory.
>> + - Setup the TXT heap and page tables describing the MLE [1]_ per the
>> +   specification.
>> + - If non-UEFI platform, dl_stub is called.
>> + - If UEFI platforms, SLRT registered with UEFI and efi-stub called.
>> + - Upon completion, efi-stub will call EBS followed by dl_stub.
>> + - The dl_stub will prepare the CPU and the TPM for the launch.
>> + - The secure launch is then initiated with the GETSET[SENTER] instruction.
>> +
>> +Post-launch: *Phase where control is passed from the ACM to the MLE and the secure
>> +kernel begins execution.*
>> +
>> + - Entry from the dynamic launch jumps to the SL stub.
>> + - SL stub fixes up the world on the BSP.
>> + - For TXT, SL stub wakes the APs, fixes up their worlds.
>> + - For TXT, APs are left halted waiting for an NMI to wake them.
>> + - SL stub jumps to startup_32.
>> + - SL main does validation of buffers and memory locations. It sets
>> +   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
>> +   kernel that a Secure Launch was done.
>> + - SL main locates the TPM event log and writes the measurements of
>> +   configuration and module information into it.
>> + - Kernel boot proceeds normally from this point.
>> + - During early setup, slaunch_setup() runs to finish some validation
>> +   and setup tasks.
>> + - The SMP bring up code is modified to wake the waiting APs. APs vector
>> +   to rmpiggy and start up normally from that point.
>> + - SL platform module is registered as a late initcall module. It reads
>> +   the TPM event log and extends the measurements taken into the TPM PCRs.
>> + - SL platform module initializes the securityfs interface to allow
>> +   access to the TPM event log and TXT public registers.
>> + - Kernel boot finishes booting normally
>> + - SEXIT support to leave SMX mode is present on the kexec path and
>> +   the various reboot paths (poweroff, reset, halt).
>> +
>> +PCR Usage
>> +=========
>> +
>> +The TCG DRTM architecture there are three PCRs defined for usage, PCR.Details
>> +(PCR17), PCR.Authorities (PCR18), and PCR.DLME_Authority (PCR19). For a deeper
>> +understanding of Detail and Authorities it is recommended to review the TCG
>> +DRTM architecture.
>> +
>> +To determine PCR usage, Linux Secure Launch follows the TrenchBoot Secure
>> +Launch Specification of using a measurement policy stored in the SLRT. The
>> +policy details what should be measured and the PCR in which to store the
>> +measurement. The measurement policy provides the ability to select the
>> +PCR.DLME_Detail (PCR20) PCR as the location for the DRTM components measured by
>> +the kernel, e.g. external initrd image. This can then be combined with storing
>> +the user authority in the PCR.DLME_Authority PCR to seal/attest to different
>> +variations of platform details/authorities and user details/authorities. An
>> +example of how this can be achieved was presented in the FOSDEM - 2021 talk
>> +"Secure Upgrades with DRTM".
>> +
>> +Resources
>> +=========
>> +
>> +The TrenchBoot project:
>> +
>> +https://trenchboot.org
>> +
>> +Secure Launch Specification:
>> +
>> +https://trenchboot.org/specifications/Secure_Launch/
>> +
>> +Trusted Computing Group's D-RTM Architecture:
>> +
>> +https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
>> +
>> +TXT documentation in the Intel TXT MLE Development Guide:
>> +
>> +https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
>> +
>> +TXT instructions documentation in the Intel SDM Instruction Set volume:
>> +
>> +https://software.intel.com/en-us/articles/intel-sdm
>> +
>> +AMD SKINIT documentation in the System Programming manual:
>> +
>> +https://www.amd.com/system/files/TechDocs/24593.pdf
>> +
>> +GRUB Secure Launch support:
>> +
>> +https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub
>> +
>> +FOSDEM 2021: Secure Upgrades with DRTM
>> +
>> +https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
>> +
>> +.. [1]
>> +    MLE: Measured Launch Environment is the binary runtime that is measured and
>> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
>> +    requirements for the MLE in detail.
>> +
>> +.. [2]
>> +    ACM: Intel's Authenticated Code Module. This is the 32b bit binary blob that
>> +    is run securely by the GETSEC[SENTER] during a measured launch. It is described
>> +    in the Intel documentation on TXT and versions for various chipsets are
>> +    signed and distributed by Intel.
>   
> The formatting LGTM, thanks!
> 
> Regardless,
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you,
Ross

> 

