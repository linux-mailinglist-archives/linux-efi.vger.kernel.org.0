Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB4700C70
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbjELP7i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbjELP7h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 11:59:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B872683;
        Fri, 12 May 2023 08:59:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4BkS002662;
        Fri, 12 May 2023 15:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jykXnPcXDZAxc4Q3H/L+VAUrKJnz827BenC8D2fivTs=;
 b=DTffjniWgihX5U28crPUO5rMz45JWV/FOq5RtncfP5jNh/29FdW6OaPcyJnckIErJeaS
 AW2zvTnt7GLDifBU1Pbmk49+GlysrR6cMeQYO4c3iLbiPMGdg2dVDQetzzv4pO8JPFH6
 GqjiCox6eLTlObEFwiFxrySDL7SN9j6UKuGte8H9yeZLwxmNCSYnNY5DWToiDHv6m6j/
 AR5eixgs8X6WfmSA/1piJykSCVd/EA7A48hVIEY4ljjc8Mfhqe1TIK0Qf0tI7HkLJIgP
 i9sfifaeH5glXuUKAZ1dnv99rNoERPVDg4sDjU27XH/0PGd7FQyiQoX4OIDeFX4g+tJc vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777b16d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:59:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEdfuR011571;
        Fri, 12 May 2023 15:58:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8151r3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONeuZDj0scmvcoJ/wf9jfxnyXynQU2Gy9mdss65XRtBknlwNMv0/RymdSRWXS4XavI1HAflB5CZ8uG87PR2ir8b4p0fBIukiEGCkyRzqX91EaCYLEheQyblZZWr6dpQiYSKOqBLvWJia1Knmxnbw8mg8iJX/CMk4oyj69gtjANxIYzYDlTWxk+qp+eHIy/42DSc7vSRILaazeMcKCUc78Hv+gyTOxafRzUvDzFlq+2r48sAIhb99xMmvcKR1OqLyJEcsXrCx18/IzwE60XR3I2rH5AAL9G8k4V1e5kDk/J95Iw2EaAsm+A32CgZB4K8WJMpjZdzQCCRjsD07FgslHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jykXnPcXDZAxc4Q3H/L+VAUrKJnz827BenC8D2fivTs=;
 b=QeJrEgUHp0abKF2ea4InHm4l1HTQuoVYYWsSLa/6OWhmmc1B1THRvgldMDcD4xzO5Is6Cfkv+gXxzCsqSfjOTkmdr4eUN9q2k2xg+kkRc86yvjDf++L8mJA+TGQDvnKZuDI8x3xFDdtnHD0JeGcEfMxLDYsz7+CyOCaYKjhPzTglhLxOs0oAnglJDWfGVLUbptgEvW3/ybNlJoG2WnrkrgP6HqOb1M98rXcgOXqO8v51bPjBbYnWC7kCyjbeNB1hb2WnMIdtefB49DCfBvq0nKQfu5nAXH73fESBhbEX+Z1vnU7EvWKGaYpgTT9P0Y47O1n1ELAiDOB3CcuDu2wj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jykXnPcXDZAxc4Q3H/L+VAUrKJnz827BenC8D2fivTs=;
 b=kegKzbDC6wt21rZhE9m1gSCHJJGXE9xqbsz8lbTOcG8csMh0cyBeKdkx8SXhpDUjkF3umAPNAiBkKV3pC2pWsXsuCc+9cikreu1Iw5VbmETHvX8fO9NDMNM3SlRT5H8Fbrcc5qEowuhZf9FmWRkdzQ7na9EFFyjPiTHxlOwnHo4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by SJ2PR10MB7084.namprd10.prod.outlook.com (2603:10b6:a03:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 15:58:55 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 15:58:55 +0000
Message-ID: <dbc9a961-aacf-d3ac-2227-73ff17d48e1b@oracle.com>
Date:   Fri, 12 May 2023 11:58:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-9-ross.philipson@oracle.com>
 <CSIZ0OTO074D.1LV8KCZM306II@suppilovahvero>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <CSIZ0OTO074D.1LV8KCZM306II@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:408:fb::19) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|SJ2PR10MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ca858b-e06e-4076-278d-08db5301c99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GO8q1VYj03L6n0TV6fdY8nLq9BY2xDJo6eIl20fVge83AFF1wEUVW6SHccVXb/v7VYb0Ozo9nUlGopS64H7waSpyWHUET9pnYjgZrc/GuLDe4O7H/OBIK9N3MbqEA6Mxa7fvx/DrO2Mg0AJyz5mTVtcat8FUv9csfejmBVu2477QoDA+jv3OZjFk0zW1XfQLBUDC9nhDpZJxfYoj3Aaq4fAxn0DoWl1a52otFaA8UKkI2r0niGf6sQoxa1UODRaN8v6O0S27Ockzf8kSHHW6xsp9SqNzr2425rCdhRxRJK9I5bN+Aub8IaS2jlUr/DLIJRXKYlrxEz5JRqergCMVK2AxGxupgcy09I1pnDGNgstyfcGIbcoouj9eVybnw9c3hQ0plM/PbsS8n6G35FGy8bvD0ISZVk8CSaC7/AZAL3X5cU5cbrAIW5C/DJcSZneQAWbPgHaU353bM3VeiXMEILqIgY9nsLTG66BrxkgVroSnd/y9CU4c8BI7KV68v+G/RnBn57Ea9kEsBRaw6+DvG+xAJrO/BxTHFjYjEwTPfmLeDUC5F7Kb7vKeg11HLpr2XsDDTHfNjYNGRv028vRrJ3Wd0iVnxVEQIPxEYkBmWkdbRbbqLNxwLTAhe3rS4mr2cBdmFVGxjQOZuTW20gfEWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(31686004)(316002)(8676002)(44832011)(41300700001)(36756003)(31696002)(86362001)(30864003)(2906002)(7416002)(38100700002)(8936002)(5660300002)(66476007)(478600001)(6512007)(83380400001)(66946007)(6666004)(53546011)(66556008)(186003)(4326008)(107886003)(6486002)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhVVkV2ejdGa2JRT1I0ZTVEOGRMSHFPTVhINFo0c2pYV1ZoK0Q4TzNzS2hS?=
 =?utf-8?B?eFp6RkV4L256ckVSN25ocHVaL1pLZzZiY0w2aGZpY0pUSC82bWNwOGgrNUZT?=
 =?utf-8?B?QWpISzJsSStrU0d3QWx1RlZ6R2ZTcDRBaXNMMWVBUitpRTF6UGZKeWRGczdS?=
 =?utf-8?B?K2dqUTc4dUpzMHlJMVUwaWp2WFYvczNBa3lzWEpyTlYwdjFaeWRKRXM2MStZ?=
 =?utf-8?B?ZWdwL2hEMDQ1U05qQmhzR3VMN0lFdE4vT283NE5xN01JWFNTZ2g4RndqM0U0?=
 =?utf-8?B?R1U2aUVXdWVRQ1h3eFN3Z3VWUk1NWjZrQmNyc2JaRVU5S3VzMjhEcVVIY01Y?=
 =?utf-8?B?Mk9FMG10OEdmTGhxSTRBMHE0NkJMMnV0Um9sbS92Y1FLb294TElrTmxINmEv?=
 =?utf-8?B?TzdzTUhSTG5sVExIdFJVY3J2QWgzZnRqMG5NbjZHL1NvODZjUWl3MVdPM2sv?=
 =?utf-8?B?RmdHbGtOQ2tiZi9PUUQ5RWFsTzhTdFRCcFBXZ0hsQmpJZDdaZmZIOXVYNmlY?=
 =?utf-8?B?b3dEZUs0by90Nk5xbVR1cjBZSWdXUEg1c3dEd1E3T3V5dS93ZStCSjBYQ1hJ?=
 =?utf-8?B?SUQrSUpyTm03cTArRkRJWUtPZzh1TTNKaFRSU3luMmZSZkNIV2hCZGRUdnNE?=
 =?utf-8?B?dzh2U0s1d3BTbGgrbjZzRGhZd0NIcVE5RUJtQWpFcnJkKzRlNzJZSWkwdkpZ?=
 =?utf-8?B?WWVZMWNFTldrSHNLL29wWnZnMWl5Y3pCbkMxVWZtNklPakJ1ckdHWktPQUg3?=
 =?utf-8?B?MEtNT1RSM0ZBOVBZYStjb3o5d2FtVUFUaWdxdEJSditEUjh2NHh4Y1hSZDh6?=
 =?utf-8?B?TElTV3hsZUplbXNvZTRHblkvSHJjMUxYdTAyNE00OXpqV21sVHlFbnRaVGZY?=
 =?utf-8?B?V0d5ZXpIMzR4dDY4aHlibXNlY1JHNE5lL0pVMVptZ1BpRytvZ0RPemdSQjBP?=
 =?utf-8?B?eFFkNFVXRTJLa0k1VVVpUDk2bFlZc2FsN282aXg1OVdrMGVTbVFaMTh1WFA4?=
 =?utf-8?B?S0EyRkhWbklGRTdmQ0pHZXRvbk43eXRjdGxKTU53d3JVMFZaMngwbXVTQ0ti?=
 =?utf-8?B?ZCtSUDkvay9ocGU5SFUyN3EzZVVwT3YycmtZUVI1dnY5V0U1NlkwMkVVQTVM?=
 =?utf-8?B?Tm9WSmkvYWpQR3RRa1pwSlZwZ0pvMmMzRkdScjNaU1VhWUFSRFFnSlk3eW5P?=
 =?utf-8?B?OW12Y2psV1A0WGlyNDNjRk5CMEIyRUhMRUFLOVNOVTdwVkd1SmRDUkYzbTRi?=
 =?utf-8?B?NW5jMjFERjVsNzRIcHlwdXc3ZGFIQXJjejJGUy9vRW9JQnJUcXNHTXVjU0ZE?=
 =?utf-8?B?OXRqUzcxdVJqMk9Dc3JJbm9MZHVCNENOMjRQejVqd1Jrclg3ZDUxY3JMSjln?=
 =?utf-8?B?d0h4a2hlVjNpNlAxTkQwVE1neEw1T01RUStIcjZLbXorVE9PU3ZKMDhsZGdw?=
 =?utf-8?B?T2lWVUt6NlhyZW1zUVliQnFFc1RiY1RMTWJPTURsdjJMaUhRUjVrcit6cnEw?=
 =?utf-8?B?amRvS3NQTmJzRVJWUUs0V29BYjdxYmpOb0NwaGRIekN4NFNyUXRZZ29qNVFj?=
 =?utf-8?B?UE1QUzVpR1RmMnR4WDVkMzNwYVpYMmdhT0phVTBrdWE3R2RTMk83Q1B2OTYy?=
 =?utf-8?B?bnNGMmZqUjAvaWRxbVhLaC8zN1FySEhuSFRmdnJzOGZ2TzVYRllCQWQ2MnRu?=
 =?utf-8?B?K3Y3UDF4ZEZrMVJ3d29oc21uemNRT3JqN0FwdzlVTkFNZXpTT09HaVRLTmwx?=
 =?utf-8?B?YmptdTV2WTNYRkxVVHhDVmdyUDdldG1pMklPVmZ1c3p0ajFSVmN6aTY4ZGR1?=
 =?utf-8?B?S3d1Q3YrMWVlWE1HcllZNnZmUVVMRURzWDV3QTE0TVZ2VGVOOHVETE8vYjNq?=
 =?utf-8?B?Sjllb3RIbkZNV2ZvdGpkMkNiNDhxOW9UT0RPZUdpVnMyWUJjUkZtODMrYmJW?=
 =?utf-8?B?MjhHbGxCdWt5L2taVnhwRDVrM056YlZva0gzT2tUSllVWGV5Sy9oWjdTUHhD?=
 =?utf-8?B?UVFoNVBjcEZhWkkrU1lGemFXYWE3RHkwTU9JTWxUV3MvV2Y5dlZyd3ZPeXNt?=
 =?utf-8?B?UzN5ZHhvZS9CVXgxZFZFYW1ycFNkakNhY3Z5Vm51bzVQbVMzdkljS2dqcmJG?=
 =?utf-8?B?TkJvaThBM2RDZ2tJNWhlY1poM0ZsS3JwUytFd2hVOWhJaGRhQmRRTjdmRDB3?=
 =?utf-8?Q?eDj5piYWRVWIacTSshkLDQ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b3hFL2JuRWsxTUo2L2xhVzI3RTR6dVRXdW1vcys0OWVINS9FOU0zbkpkajZn?=
 =?utf-8?B?NGhGSWs4SXFXeWNoWlZHWjduMFdKSzEwY3Nmc0lpb1QyMytRak1hM1c1WERY?=
 =?utf-8?B?WVZnNk9sYUk5Nyt5M3lXV28zM0hNSXVqMlgxRERDY05wT3JDRlVXWnVjVjNt?=
 =?utf-8?B?VkJhVGlGeEtKeEJmc2l2enpDTE1sZHVQUElrQ3VETnNlWlBDdUZZOHNnblI3?=
 =?utf-8?B?QVJpeWhrNUwwcUR3RUNWdEt4ZUh3SlY4K3BvTnY5alJUaVZhZHp2SlU4c1ZN?=
 =?utf-8?B?bHh1OWxqSnllckdDbDVaVjl6Mjd2QjFMQVpDL3VldkVOQ0pmU3JjcUFNSDVF?=
 =?utf-8?B?UnRuWEZmUG9XSC9NRG1PVlplNlltbXJ4eEFpbkZHdVdVa08yQnFFRm1zd2FS?=
 =?utf-8?B?Yy91QThQU0hPMnJnSFJPSUpEOUFSYlRHdGxlVGxocjd6anNndncvRFpBVlZz?=
 =?utf-8?B?UDFzRGVYYlZtNE5reElycnZYc1hYcERlRE56Y2RRd0N0dXhpY1p4V2xQUlk3?=
 =?utf-8?B?Z0VleW93ZTNjWEl2YzdzR2ErMUJBd0FsNEtGVFMwVy9mUkFhTkxmS2JCMkwr?=
 =?utf-8?B?OWxmWUw1b01JemNtTFZsNEFsK0pKMnJMa0htU05wdjh6RnpzSnV4dUZsT2lr?=
 =?utf-8?B?R3RFWVJ3bjNMWWJNbnNjVThUeXIreGI1aWZ4OUdyVXVCU0h2SHFsOTlVdENH?=
 =?utf-8?B?c2ZKU0w2RnFkakgxamhSdXRqTG1sY3lhTjBOTDRNZUhqQVJBZG56RTJOZWtr?=
 =?utf-8?B?SG9ZaUxnbGNRY3V0czVtUmpnS2ZNWGYySlNnbzRFVlJmRkQ5YmdhUmlsbzJt?=
 =?utf-8?B?SDlyTFo1UXFXRzJqQ0xOOGU2NlEzaWZOVUVjRFgxKy9FY1RpaWJlVHVrREtK?=
 =?utf-8?B?MVNoMXpScFZUSXNwMmR5d2FxRVBWTUEzOUZWZFJ1bzlwZW13anROUWZJRTBV?=
 =?utf-8?B?OWVNUUF3U0ZGakFMWU1YbXFpdTdQMExFaHR6NGdQSDEzWWg2Umd6bC9sN21w?=
 =?utf-8?B?MXhIRC9jeW5WOUVHRTV1Rkg0ZzZsTFZnOVNKcEVrYkhadHNSSHluVjVJUUhi?=
 =?utf-8?B?Y1FyUGt3VTRMTzRaS3RUcDVsaDc0bzFIR2lmcnRQTEZRNU1MRnRjRU93ZE1w?=
 =?utf-8?B?UUtqZ2lUZ2loMG1uYVBmQXRJREdEQU1id2F2TTR1dlRKTUNwVXAyZ1RwdTJl?=
 =?utf-8?B?VktHemNvaVlrYWJxZ3dGM0trZU12U1AxU2tId3VZNUJpVGNTTzFUbVQralBY?=
 =?utf-8?B?RGZDNHRnYzZ1RVlHeldudUtEeCtab3dyck5UM3RDRzFlQWdwV25LZGxhYWxw?=
 =?utf-8?B?Sm0zbFYrUVJ4dFlOZVMyTER4WWhnODZsZkdaWTI2bDZ5TVdwTU1vQTEvRlFS?=
 =?utf-8?B?dWJmZnZFdTNCSmhieXZOclpiWFNPK2lwTlBJTVZWLzE5VFRkam5xNnF4amhT?=
 =?utf-8?B?M0lYVlExRFdWbGpuV3drNURXQU5CVU91Y3dwbVUxZVBYd2RiSjhCUlRTMllz?=
 =?utf-8?B?Yk1QL0FIZGpnclY3cDRSZnQ0MW9VN1NTR0JQT0tDVWE4aWZ2ZjlCU3IxQnN2?=
 =?utf-8?B?L0VLcDdPRHowdWhocG1raDQ2S21wMlBmZlVqRUFCc2xxdDJRVGY5NDJKSFp1?=
 =?utf-8?B?elZwRTh0OVhvYXpCcTQyWlVDdjlqbnRTUEFIMnQ3cWNUYnBxSkwycjVxMHlC?=
 =?utf-8?B?RXFhTXNRTC9vZTJHblVQTWZrem43M3BqVkY3NUkwNTZpZzlESzdvVVdGcXdh?=
 =?utf-8?Q?zogoxmuBN8lUDpYvJQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ca858b-e06e-4076-278d-08db5301c99c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:58:55.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhbayKZ0ePOaZL5RLTqBLDdGi1XzFGMR6hknx6iMKuLQPCPqx/8bQbTihSAl8Bnah4wBx+CTe5+ajQMyuLgFj7pHOX9NXpAWurQzg+CrR6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120133
X-Proofpoint-GUID: YbMhg6wHjZOTo-zLP0rza4tQe3UzwZHz
X-Proofpoint-ORIG-GUID: YbMhg6wHjZOTo-zLP0rza4tQe3UzwZHz
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/10/23 19:02, Jarkko Sakkinen wrote:
> On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
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
>> ---
>>   arch/x86/kernel/Makefile   |   1 +
>>   arch/x86/kernel/setup.c    |   3 +
>>   arch/x86/kernel/slaunch.c  | 497 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/intel/dmar.c |   4 +
>>   4 files changed, 505 insertions(+)
>>   create mode 100644 arch/x86/kernel/slaunch.c
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index dd61752..3d2a33e 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -72,6 +72,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
>>   obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>>   obj-y				+= step.o
>>   obj-$(CONFIG_INTEL_TXT)		+= tboot.o
>> +obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
>>   obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
>>   obj-y				+= stacktrace.o
>>   obj-y				+= cpu/
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 16babff..592c09e 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/root_dev.h>
>>   #include <linux/hugetlb.h>
>>   #include <linux/tboot.h>
>> +#include <linux/slaunch.h>
> 
> Only because of pure curiosity: what made you choose this location in
> the middle for the new include? :-)

Only because Secure Launch is like TBOOT. No other real reason.

> 
>>   #include <linux/usb/xhci-dbgp.h>
>>   #include <linux/static_call.h>
>>   #include <linux/swiotlb.h>
>> @@ -1063,6 +1064,8 @@ void __init setup_arch(char **cmdline_p)
>>   	early_gart_iommu_check();
>>   #endif
>>   
>> +	slaunch_setup_txt();
>> +
>>   	/*
>>   	 * partially used pages are not usable - thus
>>   	 * we are rounding upwards:
>> diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
>> new file mode 100644
>> index 0000000..7dba088
>> --- /dev/null
>> +++ b/arch/x86/kernel/slaunch.c
>> @@ -0,0 +1,497 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Secure Launch late validation/setup and finalization support.
>> + *
>> + * Copyright (c) 2022, Oracle and/or its affiliates.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/linkage.h>
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/security.h>
>> +#include <linux/memblock.h>
>> +#include <asm/segment.h>
>> +#include <asm/sections.h>
>> +#include <asm/tlbflush.h>
>> +#include <asm/e820/api.h>
>> +#include <asm/setup.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>> +
>> +static u32 sl_flags;
>> +static struct sl_ap_wake_info ap_wake_info;
>> +static u64 evtlog_addr;
>> +static u32 evtlog_size;
>> +static u64 vtd_pmr_lo_size;
>> +
>> +/* This should be plenty of room */
>> +static u8 txt_dmar[PAGE_SIZE] __aligned(16);
>> +
>> +u32 slaunch_get_flags(void)
>> +{
>> +	return sl_flags;
>> +}
>> +EXPORT_SYMBOL(slaunch_get_flags);
>> +
>> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
>> +{
>> +	return &ap_wake_info;
>> +}
>> +
>> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
>> +{
>> +	/* The DMAR is only stashed and provided via TXT on Intel systems */
>> +	if (memcmp(txt_dmar, "DMAR", 4))
>> +		return dmar;
>> +
>> +	return (struct acpi_table_header *)(&txt_dmar[0]);
>> +}
>> +
>> +void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +				  const char *msg, u64 error)
>> +{
>> +	u64 one = 1, val;
>> +
>> +	pr_err("%s", msg);
>> +
>> +	/*
>> +	 * This performs a TXT reset with a sticky error code. The reads of
>> +	 * TXT_CR_E2STS act as barriers.
>> +	 */
>> +	memcpy_toio(txt + TXT_CR_ERRORCODE, &error, sizeof(error));
>> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
>> +	memcpy_toio(txt + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
>> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
>> +	memcpy_toio(txt + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
>> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
>> +	memcpy_toio(txt + TXT_CR_CMD_RESET, &one, sizeof(one));
>> +
>> +	for ( ; ; )
>> +		asm volatile ("hlt");
>> +
>> +	unreachable();
>> +}
>> +
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
> Align with 'txt'.

Ack

> 
>> +
>> +	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
>> +	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
>> +
>> +	/* Iterate over heap tables looking for table of "type" */
>> +	for (i = 0; i < type; i++) {
>> +		base += offset;
>> +		heap = early_memremap(base, sizeof(u64));
>> +		if (!heap)
>> +			slaunch_txt_reset(txt,
>> +				"Error early_memremap of heap for heap walk\n",
>> +				SL_ERROR_HEAP_MAP);
>> +
>> +		offset = *((u64 *)heap);
>> +
>> +		/*
>> +		 * After the first iteration, any offset of zero is invalid and
>> +		 * implies the TXT heap is corrupted.
>> +		 */
>> +		if (!offset)
>> +			slaunch_txt_reset(txt,
>> +				"Error invalid 0 offset in heap walk\n",
>> +				SL_ERROR_HEAP_ZERO_OFFSET);
>> +
>> +		early_memunmap(heap, sizeof(u64));
>> +	}
>> +
>> +	/* Skip the size field at the head of each table */
>> +	base += sizeof(u64);
>> +	heap = early_memremap(base, bytes);
>> +	if (!heap)
>> +		slaunch_txt_reset(txt,
>> +				  "Error early_memremap of heap section\n",
>> +				  SL_ERROR_HEAP_MAP);
>> +
>> +	return heap;
>> +}
>> +
>> +static void __init txt_early_put_heap_table(void *addr, unsigned long size)
>> +{
>> +	early_memunmap(addr, size);
>> +}
>> +
>> +/*
>> + * TXT uses a special set of VTd registers to protect all of memory from DMA
>> + * until the IOMMU can be programmed to protect memory. There is the low
>> + * memory PMR that can protect all memory up to 4G. The high memory PRM can
>> + * be setup to protect all memory beyond 4Gb. Validate that these values cover
>> + * what is expected.
>> + */
>> +static void __init slaunch_verify_pmrs(void __iomem *txt)
>> +{
>> +	struct txt_os_sinit_data *os_sinit_data;
>> +	u32 field_offset, err = 0;
>> +	const char *errmsg = "";
>> +	unsigned long last_pfn;
>> +
>> +	field_offset = offsetof(struct txt_os_sinit_data, lcp_po_base);
>> +	os_sinit_data = txt_early_get_heap_table(txt, TXT_OS_SINIT_DATA_TABLE,
>> +						 field_offset);
>> +
>> +	/* Save a copy */
>> +	vtd_pmr_lo_size = os_sinit_data->vtd_pmr_lo_size;
>> +
>> +	last_pfn = e820__end_of_ram_pfn();
>> +
>> +	/*
>> +	 * First make sure the hi PMR covers all memory above 4G. In the
>> +	 * unlikely case where there is < 4G on the system, the hi PMR will
>> +	 * not be set.
>> +	 */
>> +	if (os_sinit_data->vtd_pmr_hi_base != 0x0ULL) {
>> +		if (os_sinit_data->vtd_pmr_hi_base != 0x100000000ULL) {
>> +			err = SL_ERROR_HI_PMR_BASE;
>> +			errmsg =  "Error hi PMR base\n";
>> +			goto out;
>> +		}
>> +
>> +		if (PFN_PHYS(last_pfn) > os_sinit_data->vtd_pmr_hi_base +
>> +		    os_sinit_data->vtd_pmr_hi_size) {
>> +			err = SL_ERROR_HI_PMR_SIZE;
>> +			errmsg = "Error hi PMR size\n";
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Lo PMR base should always be 0. This was already checked in
>> +	 * early stub.
>> +	 */
>> +
>> +	/*
>> +	 * Check that if the kernel was loaded below 4G, that it is protected
>> +	 * by the lo PMR. Note this is the decompressed kernel. The ACM would
>> +	 * have ensured the compressed kernel (the MLE image) was protected.
>> +	 */
>> +	if ((__pa_symbol(_end) < 0x100000000ULL) &&
>> +	    (__pa_symbol(_end) > os_sinit_data->vtd_pmr_lo_size)) {
>> +		err = SL_ERROR_LO_PMR_MLE;
>> +		errmsg = "Error lo PMR does not cover MLE kernel\n";
>> +	}
>> +
>> +	/*
>> +	 * Other regions of interest like boot param, AP wake block, cmdline
>> +	 * already checked for PMR coverage in the early stub code.
>> +	 */
>> +
>> +out:
>> +	txt_early_put_heap_table(os_sinit_data, field_offset);
>> +
>> +	if (err)
>> +		slaunch_txt_reset(txt, errmsg, err);
>> +}
>> +
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
>> +
>> +/*
>> + * The location of the safe AP wake code block is stored in the TXT heap.
>> + * Fetch needed values here in the early init code for later use in SMP
>> + * startup.
>> + *
>> + * Also get the TPM event log values are in the SLRT and have to be fetched.
>> + * They will be put on the memblock reserve list later.
>> + */
>> +static void __init slaunch_fetch_values(void __iomem *txt)
>> +{
>> +	struct txt_os_mle_data *os_mle_data;
>> +	struct slr_entry_log_info *log_info;
>> +	struct slr_table *slrt;
>> +	u8 *jmp_offset;
>> +	u32 size;
>> +
>> +	os_mle_data = txt_early_get_heap_table(txt, TXT_OS_MLE_DATA_TABLE,
>> +					       sizeof(*os_mle_data));
>> +
>> +	ap_wake_info.ap_wake_block = os_mle_data->ap_wake_block;
>> +	ap_wake_info.ap_wake_block_size = os_mle_data->ap_wake_block_size;
>> +
>> +	jmp_offset = os_mle_data->mle_scratch + SL_SCRATCH_AP_JMP_OFFSET;
>> +	ap_wake_info.ap_jmp_offset = *((u32 *)jmp_offset);
>> +
>> +	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, sizeof(*slrt));
>> +	if (!slrt)
>> +		slaunch_txt_reset(txt,
>> +			"Error early_memremap of SLRT failed\n",
>> +			SL_ERROR_SLRT_MAP);
>> +
>> +	size = slrt->size;
>> +	early_memunmap(slrt, sizeof(*slrt));
>> +
>> +	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, size);
>> +	if (!slrt)
>> +		slaunch_txt_reset(txt,
>> +			"Error early_memremap of SLRT failed\n",
>> +			SL_ERROR_SLRT_MAP);
>> +
>> +	log_info = (struct slr_entry_log_info *)
>> +		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
>> +
>> +	if (!log_info)
>> +		slaunch_txt_reset(txt,
>> +				  "SLRT missing logging info entry\n",
>> +				  SL_ERROR_SLRT_MISSING_ENTRY);
>> +
>> +	evtlog_addr = log_info->addr;
>> +	evtlog_size = log_info->size;
>> +
>> +	early_memunmap(slrt, size);
>> +
>> +	txt_early_put_heap_table(os_mle_data, sizeof(*os_mle_data));
>> +}
>> +
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
>> +
>> +	/*
>> +	 * Reading the proper DIDVID from the private register space means we
>> +	 * are in SMX mode and private registers are open for read/write.
>> +	 */
>> +
>> +	/* On Intel, have to handle TPM localities via TXT */
>> +	memcpy_toio(txt + TXT_CR_CMD_SECRETS, &one, sizeof(one));
>> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
>> +	memcpy_toio(txt + TXT_CR_CMD_OPEN_LOCALITY1, &one, sizeof(one));
>> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
>> +
>> +	slaunch_fetch_values(txt);
>> +
>> +	slaunch_verify_pmrs(txt);
>> +
>> +	slaunch_txt_reserve(txt);
>> +
>> +	slaunch_copy_dmar_table(txt);
>> +
>> +	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
>> +
>> +	pr_info("Intel TXT setup complete\n");
>> +}
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index a3414af..5d1ac8d 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/iommu.h>
>>   #include <linux/numa.h>
>>   #include <linux/limits.h>
>> +#include <linux/slaunch.h>
>>   #include <asm/irq_remapping.h>
>>   
>>   #include "iommu.h"
>> @@ -660,6 +661,9 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
>>   	 */
>>   	dmar_tbl = tboot_get_dmar_table(dmar_tbl);
>>   
>> +	/* If Secure Launch is active, it has similar logic */
>> +	dmar_tbl = slaunch_get_dmar_table(dmar_tbl);
>> +
>>   	dmar = (struct acpi_table_dmar *)dmar_tbl;
>>   	if (!dmar)
>>   		return -ENODEV;
>> -- 
>> 1.8.3.1
> 
> Is it possible to test TXT in QEMU? Never done it so that's why I'm
> asking.

I would be if emulation of the GETSEC leaf functions were added to QEMU. 
AFAIK there is no public implementation of this at present.

Thanks
Ross

> 
> BR, Jarkko
> 

