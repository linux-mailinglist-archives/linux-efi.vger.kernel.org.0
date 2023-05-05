Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38B16F892E
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjEETAh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjEETAg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:00:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A12154D;
        Fri,  5 May 2023 12:00:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhQ5G006361;
        Fri, 5 May 2023 18:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hov1Zo1lnPY6atYbUmrFa5EKgki3mIk0ZVqrusDVusk=;
 b=rs/uDbFYsE/NTeaGMPiiTCv1Xnch/CJ85Z3WW8lJDXmkNeUNPepWwNYTvEf9+lMpKXYJ
 Gaowi35FG+IWJhwuiMFoL3oSNWLp83W3zlptodOOd/T3kaeGw2nrKYf9FoH0VmLenrYM
 TfIxCVTzrvP5squahRIEyCblYTFb5gfIaZil96P/GZDe3pXzUhg25hmP62EGyuXTBYjl
 LpO8AigQnYGkyreJCM/GYOV8pRCRA3M1ARonVjIUzEm/JHHmLOnueLx+6CkJv4VS/t0F
 xcJtAd/FJ0vCVA7Vnb1RIa7G+tWkrfUynKpKgo/Fp0FG+guaUuxB7QpQbidJqivU8zaa 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4awe51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 18:59:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HVOkU009977;
        Fri, 5 May 2023 18:59:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spar1f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 18:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD0ii5d1mxlbvSMLgbG/AM8JvOHwvY5ryPnpMJbJ36TqrAWRHycbOG0CtLTY/rJR9LOuraJ1jzCccmBbD2QV9o7Qg7UILGlZh8xTmIohWq/pbjt83+h+erQKTtBitMTMIK043kgq2r6ZQYKdvSB2EHvqOPeHhS2v3pviIOAHSrshas9UcGPm/Dm3dcm4P6oecGU5rBgrC/xpnuoPCyidzmAiAp5+Ke9wHjRykI2xwhafMwMnnDaJXK9F2O1dIYlPoOT+BKd/PuX7tDWoLpEtBzOqvRpR8uOsmXYymzp5oRF3VI8XmG3Je4Jw1uty38R21yL8GFpYgNFLweqWsbXVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hov1Zo1lnPY6atYbUmrFa5EKgki3mIk0ZVqrusDVusk=;
 b=H8SGsqmI8WhbYy0wrN+kdM+4S8Npw7Qf8yjg/vpkrbTESnY4rDvvtW9sdskrPrJwKhnruXzuLpqkJBMXuvU12Xgacb+TPk0TQ22cJUCEwItYOwAMZCXPhdF9Mnu0FvaZH1fULbfrW8tpkwf53Hb9Op1nXL7fhmiwtzZlDe7gLdGyU3YJuZfPXXjd2iQIhk3mfce2kTahQN+BdlUd09Z5tfIM5ussZCNLk7DEAh7+gKVA96wuUKIz2F2HOl5v2o4nWpV5S9B/PSG700NMv7AOFoaLF/EKduE3m9nrOVwdlSH7xyGsYpVd5hAdMx5dh+4zGDPI8tltMVPTgY/HIgongw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hov1Zo1lnPY6atYbUmrFa5EKgki3mIk0ZVqrusDVusk=;
 b=jYtgB9SFGbP8H1qr6HAH6RfCEAWJ4210Z1CCHHfeHQ00vc+SffWdvRworEs+41AJBHlhrBbQXTdws24kenbWlC5l98dG2obQUW/dvNB1WT0clBTmM89V+PK5lgG/Sd2UswDjp3SmTQO6x6Tn3N6kGd0KxvSXEjM5HZbPVA6RsvY=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 18:59:28 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 18:59:28 +0000
Message-ID: <12e91cad-340c-cf90-ab10-16b099bb254f@oracle.com>
Date:   Fri, 5 May 2023 14:59:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-9-ross.philipson@oracle.com>
 <ZFVCZ1EDxQgdyocc@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFVCZ1EDxQgdyocc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:610:4c::17) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf74abc-6207-4cac-c8f3-08db4d9ada22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gh/KGENgzHzIzimH7KV082qPHdd10GSplup/3iQ/RemcXAqVgpTu/58TyKn3Uj/z25lMjhIP1O6bayvRIoavqmElZCbWm5xEMfD6KFJ8QhRlJ81IfkwCWYLgl0HRNBjzyH35rtqXFFq2qJkz+5JasYEgIHXgrkxjV6MAbe7TU0GM12YZ0H3KVGOoYBkQraKp0q4jdOY3sZOMHVb0t5gNawaiPYZtmjlWXGlI+3VC1dRGxEqkRbSGFiaLsmCbQMISPuL7FyxzUerj7XSF1DcoanVc7zSr/vOMoDPSwUACoNk9jlyVabka2X47g/CCkIxaN4vB4SMvApEGX0xS+kBObjBgchPyu8nd26UkChVm91Rg2T10I3PYlXbFGk0tmenVFsC0MpmDcwVgtW2iFGr7qmSHC9DmNYlE9Ym79m7rk6EuDl4jKqeu9zEpiISYx12G09aKlek67vxWj0rZ9ouJAceY82S4RAROA3bIJqRzB21EAGAHZXmEfJLKQx/o74dpF6Cr2oRLtCGR5C+xf0gp6XWXBvRKFyzPUQEcfJ+GZIg1qXBsMqFRsh+GQwEb/FE9hpXpaLHXtTWlcuALs/I6IJ1UVUBfbjpfpCtyFLD5vYeKOaow0c8iJJpzuw+X8bnH4hulWfvPXk3s34I6WXjA1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(2906002)(6916009)(8936002)(66556008)(66946007)(8676002)(316002)(4326008)(66476007)(31686004)(41300700001)(478600001)(7416002)(44832011)(6486002)(6666004)(6512007)(83380400001)(5660300002)(53546011)(6506007)(186003)(2616005)(36756003)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVUvcjZnVkxhZ05qR3NUckJjbXBPRmV2WkZRWjU4Mjc5WlZoTWZFVjA1dEhX?=
 =?utf-8?B?OVlYTGVCbVdMWnovUEVyZ3J5ZzR2TW9ScHBQVTgrc2x5WmFFOERRMy9jaHVr?=
 =?utf-8?B?WEI5UHl1RnhURXdQQWsvWTladjFsVWRXUHNkKytjZmtIbG4rb0NybEtpN2l0?=
 =?utf-8?B?V1hubDVkMTB2K2JiSjJ0VUlVSWpwTTVEWlc2V01mMmNRcDdDeWY0Vzd1bDl3?=
 =?utf-8?B?RC96ckR2d3p4OTludzhtS0FIREFKdmhNM1RFY1JTK2FTTXk5TGlUSU44SGtZ?=
 =?utf-8?B?TklmN2NHdWFWS296VllqTU5GY251aGVaYWNaY1VWOE8vam5IRXpaemwwM3VK?=
 =?utf-8?B?VVFPWVNzbE5IM044aWM2N1JxYXdZNGRRdWtmNXNzYk1BOVREbEFpUEs5dG1X?=
 =?utf-8?B?Um15cFdRS3BISnVSQktnTmhOcW5PQm01Z2ZhVEpUUkVrdTc0eVBrNysxNHJa?=
 =?utf-8?B?UWl0TU5BTFJPU2NDZGltV2tlbTVicHBJYzFUWjdBTUtRTHR4QTBjZEVaVnZt?=
 =?utf-8?B?Mm1md3VQbHoxVU9BeXUzUmVDSjJ6YWtUSU5sQ0c2Qi9KUW1naUN5TzhtU3A4?=
 =?utf-8?B?OFJGRkJJMlFrNnlkVnZmeEsrNGgyRTBaeEt6dFZXUVRUYUszL0xiaEpLbGlW?=
 =?utf-8?B?NW1pSnE5cEk3MU5ydU5tcmhBaUxPeEFzVnlVdEkxREYyTUxjeFRDUitkSDRv?=
 =?utf-8?B?K3BEQ1lidThDWExzd0VWeUo1blRtVjBYbUVMR3B5WnlSYmxiNE8rM05pZUx2?=
 =?utf-8?B?RU5hNHFabGhuRXEzTmNQdzBhai96U2ErdHU4angxSmpGTWl3RmJTanFsY2xO?=
 =?utf-8?B?b2JxT1E1OHl1REFwcjZ4SGF4N2lRUjl5TnR2UVVqTU5aTThCS25CVzl6QjBP?=
 =?utf-8?B?eEZLRG95Y004Y0FoQlpEOEJZWGhFcXExWXpYa252YWJyaWdSYnlvV2wzTFY1?=
 =?utf-8?B?WVVockFLWXRjM1A4WUdackQwL0FlbkNHcEFJU0FZSDJPNmdVeHg3clQrc0l5?=
 =?utf-8?B?UGJsVVZ0TzFiTGtJWUU0dnZiUXB3YWpNTXJVNnVSTE9PRU1DalNJWlVjYTEy?=
 =?utf-8?B?dGlMbnQvTU8vK21XUnBGSTN2aFkwTzg4cS94Qm5IbE1LSG8rc0pUc2xuZHhM?=
 =?utf-8?B?Zk1TMmp6ZW5hU3RhL3FodEFZd3NDTGg4ME9IbFdZWThzdlNsWTAxSkRvOGll?=
 =?utf-8?B?ay9NTnFyTzdlV2MvY0NGVnlmM015elhOMk9mMEpzWi8wSzZodmlBeEQxZ2dW?=
 =?utf-8?B?eFFqTThEVVFJbXZuT0VwaU1XRmUzbmZPbmJ5eEhoZnBRcm85T1JxNzEzSVU4?=
 =?utf-8?B?R3JHTTIzcmNyUDN6QmZsRW5DZy9VWW1iSHdVa3pIOEJCZSt2WlZaWXZGMG1Y?=
 =?utf-8?B?eWpEQkxhVmZxWTlZWTc0SWx6bC9sYVNmTlNKdTRSalRnV2lsRllGZjFYT0ZO?=
 =?utf-8?B?R1FUcEZxRlhmYld4b3Q5allxU3I0dVlFb2FZdDlEcGd2alcySmg0V1hkZ0px?=
 =?utf-8?B?V2FaVEFRMkhlMmI2UGhqL3FkbldEc3MwQVpMZ2RDRndKUTNLd1hINGtRbjJx?=
 =?utf-8?B?NS9TT1NpV1RsRm9NVGhCRkRLVFZkbTExdjFmSlBqdG44akF6Wm53TDRvcVF4?=
 =?utf-8?B?VVE3aldJSWVYRmNlOWpkWFptMmRLNVE2M2gwVTVjcnA3d1hjN01rdXBlMkhN?=
 =?utf-8?B?TklXUnR4eDVxZ21oZ1hSYWdZNVYzV1VoYTdQYVE4RmREcmZodnZkakhUNHZ3?=
 =?utf-8?B?Z2dwbzVsWUVWbUJsY0FBT2srOTNBWEpzTHB0UGoyU1dYWmNkZGVkaS9DbGtB?=
 =?utf-8?B?dkxpL3hjUVVnbkhwL2phWm1PSkIwZ05qWGpVcmsxSy9sckZ4TnorTVFvWHls?=
 =?utf-8?B?K05uMmxlWktZTUtUQmw0NmtjMFVxYWlmeDZDUk54SWo0WFdQaW03MWJjV2p5?=
 =?utf-8?B?d09ZbG9PSUN3MVVGcm1RME1RYVljdy9qWU5QcnFVOGJyWWJxZ3FpSWVmNVlM?=
 =?utf-8?B?TzAybER5TG4yQTFZa2V2ZzZRY0FRZGVKbk9QSUY4OThaRUg2aGlNVVNyQld5?=
 =?utf-8?B?VnFGNG1xbUkvbVk5N2ZGbmVONHFTM213M0s4NzVEVXRVdVVoNjBkY2lPd2g0?=
 =?utf-8?B?TkdLNGlGbnhhQ2Qxako2KzkxV0NBS2taZWk4NUMvUzFUa1pmbDdTUGlZalhl?=
 =?utf-8?Q?UbiPCEvKjVkyXW/KY6vcL6U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZGprb1ZxMzBUcW9NbS9ZbUcxQTVtL3pGSzdjQjFQdXJ4cmY5TG4wSEkxNFBW?=
 =?utf-8?B?S2dZczJIS0NtZU5Ud2dzemVjTHVBSTNIdmJnVFc4cEFXM0VFUURpa29EWXZY?=
 =?utf-8?B?cGUxSktNNE9md2RmcWNSemplM0pPSzZRN0F0NVJkTEpHTDA2SDFtSFZ4Z3BU?=
 =?utf-8?B?SGVJcHVzYnFzZVZZSmRjMGVxUkF2Z0RWbzBmSkVYMk5XUUdmSTVibEt2SmJa?=
 =?utf-8?B?MWxGMXQxTFc5Q2EvNHRjc3dLb2FjYjgvTnIxbmNycVVkSnd5L3VDaXZJRHVF?=
 =?utf-8?B?dXduV2JxTzB3VGZzTi8rVlRNM24zM3Q1MDFDQjNmVFpMK3pDTTg5Mlo5WlVk?=
 =?utf-8?B?L1RWSTNEeUNTRDg1b1FCZ3VLcVlZL3pBdU5pM2RCdURCcEJwazhsK1paTUNJ?=
 =?utf-8?B?TGszVndPZ0tGM05XWVp3Uzh6b1NkaFllM2d5VHdPOWhmMTZnQWtaTTk2YjF0?=
 =?utf-8?B?SmRBSzN2MGFyTWlvaCt3VlhlOURVZG5mRWEvb2Z3Zk9zTEU4SVFKZG1nN2t1?=
 =?utf-8?B?UlNCdWlFM2hzTWZrQXhkWUhBbDZBbzg0VzUwbklWMGJnQkxaWHhweXFtVVNy?=
 =?utf-8?B?bHV0bDF0dmFrYUU1MFExSFMwMVpjSWhiVzVINVQvNVFCUWlleHpSM08rQkph?=
 =?utf-8?B?WElGdk13aS81bUJVWmlscE5ZVDdyaDFjMnhFajhseWVpU0dRQjBWNVVocGxE?=
 =?utf-8?B?a3kvUlRJc0NQay8rWDcrSmtUS25ieHZmWkEwU1dMZjZSR3dRVExiUElsTE5l?=
 =?utf-8?B?Y0k5RklwbjVuRGpOOE95ZEJkYjJkckh0dXhRNEpnQ0lNMUJ4YzBEWFEzdVhy?=
 =?utf-8?B?dVNWTGgvb1d4bzNpemk5SlBwN2c4T2tIYUIzcU5BeVVnMExSUzBKNkdEVUhr?=
 =?utf-8?B?YlZNVTA2K0x4TVF3TWJpRzJJdGQxL0l3SEdabTVMcExWNzI1QTVXdnh1WDBw?=
 =?utf-8?B?ejlBN2tNMlhkRldOUXB5aWhpcGQ2VWhpanZsM3RENEFIR0F0Y3JrSFBFUnRu?=
 =?utf-8?B?YStqVW5UT0tRbUpkczl6UEdZYnRRYU1kQ0F5S3V3MmVuOHRZWHBXcjVlOXdp?=
 =?utf-8?B?dW1ZMy8rbm4wR0UwR05TQmZaLys3MDUrTklpUE01SXVOaE5NS1A0U01ZYkx5?=
 =?utf-8?B?NE80VGlmeDR0c1JTSE1BWmsxRCtPUmlZMTcwRXdFT1lJdkZMTmcyVDRNNnFR?=
 =?utf-8?B?N3hXU0ExNlpkVGNvdXJFcVA0anp0VGV1cXNScnlraEVyMEFOdzF3VlhuS25Z?=
 =?utf-8?B?TWEvM3k5UkNBVTBITVdJWkJ6NXNEam5ISU14V2VBS2FWNG04RzZVcFBnZENx?=
 =?utf-8?B?cEhuSG1mS0RpODFEK2lnR1R1UmNBTy92UHZSTTJSQWc4eXNQR09BNFdPUTJE?=
 =?utf-8?B?SVlIRTgvcjh3amJDMFJzVDlxWUZZZDdWdGNJUjJUY1RuRXdMaFNuaUNrakdL?=
 =?utf-8?B?Q3N4UTdITFNZamRPWk0yeU9hcVRBbWVrWjBJUFFIak8zMGZMTjdtWXdtdS9z?=
 =?utf-8?B?MXJKZkxXbDl0NjZ0Ump5SytYWDJ2SFZpTmNIRWFLWFp2TFpSWTFqaWdyYWpK?=
 =?utf-8?B?MGRaeVBLQkNscDJjemkyRVE5R3RHbCtlRXNZOFZ2T3BXUC9RV0ZOeHk4UjY2?=
 =?utf-8?B?T1FCRVM2dWxXNW1ndFRDV2NJc1VScWFsdkJOMy9tc3JyR1NUZjVXSmVuWkRX?=
 =?utf-8?B?VHZEc3RtaElRSkF6SUVJKzdSVlg0UE0yNS9udURlOGYvMTJmOHRPNFNqbVp3?=
 =?utf-8?Q?QnabJinHvUE42HsZAs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf74abc-6207-4cac-c8f3-08db4d9ada22
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:59:28.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1+lRPm9qGjLkF/roGwrBb5REdCK5JC2i7zx6y3oqob0FVU3jCx2/93E3NxlrnZdhcuYYFaoBrGy+d0vYHnYplZVoP3o0zxGXDl7ATXQhuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_25,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050156
X-Proofpoint-GUID: HcDV2fjBMqNXuqLCEyHslCsOUo_qow11
X-Proofpoint-ORIG-GUID: HcDV2fjBMqNXuqLCEyHslCsOUo_qow11
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 13:52, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:17PM +0000, Ross Philipson wrote:
>> The routine slaunch_setup is called out of the x86 specific setup_arch
>> routine during early kernel boot. After determining what platform is
>> present, various operations specific to that platform occur. This
>> includes finalizing setting for the platform late launch and verifying
>> that memory protections are in place.
>>
>> For TXT, this code also reserves the original compressed kernel setup
>> area where the APs were left looping so that this memory cannot be used.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Hi Ross,
> 
> a few nits from my side.

Yup we will fix all of those.

Thanks
Ross

> 
>> +/*
>> + * The TXT heap is too big to map all at once with early_ioremap
>> + * so it is done a table at a time.
>> + */
>> +static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
>> +					     u32 bytes)
>> +{
>> +	u64 base, size, offset = 0;
>> +	void *heap;
>> +	int i;
>> +
>> +	if (type > TXT_SINIT_TABLE_MAX)
>> +		slaunch_txt_reset(txt,
>> +			"Error invalid table type for early heap walk\n",
>> +			SL_ERROR_HEAP_WALK);
> 
> nit: the indentation should align to the opening '('.
> 
> 		slaunch_txt_reset(txt,
> 				  "Error invalid table type for early heap walk\n",
> 				  SL_ERROR_HEAP_WALK);
> 
> Likewise in a few other places in this patch.
> 
> ...
> 
>> +static void __init slaunch_txt_reserve_range(u64 base, u64 size)
>> +{
>> +	int type;
>> +
>> +	type = e820__get_entry_type(base, base + size - 1);
>> +	if (type == E820_TYPE_RAM) {
>> +		pr_info("memblock reserve base: %llx size: %llx\n", base, size);
>> +		memblock_reserve(base, size);
>> +	}
>> +}
>> +
>> +/*
>> + * For Intel, certain regions of memory must be marked as reserved by putting
>> + * them on the memblock reserved list if they are not already e820 reserved.
>> + * This includes:
>> + *  - The TXT HEAP
>> + *  - The ACM area
>> + *  - The TXT private register bank
>> + *  - The MDR list sent to the MLE by the ACM (see TXT specification)
>> + *  (Normally the above are properly reserved by firmware but if it was not
>> + *  done, reserve them now)
>> + *  - The AP wake block
>> + *  - TPM log external to the TXT heap
>> + *
>> + * Also if the low PMR doesn't cover all memory < 4G, any RAM regions above
>> + * the low PMR must be reservered too.
> 
> nit: s/reservered/reserved/
> 
>> + */
>> +static void __init slaunch_txt_reserve(void __iomem *txt)
>> +{
>> +	struct txt_sinit_memory_descriptor_record *mdr;
>> +	struct txt_sinit_mle_data *sinit_mle_data;
>> +	u64 base, size, heap_base, heap_size;
>> +	u32 mdrnum, mdroffset, mdrslen;
>> +	u32 field_offset, i;
>> +	void *mdrs;
>> +
>> +	base = TXT_PRIV_CONFIG_REGS_BASE;
>> +	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
>> +	slaunch_txt_reserve_range(base, size);
>> +
>> +	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
>> +	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
>> +	slaunch_txt_reserve_range(heap_base, heap_size);
>> +
>> +	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
>> +	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
>> +	slaunch_txt_reserve_range(base, size);
>> +
>> +	field_offset = offsetof(struct txt_sinit_mle_data,
>> +				sinit_vtd_dmar_table_size);
>> +	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
>> +						  field_offset);
>> +
>> +	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
>> +	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
>> +
>> +	txt_early_put_heap_table(sinit_mle_data, field_offset);
>> +
>> +	if (!mdrnum)
>> +		goto nomdr;
>> +
>> +	mdrslen = mdrnum * sizeof(struct txt_sinit_memory_descriptor_record);
>> +
>> +	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
>> +					mdroffset + mdrslen - 8);
>> +
>> +	mdr = mdrs + mdroffset - 8;
>> +
>> +	for (i = 0; i < mdrnum; i++, mdr++) {
>> +		/* Spec says some entries can have length 0, ignore them */
>> +		if (mdr->type > 0 && mdr->length > 0)
>> +			slaunch_txt_reserve_range(mdr->address, mdr->length);
>> +	}
>> +
>> +	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
>> +
>> +nomdr:
>> +	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
>> +				  ap_wake_info.ap_wake_block_size);
>> +
>> +	/*
>> +	 * Earlier checks ensured that the event log was properly situated
>> +	 * either inside the TXT heap or outside. This is a check to see if the
>> +	 * event log needs to be reserved. If it is in the TXT heap, it is
>> +	 * already reserved.
>> +	 */
>> +	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
>> +		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
>> +
>> +	for (i = 0; i < e820_table->nr_entries; i++) {
>> +		base = e820_table->entries[i].addr;
>> +		size = e820_table->entries[i].size;
>> +		if ((base >= vtd_pmr_lo_size) && (base < 0x100000000ULL))
> 
> nit: unnecessary parentheses
> 
>> +			slaunch_txt_reserve_range(base, size);
>> +		else if ((base < vtd_pmr_lo_size) &&
>> +			 (base + size > vtd_pmr_lo_size))
>> +			slaunch_txt_reserve_range(vtd_pmr_lo_size,
>> +						  base + size - vtd_pmr_lo_size);
>> +	}
>> +}
>> +
>> +/*
>> + * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
>> + * It is stored in the TXT heap. Fetch it from there and make it available
>> + * to the IOMMU driver.
>> + */
>> +static void __init slaunch_copy_dmar_table(void __iomem *txt)
>> +{
>> +	struct txt_sinit_mle_data *sinit_mle_data;
>> +	u32 field_offset, dmar_size, dmar_offset;
>> +	void *dmar;
>> +
>> +	memset(&txt_dmar, 0, PAGE_SIZE);
>> +
>> +	field_offset = offsetof(struct txt_sinit_mle_data,
>> +				processor_scrtm_status);
>> +	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
>> +						  field_offset);
>> +
>> +	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
>> +	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
>> +
>> +	txt_early_put_heap_table(sinit_mle_data, field_offset);
>> +
>> +	if (!dmar_size || !dmar_offset)
>> +		slaunch_txt_reset(txt,
>> +				  "Error invalid DMAR table values\n",
>> +				  SL_ERROR_HEAP_INVALID_DMAR);
>> +
>> +	if (unlikely(dmar_size > PAGE_SIZE))
>> +		slaunch_txt_reset(txt,
>> +				  "Error DMAR too big to store\n",
>> +				  SL_ERROR_HEAP_DMAR_SIZE);
>> +
>> +
> 
> nit: one blank line is enough
> 
>> +	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
>> +					dmar_offset + dmar_size - 8);
>> +	if (!dmar)
>> +		slaunch_txt_reset(txt,
>> +				  "Error early_ioremap of DMAR\n",
>> +				  SL_ERROR_HEAP_DMAR_MAP);
>> +
>> +	memcpy(&txt_dmar[0], dmar + dmar_offset - 8, dmar_size);
>> +
>> +	txt_early_put_heap_table(dmar, dmar_offset + dmar_size - 8);
>> +}
> 
> ...
> 
>> +/*
>> + * Intel TXT specific late stub setup and validation.
>> + */
>> +void __init slaunch_setup_txt(void)
>> +{
>> +	u64 one = TXT_REGVALUE_ONE, val;
>> +	void __iomem *txt;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_SMX))
>> +		return;
>> +
>> +	/*
>> +	 * If booted through secure launch entry point, the loadflags
>> +	 * option will be set.
>> +	 */
>> +	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
>> +		return;
>> +
>> +	/*
>> +	 * See if SENTER was done by reading the status register in the
>> +	 * public space. If the public register space cannot be read, TXT may
>> +	 * be disabled.
>> +	 */
>> +	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
>> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
>> +	if (!txt)
>> +		return;
>> +
>> +	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
>> +	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
>> +
>> +	/* SENTER should have been done */
>> +	if (!(val & TXT_SENTER_DONE_STS))
>> +		panic("Error TXT.STS SENTER_DONE not set\n");
>> +
>> +	/* SEXIT should have been cleared */
>> +	if (val & TXT_SEXIT_DONE_STS)
>> +		panic("Error TXT.STS SEXIT_DONE set\n");
>> +
>> +	/* Now we want to use the private register space */
>> +	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
>> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
>> +	if (!txt) {
>> +		/* This is really bad, no where to go from here */
>> +		panic("Error early_ioremap of TXT priv registers\n");
>> +	}
>> +
>> +	/*
>> +	 * Try to read the Intel VID from the TXT private registers to see if
>> +	 * TXT measured launch happened properly and the private space is
>> +	 * available.
>> +	 */
>> +	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(val));
>> +	if ((val & 0xffff) != 0x8086) {
>> +		/*
>> +		 * Can't do a proper TXT reset since it appears something is
>> +		 * wrong even though SENTER happened and it should be in SMX
>> +		 * mode.
>> +		 */
>> +		panic("Invalid TXT vendor ID, not in SMX mode\n");
>> +	}
>> +
>> +	/* Set flags so subsequent code knows the status of the launch */
>> +	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT);
> 
> nit: spaces around '|'
> 
> ...
> 

