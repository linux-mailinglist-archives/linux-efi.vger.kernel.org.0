Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B696F6E1E
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjEDOvz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjEDOvf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38C44B7;
        Thu,  4 May 2023 07:51:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Drb0N032612;
        Thu, 4 May 2023 14:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OLNQbn7jRY7LU68AqhZqQfFAIS9uLUiTkxqDoVnY0Ls=;
 b=McSqe41x4c2dUI6RS8ubLpAHw5A5Ld3XPn5SqG3+UFcrP59D8GAbrs/wBYYzwrlQKAeJ
 +ePQgV4SCH6oMyHdnjp9KaKipbeed62TR/Nu+IzkzvKR6oi0Z+wHY1q05oRhInGuLCII
 v7Vjdeu1NnpBXRbtFUlrfQ5yHpXuuSwyXp9jdotxQ8RzStbirRKo7OnA21ywTfmHbOvo
 4IeNk2H3IM/FIji37TKh3qhzG/11d0IfUg/BNb73DWnVnKUZSpI/cvdFxWKiWhaNnBem
 5l7g17jTQRIIzqD634uTKYX0Puxf6S2Ic3sK7/0ShkjLC7n1wBThGRkJ1GnaMc+IfcK1 eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburga59h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344ERZZD025153;
        Thu, 4 May 2023 14:50:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tqh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m96JnnjW3nZTWAFpZa4HEG2ZJRnQRpQCeze38FJjjZxK4JvqMJGTuyvaqT847r4qzOYbamSee5/W5BYb02nDShs31BNFdRo6XBJkG0AAt6E7bHghBjp2VYwnlF3AMWFZwDxQnsVFQOabqqAVaartJ11fS1T4K4dImEEql2gaGsjUepe43QsLI8FVZ45gT8uMJ434q0ciVvhXQakyukWulrSP//IK7tLg/OSnlE7hCZKkvttvIhfgs2wlVw9GlXxDnTtA5XlPnXccS8XQQo2OoFqY4H9Oa0UHxw6pBlTT1vVWYZe+R1VBtn4CC3ruSiIvPeQfB3IffJ4aY0rl5nCSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLNQbn7jRY7LU68AqhZqQfFAIS9uLUiTkxqDoVnY0Ls=;
 b=FQmT73nHmobBC4dEIM60ftE9pzK/J0ApoShhCqvmVlfa92gS6cYZNGWzOrUU2MkHiykB0hIj2LGhf7bt/0u3flVqPqFEG0hn4jfVcYVbttTqBiVXVeb2gVO+wbEel5J8knZpqJr7ndBhbeCD3sK3VJNcFd57qWE563s6USGnjQC+aIkq4dlbn+K3FRBsVG+7ywC7WsfsB0NfYsbYuCphRvY0R2oMF4wZEFUSbToFSH/fM2FxdGHk7BQmvHHxvlcIReJh1AgtEmKGn+3hIyoW5GDadOaf88W7Yvgq0Od2mvDgGwFBAoxmjtAXBdLIJQZ0V6ITMOLbIKKIA6o96xW6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLNQbn7jRY7LU68AqhZqQfFAIS9uLUiTkxqDoVnY0Ls=;
 b=psafB3K/wXU+jsojFx3jJNChSVIQUv6EYRE40c3RBaJAjSZ4p5JzUwUtX/m86c/DdgK3Vhf5cHKwsQ3nO5wZQuMGC2LM8F6229NwYdpJPbEpXejL/tUZB8zF1U/SCFGewiVpxp3ep6L27+wn2+DMS+nzSmS/PzKsyPlCE0+fiJY=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:50:41 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:50:41 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel documentation
Date:   Thu,  4 May 2023 14:50:11 +0000
Message-Id: <20230504145023.835096-3-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:5:190::38) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e6bcfd-d5db-47b2-a95e-08db4caeee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vm1th11fGPz2uW1SH3dLlIMREq3fOXtKT4Dr9aMn+uTe/0migQQqBl4fYuPY569O4e8o34LqgrKYvABTkKnn6+PZUtVLUxVyuVBt712G0g2JKc6oRdrb1Up7NU65/ehcKgZciNxwdK+2iKKILkCJCo4DxcnF4pq8bWXpEQXKCA1EoDl25F+eVooMnOqajPU/Fdpkc+MKEGAjma2d6cidjCgHzy+vNP1nPgUEatlK4Z3QsPdPSnVJeVy3vCX5yR6mF1bhadaePy3HYbucqpJJVeUw/eNTrkTFAsRxCEWt0clgt5xuy/kYIV4WW6N0QgEYKaHqezXGh3AajQ3tLON6q1TXdN3iyI7N9ehvHSVRao+6B0mo+WtZhojw8pkOhxfr6bq7EnpBvMvLVTVCwdb7gRyLTAXRUlIIKQVP/5RKc/Cu/DwXzWHhHW0nCoDwtOMsf3fZf7UKre1nXYbTUVYdre1CdkwGDsek6Bf2a25SqXD10lW1tvJlmmtorth+O9RtOMIuYyuqXxPWzWgr0k+CWC/46VUu93KKnR8b9gT0vxIFn75E1iED2XfpEWESXmQgowRUnw+diV+4cP8sHYafCQMB3I3QU9phWM0/Nxq+V+ayQL4nHKmzp5vuWUCv9QvQfhHAbILJtvdoFJ9q7UrGJ09pJPM8cU0Kd+vPf87Ej30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(6486002)(2906002)(30864003)(478600001)(316002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(86362001)(36756003)(6666004)(186003)(1076003)(26005)(6512007)(6506007)(966005)(2616005)(66899021)(43620500001)(15398625002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck81OXpZamRWUDVYcW9UcEJ1N1JscDRTU3ZUaStXTnIxV0crNWNyRjdFTmRM?=
 =?utf-8?B?WWcwcmlFNjhoUzUyanlqYmhUWmFxVmhBQ3QrYmFwZjRmeWFpMWJWSzNXLy85?=
 =?utf-8?B?MVdRWlE2TmFXNFpmZWJ3dUNzczhxdU9Ic3h2VFpKK3pGSFpxQ0Y1YnpTV0V4?=
 =?utf-8?B?amo3N2I5RHYxVEdFV0lxVHBrcDFNelJ0VW1IZzJVMkEwTkMvVi80NUsxUk9q?=
 =?utf-8?B?RmwvZFJ5UzJYa1lQZXNqb29vbU1hN3hSTlFMa1BRd3FLdUNJdWw0NTYxa3du?=
 =?utf-8?B?L1REcllyWFB5MEw2Mm8xWXpKZWdsUkhtNGl1a3pxZWVzMlQ2ZUhOQUFvSVNN?=
 =?utf-8?B?NHdyMlZxQUoyU00ybUxZZktnSE1lUU5GZ2ZZOG1zNlFDekxEbVJ6SjlYSkh4?=
 =?utf-8?B?bHYrVTNHeDZWTDdnb3IraUxvd1FJbzN1YjY0bGFzNDRaM0d1NW1JanA5bW5j?=
 =?utf-8?B?UUhHYjM5VW9mdlpZNStKNDZSUjJQQXZPaWY4UlViT3JZTlJJMDg5eFQrYWRP?=
 =?utf-8?B?WHkxcU5JV0pFS2hWT2NidHpxeDc4K0EvdjJqM083RHp1ZG4rYmtFcTRZZzVE?=
 =?utf-8?B?TjIydDV6U25GaVhlRWx6ckNoWHI0amlmRUZFRWxrVDhYVTk1YUl4cmpEd0di?=
 =?utf-8?B?d3p5STFIYmN6T0pISFlhZGJVWTQwdU93UmowbFVlOE5zaXdIYzlJUjRmOGNM?=
 =?utf-8?B?d3I3U21NaDl1NW51alBBWXIvK1RUa2ozVGEyWXZsbnRUZHVyZFpkSTc3WW41?=
 =?utf-8?B?RUJTWVNYMnUrMXdNMzlpV3BXSUgyUWhwVVRGS0FUWExRNW1Qa2Z3Y2ptNnls?=
 =?utf-8?B?ZkhDQ25hZGpjcFFXdHdzRm1SZXU5SFkvODFLU0JxR21JTjNqSm4zS1VrYnoz?=
 =?utf-8?B?MWpReWVVT0VJdGFKaWYxdGtWOVhFMitpTk9NN2dPdFZ6L20yR08zUHZmYUNk?=
 =?utf-8?B?Mi9lSkFiSFhxSElOSHUzNXFhdUIzSGJKZDgrN2RrdHU3RVBleWMwSGxpYkZB?=
 =?utf-8?B?dnhpbSsxV3hqMWJXM3ErRXg2QVJLM3pnaEY3ZEhETmJBZXFWVnlNVmJYMmhj?=
 =?utf-8?B?UEJ4M0NGYmFwQUwyQ3FuZEUvNGVTR1dEUXBRang5RGdYMm0rdlV2ZG9zVEVY?=
 =?utf-8?B?TkJ1QkQwODJ3eE53SDZPRnlMZ2QwcjJQc09pS0IwYlBVUmtuTHU2a05abEdN?=
 =?utf-8?B?bzNUMTVYa2h1cm5WbXdBRklDUnFoMG5pTnRFaUFvWUhQeXVBQmhEdEw2c3Zs?=
 =?utf-8?B?cW1CU3BJRU9PM0xkVzRQdy9WSHIwblUxd0dQQTdYZno2MCtJdDFJbWxUY3lj?=
 =?utf-8?B?TERvMGZwdFI4RU9oT29wTmFzUWRyZ1ZhV0taYXU3aTFCN1ROYWVYNVV1cmNl?=
 =?utf-8?B?eG9RbEViOXYzNkt4RHphU2lGWXMwYzVpa1l5WXJmQUtvWk1HQUZ4eTMxVmM1?=
 =?utf-8?B?RmZFVjJkMEgzblh5V2VDalQ1bThWU1Q4U3VuK1MwV2ZrbGdlZ1c5RnpFZisx?=
 =?utf-8?B?OTJoK2hxbkg3RHVJZC9NVTZyN0hzMHZFdmZCMC9uTEF0VDJtU1J3c3laS0J2?=
 =?utf-8?B?akkxNWthY08wMHU5Y0s0VDI5SDBCNkFBSTFHTHVySU9QQ1BKcWJ1SThLV2dL?=
 =?utf-8?B?MFRTb1h0eEtNNXFDUEt0UTBFK3U1ZnowYjRxU1RUYWxqSnBzYkhyWjhBODNR?=
 =?utf-8?B?WEVWeE5yMUwwT2FiRzgxdFI3bjN3RU1BWDFVNURweDRRaTNKUC9WdFNBaWpL?=
 =?utf-8?B?TlpRdExxQlZtbVFKSTFjbUpUMXY0KzBpbzRSb21PZTQ2RTN1ZmQvZWVBK3o2?=
 =?utf-8?B?dTVYY2Fxbjg4WXkzRFl6UXZtZ0FNd1R1dktYaUFiaHliMHZCUjNxa0RTVEJT?=
 =?utf-8?B?VFVrMkRDN0RRSEV5TS9rSHMwRi9DdHJUcGkrRFduYnRtb1Jua1hkSXQ3b1l4?=
 =?utf-8?B?cnk3bUM4YkpCUTdEQTF2WS9PSjVsRlBKdTAvbHFERDFTNHpwbDVRMGJBb1VF?=
 =?utf-8?B?NGtVSTdCMmhkS2RXcWV4R1VBWWFsMGdYS2JVdnh3TkxMaUdJTFBFQml1eFEw?=
 =?utf-8?B?VjlEWG9WWmFzdmJUNUVTS1JWdmlHQjYxZ3czbGNWbzJNSWl5cC80aTBDUjdz?=
 =?utf-8?B?eXA5d2dDYk94eXovS3JIVU9DdWxhbGlrcmJrWHhNdGdKT0Y1cWFOTmpnd1VU?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WUZsS0dEUkwrWGh4dDUyc3pmNTBlRlZKR2MwS1RBSXhmcnRFKzdyZ1gzcHZx?=
 =?utf-8?B?N1dWb1lQOUJERC8zQ05uTmRxbWdtT1ZHa3d1Zkl1Y0l4WHJablc5NGVMSjJL?=
 =?utf-8?B?Q25vWnBMVEN3MWJJVUpSOWRXeHVvdnRTbzNrcVF1VUpVb1R2WFRiMU5VNVBU?=
 =?utf-8?B?R1RSbHhCam9Va25iUmhyaU83dndQcmpkSnR3eEkyTWd1cUV6YkNYR2RqT1RO?=
 =?utf-8?B?S1hKUzJjQktIWXRCWkkyakp3a2l2RDllbUZjWkh1a29LTCswM0RBSGtxaVY4?=
 =?utf-8?B?c3dFV09YUWVTL2J6dWR1WndZMWFEaXI4SnJSUFV0aHB1N1Y0T0phT3lhUjdH?=
 =?utf-8?B?dlVmVmVVUnZTWGlLODFUbUhEeWE4RWFvbjVLV2xyNHZUb2t4TkNvc0htV0Zt?=
 =?utf-8?B?NW8wRUVPRU1KQmd6MU5DaDlqcURZOGFpRWtIVWpremhXZWxhZHFpS1UrRVNt?=
 =?utf-8?B?Wmp6TjBGKzgvL2loQnV5T1hYeTdWRDBoYW1KUFhyNHZvMjM2RVFSZkpQVmZJ?=
 =?utf-8?B?b3o3SDh1MWU2UVZHbTJrZ3l1WkprbjhtakVZNnZvRTFIV2RBN1EycjlzaG41?=
 =?utf-8?B?U1JlVk9DTzN4NUVkMEl3bS82a1hlamZSd1dCWmxyQjB1MEtKaTdJMUYwcFNy?=
 =?utf-8?B?bGRlY1VPcTF2ZGhIeUh5Zm5iTnk3RXgydkkwMmJDc3krVUpscnJKRGhZNXMy?=
 =?utf-8?B?RUoxS1FaVG1lUDRhMEZIMG4vMGpHQmdrSjYrblVNYjhCL3NHQzhQN2JQNDFH?=
 =?utf-8?B?Q3VKZE55cEJFbDloemhRYjI5VnpGMVRJOVRseXRybFYwdlN6OXBQWTVSWWpL?=
 =?utf-8?B?YzNJVnNLMzNuUEtHZnhuMCtyalpIY1hWOHJnbEl0N01BcG81NGRxUkpJR3VK?=
 =?utf-8?B?ejJyM3ZWVkF5YWwyZEMzdWplbHhPY1pYY21MUHZYbEoraWtUbDljOHhqcHRF?=
 =?utf-8?B?NzRDaS9oQVdnMFBzampZM3FDcXBjRlNlcHczQit1RU9NOC9SR2liUDZzdGxV?=
 =?utf-8?B?clNDdWVEUmVlQ2owbklWa2tERFJDSXVxMzRDdmF1ci9pWk5YZjhqeTJnQ3N2?=
 =?utf-8?B?SitibmRjYXk5TmRnMTBSN054SytXZGFoQUJuMm0rUm5FMjhZdHdmY0xha3VW?=
 =?utf-8?B?TEpFVGdpVFhFUTA0UVhoWjVYbE00ZFhaSnZSMkVaSldZZCs5UnkwcThwVkVR?=
 =?utf-8?B?YjBMWnloV1llV0pqMnROZHBGUlB6cm81SGppVFpKeTFST0tQbVJoK2M5eWE4?=
 =?utf-8?B?VWVsbmFOWDJSN0V0L2w5aTl4bGYxUVQxdXpySnNMcHJXOExyVDZ0c3E5bXlT?=
 =?utf-8?B?VW9rcW51NnZvWDZ0T2FBNDVnSWRlN2ZDdCtCMGhpT1V2dEh0ODBXUURuRTdY?=
 =?utf-8?B?SWc2ZDNhK3pvQWp5WDNUK3NwZ29WRFFtMEMrbzgzbFBLSkp1ZEttWXdZUERl?=
 =?utf-8?B?L1c2ODZNME1mVUt4Q05hZENNQWRwTnR2VGxrQTVRMk1oenVhMnh1S1IwODBs?=
 =?utf-8?B?TWFuenBpNFpBQkp3WW13N2F6WHhHT2lramF6cXJuM3gwNWkrelYrUC84L2Vi?=
 =?utf-8?B?UmpIam8wQWlrY2NRMUdWS2ZPRVQyeFRyci9lTHlkUStid0tLYVAzUjJDc094?=
 =?utf-8?B?bWJESTdSM1NWZU53YWFac3ZCbjJreWsyaEc0TUJuL3JwYjM1T24vZUY1OEI1?=
 =?utf-8?B?ZDZIRVVwcVdpOEF3Q0MxU0FlL1dJbkN3WFM2OURvMTVlaU53dEJ4OE5aa2FS?=
 =?utf-8?Q?fiJyMBEKY32ZrP3Y3w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e6bcfd-d5db-47b2-a95e-08db4caeee8c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:50:41.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJabORPo809ns7Vee6JFYYT90bR2HkjBS+RpJUgIDE1O8STm1cHS8YzbJOdH08+401w0K6RRfvdIWoPrxqFP2tTKUhAlnKCJ1FakBTjzDFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-GUID: I0jSWzAt3qjtvCt8Z6HxF_X7oeahVf9B
X-Proofpoint-ORIG-GUID: I0jSWzAt3qjtvCt8Z6HxF_X7oeahVf9B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce background, overview and configuration/ABI information
for the Secure Launch kernel feature.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 Documentation/security/index.rst                   |   1 +
 Documentation/security/launch-integrity/index.rst  |  10 +
 .../security/launch-integrity/principles.rst       | 313 ++++++++++++
 .../launch-integrity/secure_launch_details.rst     | 564 +++++++++++++++++++++
 .../launch-integrity/secure_launch_overview.rst    | 220 ++++++++
 5 files changed, 1108 insertions(+)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 6ed8d2f..fade37e 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -18,3 +18,4 @@ Security Documentation
    digsig
    landlock
    secrets/index
+   launch-integrity/index
diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
new file mode 100644
index 0000000..28eed91d
--- /dev/null
+++ b/Documentation/security/launch-integrity/index.rst
@@ -0,0 +1,10 @@
+=====================================
+System Launch Integrity documentation
+=====================================
+
+.. toctree::
+
+   principles
+   secure_launch_overview
+   secure_launch_details
+
diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
new file mode 100644
index 0000000..73cf063
--- /dev/null
+++ b/Documentation/security/launch-integrity/principles.rst
@@ -0,0 +1,313 @@
+=======================
+System Launch Integrity
+=======================
+
+This document serves to establish a common understanding of what is system
+launch, the integrity concern for system launch, and why using a Root of Trust
+(RoT) from a Dynamic Launch may be desired. Through out this document
+terminology from the Trusted Computing Group (TCG) and National Institue for
+Science and Technology (NIST) is used to ensure a vendor nutrual language is
+used to describe and reference security-related concepts.
+
+System Launch
+=============
+
+There is a tendency to only consider the classical power-on boot as the only
+means to launch an Operating System (OS) on a computer system, but in fact most
+modern processors support two methods to launch the system. To provide clarity a
+common definition of a system launch should be established. This definition is
+that a during a single power life cycle of a system, a System Launch consists
+of an initialization event, typically in hardware, that is followed by an
+executing software payload that takes the system from the initialized state to
+a running state. Driven by the Trusted Computing Group (TCG) architecture,
+modern processors are able to support two methods to launch a system, these two
+types of system launch are known as Static Launch and Dynamic Launch.
+
+Static Launch
+-------------
+
+Static launch is the system launch associated with the power cycle of the CPU.
+Thus static launch refers to the classical power-on boot where the
+initialization event is the release of the CPU from reset and the system
+firmware is the software payload that brings the system up to a running state.
+Since static launch is the system launch associated with the beginning of the
+power lifecycle of a system, it is therefore a fixed, one-time system launch.
+It is because of this that static launch is referred to and thought of as being
+"static".
+
+Dynamic Launch
+--------------
+
+Modern CPUs architectures provides a mechanism to re-initialize the system to a
+"known good" state without requiring a power event. This re-initialization
+event is the event for a dynamic launch and is referred to as the Dynamic
+Launch Event (DLE). The DLE functions by accepting a software payload, referred
+to as the Dynamic Configuration Environment (DCE), that execution is handed to
+after the DLE is invoked. The DCE is responsible for bringing the system back
+to a running state. Since the dynamic launch is not tied to a power event like
+the static launch, this enables a dynamic launch to be initiated at any time
+and multiple times during a single power life cycle. This dynamism is the
+reasoning behind referring to this system launch as being dynamic.
+
+Because a dynamic launch can be conducted at any time during a single power
+life cycle, they are classified into one of two types, an early launch or a
+late launch.
+
+:Early Launch: When a dynamic launch is used as a transition from a static
+   launch chain to the final Operating System.
+
+:Late Launch: The usage of a dynamic launch by an executing Operating System to
+   transition to a “known good” state to perform one or more operations, e.g. to
+   launch into a new Operating System.
+
+System Integrity
+================
+
+A computer system can be considered a collection of mechanisms that work
+together to produce a result. The assurance that the mechanisms are functioning
+correctly and producing the expected result is the integrity of the system. To
+ensure a system's integrity there are a subset of these mechanisms, commonly
+referred to as security mechanisms, that are present to help ensure the system
+produces the expected result or at least detect the potential of an unexpected
+result may have happened. Since the security mechanisms are relied upon to
+ensue the integrity of the system, these mechanisms are trusted. Upon
+inspection these security mechanisms each have a set of properties and these
+properties can be evaluated to determine how susceptible a mechanism might be
+to failure. This assessment is referred to as the Strength of Mechanism and for
+trusted mechanism enables for the trustworthiness of that mechanism to be
+quantified.
+
+For software systems there are two system states for which the integrity is
+critical, when the software is loaded into memory and when the software is
+executing on the hardware. Ensuring that the expected software is load into
+memory is referred to as load-time integrity while ensuring that the software
+executing is the expected software is the runtime integrity of that software.
+
+Load-time Integrity
+-------------------
+
+It is critical to understand what load-time integrity establishes about a
+system and what is assumed, i.e. what is being trusted. Load-time integrity is
+when a trusted entity, i.e. an entity with an assumed integrity, takes an
+action to assess an entity being loaded into memory before it is used. A
+variety of mechanisms may be used to conduct the assessment, each with
+different properties. A particular property is whether the mechanism creates an
+evidence of the assessment. Often either cryptographic signature checking or
+hashing are the common assessment operations used.
+
+A signature checking assessment functions by requiring a representation of the
+accepted authorities and uses those representations to assess if the entity has
+been signed by an accepted authority. The benefit to this process is that
+assessment process includes an adjudication of the assessment. The drawbacks
+are that 1) the adjudication is susceptible to tampering by the Trusted
+Computing Base (TCB), 2) there is no evidence to assert that an untampered
+adjudication was completed, and 3) the system must be an active participant in
+the key management infrastructure.
+
+A cryptographic hashing assessment does not adjudicate the assessment but
+instead generates evidence of the assessment to be adjudicated independently.
+The benefits to this approach is that the assessment may be simple such that it
+is able to be implemented as an immutable mechanism, e.g. in hardware.
+Additionally it is possible for the adjudication to be conducted where it
+cannot be tampered with by the TCB. The drawback is that a compromised
+environment will be allowed to execute until an adjudication can be completed.
+
+Ultimately load-time integrity provides confidence that the correct entity was
+loaded and in the absence of a run-time integrity mechanism assumes, i.e
+trusts, that the entity will never become corrupted.
+
+Runtime Integrity
+-----------------
+
+Runtime integrity in the general sense is when a trusted entity makes an
+assessment of an entity at any point in time during the assessed entity's
+execution. A more concrete explanation is the taking of an integrity assessment
+of an active process executing on the system at any point during the process'
+execution. Often the load-time integrity of an operating system's user-space,
+i.e. the operating environment, is confused to be the runtime integrity of the
+system since it is an integrity assessment of the "runtime" software. The
+reality is that actual runtime integrity is a very difficult problem and thus
+not very many solutions are public and/or available. One example of a runtime
+integrity solution would be John Hopkins Advanced Physics Labratory's (APL)
+Linux Kernel Integrity Module (LKIM).
+
+Trust Chains
+============
+
+Bulding upon the understanding of security mechanisms to establish load-time
+integrity of an entity, it is possible to chain together load-time integrity
+assessments to establish the integrity of the whole system. This process is
+known as transitive trust and provides the concept of building a chain of
+load-time integrity assessments, commonly referred to as a trust chain. These
+assessments may be used to adjudicate the load-time integrity of the whole
+system. This trust chain is started by a trusted entity that does the first
+assessment. This first entity is referred to as the Root of Trust(RoT) with the
+entities name being derived from the mechanism used for the assessment, i.e.
+RoT for Verification (RTV) and RoT for Measurement (RTM).
+
+A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
+and therefore it too has a Strength of Mechanism. The factors that contribute
+to a trust chain's strength are,
+
+  - The strength of the chain's RoT
+  - The strength of each member of the trust chain
+  - The length, i.e. the number of members, of the chain
+
+Therefore to provide the strongest trust chains, they should start with a
+strong RoT and should consist of members being of low complexity and minimizing
+the number of members participating as is possible. In a more colloquial sense,
+a trust chain is only as strong as it weakests link and more links increase
+the probability of a weak link.
+
+Dynamic Launch Components
+=========================
+
+The TCG architecture for dynamic launch is composed of a component series that
+are used to setup and then carry out the launch. These components work together
+to construct a RTM trust chain that is rooted in the dynamic launch and thus
+commonly referred to as the Dynamic Root of Trust for Measurement (DRTM) chain.
+
+What follows is a brief explanation of each component in execution order. A
+subset of these components are what establishes the dynamic launch's trust
+chain.
+
+Dynamic Configuration Environment Preamble
+------------------------------------------
+
+The Dynamic Configuration Environment (DCE) Preamble is responsible for setting
+up the system environment in preparation for a dynamic launch. The DCE Preamble
+is not a part of the DRTM trust chain.
+
+Dynamic Launch Event
+--------------------
+
+The dynamic launch event is the event, typically a CPU instruction, that triggers
+the system's dynamic launch mechanism to begin the launch. The dynamic launch
+mechanism is also the RoT for the DRTM trust chain.
+
+Dynamic Configuration Environment
+---------------------------------
+
+The dynamic launch mechanism may have resulted in a reset of a portion of the
+system. To bring the system back to an adequate state for system software the
+dynamic launch will hand over control to the DCE. Prior to handing over this
+control, the dynamic launch will measure the DCE. Once the DCE is complete it
+will proceed to measure and then execute the Dynamic Launch Measured
+Environment (DLME).
+
+Dynamic Launch Measured Environment
+-----------------------------------
+
+The DLME is the first system kernel to have control of the system but may not
+be the last. Depending on the usage and configuration, the DLME may be the
+final/target operating system or it may be a boot loader that will load the
+final/target operating system.
+
+Why DRTM
+========
+
+It is a fact that DRTM increases the load-time integrity of the system by
+providing a trust chain that has an immutable hardware RoT, uses a limited
+number of small, special purpose code to establish the trust chain that starts
+the target operating system. As mentioned in the Trust Chain section, these are
+the main three factors in driving up the strength of a trust chain. As can been
+seen by the BootHole exploit, which in fact did not effect the integrity of
+DRTM solutions, the sophistication of attacks targeting system launch is at an
+all time high. There is no reason a system should not employ every integrity
+measure hardware makes available. This is the crux of a defense-in-depth
+approach to system security. In the past the now closed SMI gap was often
+pointed to as invalidating DRTM, which in fact was nothing but a strawman
+argument. As has continued to be demonstrated, if/when SMM is corrupted it can
+always circumvent all load-time integrity, SRTM and DRTM, because it is a
+run-time integrity problem. Regardless, Intel and AMD have both deployed
+runtime integrity for SMI and SMM which is tied directly to DRTM such that this
+perceived deficiency is now non-existent and the world is moving forward with
+an expectation that DRTM must be present.
+
+Glossary
+========
+
+.. glossary::
+  integrity
+    Guarding against improper information modification or destruction, and
+    includes ensuring information non-repudiation and authenticity.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  mechanism
+    A process or system that is used to produce a particular result.
+
+    - NIST Special Publication 800-160 (VOLUME 1 ) - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1.pdf
+
+  risk
+    A measure of the extent to which an entity is threatened by a potential
+    circumstance or event, and typically a function of: (i) the adverse impacts
+    that would arise if the circumstance or event occurs; and (ii) the
+    likelihood of occurrence.
+
+    - NIST SP 800-30 Rev. 1 - https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-30r1.pdf
+
+  security mechanism
+    A device or function designed to provide one or more security services
+    usually rated in terms of strength of service and assurance of the design.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  Strength of Mechanism
+    A scale for measuring the relative strength of a security mechanism
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  transitive trust
+    Also known as "Inductive Trust", in this process a Root of Trust gives a
+    trustworthy description of a second group of functions. Based on this
+    description, an interested entity can determine the trust it is to place in
+    this second group of functions. If the interested entity determines that
+    the trust level of the second group of functions is acceptable, the trust
+    boundary is extended from the Root of Trust to include the second group of
+    functions. In this case, the process can be iterated. The second group of
+    functions can give a trustworthy description of the third group of
+    functions, etc. Transitive trust is used to provide a trustworthy
+    description of platform characteristics, and also to prove that
+    non-migratable keys are non-migratable
+
+    - TCG Glossary - https://trustedcomputinggroup.org/wp-content/uploads/TCG-Glossary-V1.1-Rev-1.0.pdf
+
+  trust
+    The confidence one element has in another that the second element will
+    behave as expected`
+
+    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
+
+  trust anchor
+    An authoritative entity for which trust is assumed.
+
+    - NIST SP 800-57 Part 1 Rev. 5 - https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf
+
+  trusted
+    An element that another element relies upon to fulfill critical
+    requirements on its behalf.
+
+    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
+
+  trusted computing base (TCB)
+    Totality of protection mechanisms within a computer system, including
+    hardware, firmware, and software, the combination responsible for enforcing
+    a security policy.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  trusted computer system
+    A system that has the necessary security functions and assurance that the
+    security policy will be enforced and that can process a range of
+    information sensitivities (i.e. classified, controlled unclassified
+    information (CUI), or unclassified public information) simultaneously.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
+
+  trustworthiness
+    The attribute of a person or enterprise that provides confidence to others
+    of the qualifications, capabilities, and reliability of that entity to
+    perform specific tasks and fulfill assigned responsibilities.
+
+    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst
new file mode 100644
index 0000000..2e71543
--- /dev/null
+++ b/Documentation/security/launch-integrity/secure_launch_details.rst
@@ -0,0 +1,564 @@
+===================================
+Secure Launch Config and Interfaces
+===================================
+
+Configuration
+=============
+
+The settings to enable Secure Launch using Kconfig are under::
+
+  "Processor type and features" --> "Secure Launch support"
+
+A kernel with this option enabled can still be booted using other supported
+methods.
+
+To reduce the Trusted Computing Base (TCB) of the MLE [1]_, the build
+configuration should be pared down as narrowly as one's use case allows.
+The fewer drivers (less active hardware) and features reduces the attack
+surface. E.g. in the extreme, the MLE could only have local disk access
+and no other hardware support. Or only network access for remote attestation.
+
+It is also desirable if possible to embed the initrd used with the MLE kernel
+image to reduce complexity.
+
+The following are a few important configuration necessities to always consider:
+
+KASLR Configuration
+-------------------
+
+Secure Launch does not interoperate with KASLR. If possible, the MLE should be
+built with KASLR disabled::
+
+  "Processor type and features" -->
+      "Build a relocatable kernel" -->
+          "Randomize the address of the kernel image (KASLR) [ ]"
+
+This unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
+
+If not possible, KASLR must be disabled on the kernel command line when doing
+a Secure Launch as follows::
+
+  nokaslr
+
+IOMMU Configuration
+-------------------
+
+When doing a Secure Launch, the IOMMU should always be enabled and the drivers
+loaded. However, IOMMU passthrough mode should never be used. This leaves the
+MLE completely exposed to DMA after the PMR's [2]_ are disabled. The current default
+mode is to use IOMMU in lazy translated mode but strict translated mode is the preferred
+IOMMU mode and this should be selected in the build configuration::
+
+  "Device Drivers" -->
+      "IOMMU Hardware Support" -->
+          "IOMMU default domain type" -->
+              "(X) Translated - Strict"
+
+In addition, the Intel IOMMU should be on by default. The following sets this as the
+default in the build configuration::
+
+  "Device Drivers" -->
+      "IOMMU Hardware Support" -->
+          "Support for Intel IOMMU using DMA Remapping Devices [*]"
+
+and::
+
+  "Device Drivers" -->
+      "IOMMU Hardware Support" -->
+          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
+              "Enable Intel DMA Remapping Devices by default  [*]"
+
+It is recommended that no other command line options should be set to override
+the defaults above.
+
+Secure Launch Resource Table
+============================
+
+The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard format
+for providing information for the pre-launch environment and to pass
+information to the post-launch environment. The table is populated by one or
+more bootloaders in the boot chain and used by Secure Launch on how to setup
+the environment during post-launch. The details for the SLRT are documented
+in the TrenchBoot Secure Launch Specifcation [3]_.
+
+Intel TXT Interface
+===================
+
+The primary interfaces between the various components in TXT are the TXT MMIO
+registers and the TXT heap. The MMIO register banks are described in Appendix B
+of the TXT MLE [1]_ Development Guide.
+
+The TXT heap is described in Appendix C of the TXT MLE [1]_ Development
+Guide. Most of the TXT heap is predefined in the specification. The heap is
+initialized by firmware and the pre-launch environment and is subsequently used
+by the SINIT ACM. One section, called the OS to MLE Data Table, is reserved for
+software to define. This table is set up per the recommendation detailed in
+Appendix B of the TrenchBoot Secure Launch Specification::
+
+        /*
+         * Secure Launch defined OS/MLE TXT Heap table
+         */
+        struct txt_os_mle_data {
+                u32 version;
+                u32 boot_params_addr;
+                struct slr_table *slrt;
+                u64 txt_info;
+                u32 ap_wake_block;
+                u32 ap_wake_block_size;
+                u8 mle_scratch[64];
+        } __packed;
+
+Description of structure:
+
+=====================  ========================================================================
+Field                  Use
+=====================  ========================================================================
+version                Structure version, current value 1
+boot_params_addr       Physical base address of the Linux boot parameters
+slrt                   Physical address of the Secure Launch Resource Table
+txt_info               Pointer into the SLRT for easily locating TXT specific table
+ap_wake_block          Physical address of the block of memory for parking APs after a launch
+ap_wake_block_size     Size of the AP wake block
+mle_scratch            Scratch area used post-launch by the MLE kernel. Fields:
+ 
+                        - SL_SCRATCH_AP_EBX area to share %ebx base pointer among CPUs
+                        - SL_SCRATCH_AP_JMP_OFFSET offset to abs. ljmp fixup location for APs
+=====================  ========================================================================
+
+Error Codes
+-----------
+
+The TXT specification defines the layout for TXT 32 bit error code values.
+The bit encodings indicate where the error originated (e.g. with the CPU,
+in the SINIT ACM, in software). The error is written to a sticky TXT
+register that persists across resets called TXT.ERRORCODE (see the TXT
+MLE Development Guide). The errors defined by the Secure Launch feature are
+those generated in the MLE software. They have the format::
+
+  0xc0008XXX
+
+The low 12 bits are free for defining the following Secure Launch specific
+error codes.
+
+======  ================
+Name:   SL_ERROR_GENERIC
+Value:  0xc0008001
+======  ================
+
+Description:
+
+Generic catch all error. Currently unused.
+
+======  =================
+Name:   SL_ERROR_TPM_INIT
+Value:  0xc0008002
+======  =================
+
+Description:
+
+The Secure Launch code failed to get an access to the TPM hardware interface.
+This is most likely to due to misconfigured hardware or kernel. Ensure the
+TPM chip is enabled and the kernel TPM support is built in (it should not be
+built as a module).
+
+======  ==========================
+Name:   SL_ERROR_TPM_INVALID_LOG20
+Value:  0xc0008003
+======  ==========================
+
+Description:
+
+The Secure Launch code failed to find a valid event log descriptor for TPM
+version 2.0 or the event log descriptor is malformed. Usually this indicates
+that incompatible versions of the pre-launch environment and the MLE kernel.
+The pre-launch environment and the kernel share a structure in the TXT heap and
+if this structure (the OS-MLE table) is mismatched, this error is often seen.
+This TXT heap area is setup by the pre-launch environment so the issue may
+originate there. It could be the sign of an attempted attack.
+
+======  ===========================
+Name:   SL_ERROR_TPM_LOGGING_FAILED
+Value:  0xc0008004
+======  ===========================
+
+Description:
+
+There was a failed attempt to write a TPM event to the event log early in the
+Secure Launch process. This is likely the result of a malformed TPM event log
+buffer. Formatting of the event log buffer information is done by the
+pre-launch environment so the issue most likely originates there.
+
+======  ============================
+Name:   SL_ERROR_REGION_STRADDLE_4GB
+Value:  0xc0008005
+======  ============================
+
+Description:
+
+During early validation a buffer or region was found to straddle the 4GB
+boundary. Because of the way TXT does DMA memory protection, this is an
+unsafe configuration and is flagged as an error. This is most likely a
+configuration issue in the pre-launch environment. It could also be the sign of
+an attempted attack.
+
+======  ===================
+Name:   SL_ERROR_TPM_EXTEND
+Value:  0xc0008006
+======  ===================
+
+Description:
+
+There was a failed attempt to extend a TPM PCR in the Secure Launch platform
+module. This is most likely to due to misconfigured hardware or kernel. Ensure
+the TPM chip is enabled and the kernel TPM support is built in (it should not
+be built as a module).
+
+======  ======================
+Name:   SL_ERROR_MTRR_INV_VCNT
+Value:  0xc0008007
+======  ======================
+
+Description:
+
+During early Secure Launch validation an invalid variable MTRR count was found.
+The pre-launch environment passes a number of MSR values to the MLE to restore
+including the MTRRs. The values are restored by the Secure Launch early entry
+point code. After measuring the values supplied by the pre-launch environment,
+a discrepancy was found validating the values. It could be the sign of an
+attempted attack.
+
+======  ==========================
+Name:   SL_ERROR_MTRR_INV_DEF_TYPE
+Value:  0xc0008008
+======  ==========================
+
+Description:
+
+During early Secure Launch validation an invalid default MTRR type was found.
+See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  ======================
+Name:   SL_ERROR_MTRR_INV_BASE
+Value:  0xc0008009
+======  ======================
+
+Description:
+
+During early Secure Launch validation an invalid variable MTRR base value was
+found. See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  ======================
+Name:   SL_ERROR_MTRR_INV_MASK
+Value:  0xc000800a
+======  ======================
+
+Description:
+
+During early Secure Launch validation an invalid variable MTRR mask value was
+found. See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  ========================
+Name:   SL_ERROR_MSR_INV_MISC_EN
+Value:  0xc000800b
+======  ========================
+
+Description:
+
+During early Secure Launch validation an invalid miscellaneous enable MSR value
+was found. See SL_ERROR_MTRR_INV_VCNT for more details.
+
+======  =========================
+Name:   SL_ERROR_INV_AP_INTERRUPT
+Value:  0xc000800c
+======  =========================
+
+Description:
+
+The application processors (APs) wait to be woken up by the SMP initialization
+code. The only interrupt that they expect is an NMI; all other interrupts
+should be masked. If an AP gets some other interrupt other than an NMI it will
+cause this error. This error is very unlikely to occur.
+
+======  =========================
+Name:   SL_ERROR_INTEGER_OVERFLOW
+Value:  0xc000800d
+======  =========================
+
+Description:
+
+A buffer base and size passed to the MLE caused an integer overflow when
+added together. This is most likely a configuration issue in the pre-launch
+environment. It could also be the sign of an attempted attack.
+
+======  ==================
+Name:   SL_ERROR_HEAP_WALK
+Value:  0xc000800e
+======  ==================
+
+Description:
+
+An error occurred in TXT heap walking code. The underlying issue is a failure to
+early_memremap() portions of the heap, most likely due to a resource shortage.
+
+======  =================
+Name:   SL_ERROR_HEAP_MAP
+Value:  0xc000800f
+======  =================
+
+Description:
+
+This error is essentially the same as SL_ERROR_HEAP_WALK but occurred during the
+actual early_memremap() operation.
+
+======  =========================
+Name:   SL_ERROR_REGION_ABOVE_4GB
+Value:  0xc0008010
+======  =========================
+
+Description:
+
+A memory region used by the MLE is above 4GB. In general this is not a problem
+because memory > 4Gb can be protected from DMA. There are certain buffers that
+should never be above 4Gb though and one of these caused the violation. This is
+most likely a configuration issue in the pre-launch environment. It could also
+be the sign of an attempted attack.
+
+======  ==========================
+Name:   SL_ERROR_HEAP_INVALID_DMAR
+Value:  0xc0008011
+======  ==========================
+
+Description:
+
+The backup copy of the ACPI DMAR table which is supposed to be located in the
+TXT heap could not be found. This is due to a bug in the platform's ACM module
+or in firmware.
+
+======  =======================
+Name:   SL_ERROR_HEAP_DMAR_SIZE
+Value:  0xc0008012
+======  =======================
+
+Description:
+
+The backup copy of the ACPI DMAR table in the TXT heap is to large to be stored
+for later usage. This error is very unlikely to occur since the area reserved
+for the copy is far larger than the DMAR should be.
+
+======  ======================
+Name:   SL_ERROR_HEAP_DMAR_MAP
+Value:  0xc0008013
+======  ======================
+
+Description:
+
+The backup copy of the ACPI DMAR table in the TXT heap could not be mapped. The
+underlying issue is a failure to early_memremap() the DMAR table, most likely
+due to a resource shortage.
+
+======  ====================
+Name:   SL_ERROR_HI_PMR_BASE
+Value:  0xc0008014
+======  ====================
+
+Description:
+
+On a system with more than 4G of RAM, the high PMR [2]_ base address should be set
+to 4G. This error is due to that not being the case. This PMR value is set by
+the pre-launch environment so the issue most likely originates there. It could also
+be the sign of an attempted attack.
+
+======  ====================
+Name:   SL_ERROR_HI_PMR_SIZE
+Value:  0xc0008015
+======  ====================
+
+Description:
+
+On a system with more than 4G of RAM, the high PMR [2]_ size should be set to cover
+all RAM > 4G. This error is due to that not being the case. This PMR value is
+set by the pre-launch environment so the issue most likely originates there. It
+could also be the sign of an attempted attack.
+
+======  ====================
+Name:   SL_ERROR_LO_PMR_BASE
+Value:  0xc0008016
+======  ====================
+
+Description:
+
+The low PMR [2]_ base should always be set to address zero. This error is due to
+that not being the case. This PMR value is set by the pre-launch environment
+so the issue most likely originates there. It could also be the sign of an attempted
+attack.
+
+======  ====================
+Name:   SL_ERROR_LO_PMR_MLE
+Value:  0xc0008017
+======  ====================
+
+Description:
+
+This error indicates the MLE image is not covered by the low PMR [2]_ range. The
+PMR values are set by the pre-launch environment so the issue most likely originates
+there. It could also be the sign of an attempted attack.
+
+======  =======================
+Name:   SL_ERROR_INITRD_TOO_BIG
+Value:  0xc0008018
+======  =======================
+
+Description:
+
+The external initrd provided is larger than 4Gb. This is not a valid
+configuration for a Secure Launch due to managing DMA protection.
+
+======  =========================
+Name:   SL_ERROR_HEAP_ZERO_OFFSET
+Value:  0xc0008019
+======  =========================
+
+Description:
+
+During a TXT heap walk an invalid/zero next table offset value was found. This
+indicates the TXT heap is malformed. The TXT heap is initialized by the
+pre-launch environment so the issue most likely originates there. It could also
+be a sign of an attempted attack. In addition, ACM is also responsible for
+manipulating parts of the TXT heap so the issue could be due to a bug in the
+platform's ACM module.
+
+======  =============================
+Name:   SL_ERROR_WAKE_BLOCK_TOO_SMALL
+Value:  0xc000801a
+======  =============================
+
+Description:
+
+The AP wake block buffer passed to the MLE via the OS-MLE TXT heap table is not
+large enough. This value is set by the pre-launch environment so the issue most
+likely originates there. It also could be the sign of an attempted attack.
+
+======  ===========================
+Name:   SL_ERROR_MLE_BUFFER_OVERLAP
+Value:  0xc000801b
+======  ===========================
+
+Description:
+
+One of the buffers passed to the MLE via the OS-MLE TXT heap table overlaps
+with the MLE image in memory. This value is set by the pre-launch environment
+so the issue most likely originates there. It could also be the sign of an attempted
+attack.
+
+======  ==========================
+Name:   SL_ERROR_BUFFER_BEYOND_PMR
+Value:  0xc000801c
+======  ==========================
+
+Description:
+
+One of the buffers passed to the MLE via the OS-MLE TXT heap table is not
+protected by a PMR. This value is set by the pre-launch environment so the
+issue most likey  originates there. It could also be the sign of an attempted
+attack.
+
+======  =============================
+Name:   SL_ERROR_OS_SINIT_BAD_VERSION
+Value:  0xc000801d
+======  =============================
+
+Description:
+
+The version of the OS-SINIT TXT heap table is bad. It must be 6 or greater.
+This value is set by the pre-launch environment so the issue most likely
+originates there. It could also be the sign of an attempted attack. It is also
+possible though very unlikely that the platform is so old that the ACM being
+used requires an unsupported version.
+
+======  =====================
+Name:   SL_ERROR_EVENTLOG_MAP
+Value:  0xc000801e
+======  =====================
+
+Description:
+
+An error occurred in the Secure Launch module while mapping the TPM event log.
+The underlying issue is memremap() failure, most likely due to a resource
+shortage.
+
+======  ========================
+Name:   SL_ERROR_TPM_NUMBER_ALGS
+Value:  0xc000801f
+======  ========================
+
+Description:
+
+The TPM 2.0 event log reports an unsupported number of hashing algorithms.
+Secure launch currently only supports a maximum of two: SHA1 and SHA256.
+
+======  ===========================
+Name:   SL_ERROR_TPM_UNKNOWN_DIGEST
+Value:  0xc0008020
+======  ===========================
+
+Description:
+
+The TPM 2.0 event log reports an unsupported hashing algorithm. Secure launch
+currently only supports two algorithms: SHA1 and SHA256.
+
+======  ==========================
+Name:   SL_ERROR_TPM_INVALID_EVENT
+Value:  0xc0008021
+======  ==========================
+
+Description:
+
+An invalid/malformed event was found in the TPM event log while reading it.
+Since only trusted entities are supposed to be writing the event log, this
+would indicate either a bug or a possible attack.
+
+======  =====================
+Name:   SL_ERROR_INVALID_SLRT
+Value:  0xc0008022
+======  =====================
+
+Description:
+
+The Secure Launch Resource Table is invalid or malformed and is unusable.
+This implies the pre-launch code did not properly setup the SLRT.
+
+======  ===========================
+Name:   SL_ERROR_SLRT_MISSING_ENTRY
+Value:  0xc0008023
+======  ===========================
+
+Description:
+
+The Secure Launch Resource Table is missing a required entry within it.
+This implies the pre-launch code did not properly setup the SLRT.
+
+======  =================
+Name:   SL_ERROR_SLRT_MAP
+Value:  0xc0008024
+======  =================
+
+Description:
+
+An error occurred in the Secure Launch module while mapping the Secure Launch
+Resource table. The underlying issue is memremap() failure, most likely due to
+a resource shortage.
+
+.. [1]
+    MLE: Measured Launch Environment is the binary runtime that is measured and
+    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
+    requirements for the MLE in detail.
+
+.. [2]
+    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Registers.
+    There are two of these registers and they allow all DMA to be blocked
+    to large areas of memory. The low PMR can cover all memory below 4Gb on 2Mb
+    boundaries. The high PMR can cover all RAM on the system, again on 2Mb
+    boundaries. This feature is used during a Secure Launch by TXT.
+
+.. [3]
+    Secure Launch Specification: https://trenchboot.org/specifications/Secure_Launch/
diff --git a/Documentation/security/launch-integrity/secure_launch_overview.rst b/Documentation/security/launch-integrity/secure_launch_overview.rst
new file mode 100644
index 0000000..ba91d73
--- /dev/null
+++ b/Documentation/security/launch-integrity/secure_launch_overview.rst
@@ -0,0 +1,220 @@
+======================
+Secure Launch Overview
+======================
+
+Overview
+========
+
+Prior to the start of the TrenchBoot project, the only active Open Source
+project supporting dynamic launch was Intel's tboot project to support their
+implementation of dynamic launch known as Intel Trusted eXecution Technology
+(TXT). The approach taken by tboot was to provide an exokernel that could
+handle the launch protocol implemented by Intel's special loader, the SINIT
+Authenticated Code Module (ACM [2]_) and remained in memory to manage the SMX
+CPU mode that a dynamic launch would put a system. While it is not precluded
+from being used for doing a late launch, tboot's primary use case was to be
+used as an early launch solution. As a result the TrenchBoot project started
+the development of Secure Launch kernel feature to provide a more generalized
+approach. The focus of the effort is twofold, the first is to make the Linux
+kernel directly aware of the launch protocol used by Intel, AMD/Hygon, Arm, and
+potentially OpenPOWER. The second is to make the Linux kernel be able to
+initiate a dynamic launch. It is through this approach that the Secure Launch
+kernel feature creates a basis for the Linux kernel to be used in a variety of
+dynamic launch use cases.
+
+.. note::
+    A quick note on terminology. The larger open source project itself is
+    called TrenchBoot, which is hosted on GitHub (links below). The kernel
+    feature enabling the use of the x86 technology is referred to as "Secure
+    Launch" within the kernel code.
+
+Goals
+=====
+
+The first use case that the TrenchBoot project focused on was the ability for
+the Linux kernel to be started by a dynamic launch, in particular as part of an
+early launch sequence. In this case the dynamic launch will be initiated by any
+boot loader with associated support added to it, for example the first targeted
+boot loader in this case was GRUB2. An integral part of establishing a
+measurement-based launch integrity involves measuring everything that is
+intended to be executed (kernel image, initrd, etc) and everything that will
+configure that kernel to execute (command line, boot params, etc). Then storing
+those measurements in a protected manner. Both the Intel and AMD dynamic launch
+implementations leverage the Trusted Platform Module (TPM) to store those
+measurements. The TPM itself has been designed such that a dynamic launch
+unlocks a specific set of Platform Configuration Registers (PCR) for holding
+measurement taken during the dynamic launch.  These are referred to as the DRTM
+PCRs, PCRs 17-22. Further details on this process can be found in the
+documentation for the GETSEC instruction provided by Intel's TXT and the SKINIT
+instruction provided by AMD's AMD-V. The documentation on these technologies
+can be readily found online; see the `Resources`_ section below for references.
+
+.. note::
+    Currently only Intel TXT is supported in this first release of the Secure
+    Launch feature. AMD/Hygon SKINIT and Arm support will be added in a
+    subsequent release.
+
+To enable the kernel to be launched by GETSEC a stub, the Secure Launch stub,
+must be built into the setup section of the compressed kernel to handle the
+specific state that the dynamic launch process leaves the BSP. Also the Secure
+Launch stub must measure everything that is going to be used as early as
+possible. This stub code and subsequent code must also deal with the specific
+state that the dynamic launch leaves the APs as well.
+
+Design Decisions
+================
+
+A number of design decisions were made during the development of the Secure
+Launch feature. The two primary guiding decisions were:
+
+ - Keeping the Secure Launch code as separate from the rest of the kernel
+   as possible.
+ - Modifying the existing boot path of the kernel as little as possible.
+
+The following illustrate how the implementation followed these design
+decisions:
+
+ - All the entry point code necessary to properly configure the system post
+   launch is found in st_stub.S in the compressed kernel image. This code
+   validates the state of the system, restores necessary system operating
+   configurations and properly handles post launch CPU states.
+ - After the sl_stub.S is complete, it jumps directly to the unmodified
+   startup_32 kernel entry point.
+ - A single call is made to a function sl_main() prior to the main kernel
+   decompression step. This code performs further validation and takes the
+   needed DRTM measurements.
+ - After the call to sl_main(), the main kernel is decompressed and boots as
+   it normally would.
+ - Final setup for the Secure Launch kernel is done in a separate Secure
+   Launch module that is loaded via a late initcall. This code is responsible
+   for extending the measurements taken earlier into the TPM DRTM PCRs and
+   setting up the securityfs interface to allow access the TPM event log and
+   public TXT registers.
+ - On the reboot and kexec paths, calls are made to a function to finalize the
+   state of the Secure Launch kernel.
+
+The one place where Secure Launch code is mixed directly in with kernel code is
+in the SMP boot code. This is due to the unique state that the dynamic launch
+leaves the APs in. On Intel this involves using a method other than the
+standard INIT-SIPI sequence.
+
+A final note is that originally the extending of the PCRs was completed in the
+Secure Launch stub when the measurements were taken. An alternative solution
+had to be implemented due to the TPM maintainers objecting to the PCR
+extensions being done with a minimal interface to the TPM that was an
+independent implementation of the mainline kernel driver. Since the mainline
+driver relies heavily on kernel interfaces not available in the compressed
+kernel, it was not possible to reuse the mainline TPM driver. This resulted in
+the decision to move the extension operations to the Secure Launch module in
+the mainline kernel where the TPM driver would be available.
+
+Basic Boot Flow
+===============
+
+Outlined here is summary of the boot flow for Secure Launch. A more detailed
+review of Secure Launch process can be found in the Secure Launch
+Specification, a link is located in the `Resources`_ section.
+
+Pre-launch: *Phase where the environment is prepared and configured to initiate the
+secure launch by the boot chain.*
+
+ - The SLRT is initialized and dl_stub is placed in memory.
+ - Load the kernel, initrd and ACM [2]_ into memory.
+ - Setup the TXT heap and page tables describing the MLE [1]_ per the
+   specification.
+ - If non-UEFI platform, dl_stub is called.
+ - If UEFI platforms, SLRT registered with UEFI and efi-stub called.
+ - Upon completion, efi-stub will call EBS followed by dl_stub.
+ - The dl_stub will prepare the CPU and the TPM for the launch.
+ - The secure launch is then initiated with the GETSET[SENTER] instruction.
+
+Post-launch: *Phase where control is passed from the ACM to the MLE and the secure
+kernel begins execution.*
+
+ - Entry from the dynamic launch jumps to the SL stub.
+ - SL stub fixes up the world on the BSP.
+ - For TXT, SL stub wakes the APs, fixes up their worlds.
+ - For TXT, APs are left halted waiting for an NMI to wake them.
+ - SL stub jumps to startup_32.
+ - SL main does validation of buffers and memory locations. It sets
+   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
+   kernel that a Secure Launch was done.
+ - SL main locates the TPM event log and writes the measurements of
+   configuration and module information into it.
+ - Kernel boot proceeds normally from this point.
+ - During early setup, slaunch_setup() runs to finish some validation
+   and setup tasks.
+ - The SMP bring up code is modified to wake the waiting APs. APs vector
+   to rmpiggy and start up normally from that point.
+ - SL platform module is registered as a late initcall module. It reads
+   the TPM event log and extends the measurements taken into the TPM PCRs.
+ - SL platform module initializes the securityfs interface to allow
+   access to the TPM event log and TXT public registers.
+ - Kernel boot finishes booting normally
+ - SEXIT support to leave SMX mode is present on the kexec path and
+   the various reboot paths (poweroff, reset, halt).
+
+PCR Usage
+=========
+
+The TCG DRTM architecture there are three PCRs defined for usage, PCR.Details
+(PCR17), PCR.Authorities (PCR18), and PCR.DLME_Authority (PCR19). For a deeper
+understanding of Detail and Authorities it is recommended to review the TCG
+DRTM architecture.
+
+To determine PCR usage, Linux Secure Launch follows the TrenchBoot Secure
+Launch Specification of using a measurement policy stored in the SLRT. The
+policy details what should be measured and the PCR in which to store the
+measurement. The measurement policy provides the ability to select the
+PCR.DLME_Detail (PCR20) PCR as the location for the DRTM components measured by
+the kernel, e.g. external initrd image. This can then be combined with storing
+the user authority in the PCR.DLME_Authority PCR to seal/attest to different
+variations of platform details/authorities and user details/authorities. An
+example of how this can be achieved was presented in the FOSDEM - 2021 talk
+"Secure Upgrades with DRTM".
+
+Resources
+=========
+
+The TrenchBoot project:
+
+https://trenchboot.org
+
+Secure Launch Specification:
+
+https://trenchboot.org/specifications/Secure_Launch/
+
+Trusted Computing Group's D-RTM Architecture:
+
+https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
+
+TXT documentation in the Intel TXT MLE Development Guide:
+
+https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
+
+TXT instructions documentation in the Intel SDM Instruction Set volume:
+
+https://software.intel.com/en-us/articles/intel-sdm
+
+AMD SKINIT documentation in the System Programming manual:
+
+https://www.amd.com/system/files/TechDocs/24593.pdf
+
+GRUB Secure Launch support:
+
+https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub
+
+FOSDEM 2021: Secure Upgrades with DRTM
+
+https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
+
+.. [1]
+    MLE: Measured Launch Environment is the binary runtime that is measured and
+    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
+    requirements for the MLE in detail.
+
+.. [2]
+    ACM: Intel's Authenticated Code Module. This is the 32b bit binary blob that
+    is run securely by the GETSEC[SENTER] during a measured launch. It is described
+    in the Intel documentation on TXT and versions for various chipsets are
+    signed and distributed by Intel.
-- 
1.8.3.1

