Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13045B333
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 05:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhKXEpp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Nov 2021 23:45:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45966 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233001AbhKXEpo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Nov 2021 23:45:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4URMr006048;
        Wed, 24 Nov 2021 04:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=IZ3EVVqKZ62Sk+sC+pAxoB9qQYL0em+BJhyKFiMasQs=;
 b=GrYatHQ6VVn1W/7ZtUNoc8tOc02zDxX/MgkyrDBy7ic8Rng3qSVquqRA98v+TkjM0Cz1
 yJTrB9TutOuL5GiHvwt+iDr28g+V/fuhXIITZuyPQPil3YF/vCOSgTgKBrFm302HKGu1
 qmRCcjxgVCdETJpNfw9N2VyLZx50DOAlgnom7jWT6DCKo7zezLGzBRqkx/7C3YJNUQpf
 7IanvBCMIYRdP+VRIwKVtReJKgqZCxRyp5EV2Lvb7pUlSXYWrvSQaXon30yAJ0NPtv2h
 62Kw+e4+5CHFpXyOi3f5GZqnt8evEbkOTQKaK4fkw21AsR1MmsINgcL7DqEXsTOiJbFa lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46fewhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:41:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AO4fXBr181923;
        Wed, 24 Nov 2021 04:41:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3020.oracle.com with ESMTP id 3ch5tgp37y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 04:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Rs2wRwCIy9izTAaak7SK5iG8FyamWKoW+B3xvFDqe62WpBa0LKDAQwp/7WtV7wFPtnKn0BGkKvZk7R7gLHb/9xI2S/1LsnYIXXZsWcDjAp8Zkptiy/1aanA1htEO+kzM6R6fx0gPHhs+hmDtNisVeDmyy5cjam6WzFmTdA/21qJ1POKndIGJ63QXawmFnCNMHBp8Zs9kKDVkWZO9xmq1GxkWXIf5xatjyFLgkx2jJSI3xPzJRi9uAhlnVMRNu5kphfR+deaCk+MhpBe9mNrMtWI3qEct85lcPdnE5kX9chCVM7MOvAIxWDOyIbmbRWftmseNS1oFk8VFwyrzwzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ3EVVqKZ62Sk+sC+pAxoB9qQYL0em+BJhyKFiMasQs=;
 b=b9ZAMGGuVc812cOUcwsRRBaZs7bkJFdiOSxDPJZl9Ui6i0gRsJ8k3Ugvn7ZeqPkUWHVhntngtVf7peM16auxJvDjkOLtAVsQ2+24XC+XLrm5NbdIscn3NDLW8Q8UUWbK4xS/llmhTxVx/3aAN+amB9en59DGSgeXuj4b0ZNGWU8rF94rSENWu/AfMJgIcMJiZmaMSE2vTaVi8gnBNTbbFmLhfgOYCi3oAz8zMWbx3hnH7xCigvUba+voE8d+8hipCuidM9JJTY2rca2774xC+pJvge+/93OvTxyLd7Nc9w/ssiylM8f1NrqFj+1eiNSHjmfRF/ToQK09gyJeIda5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ3EVVqKZ62Sk+sC+pAxoB9qQYL0em+BJhyKFiMasQs=;
 b=XWsdv6nq1BFsGVP817lKTx9DaI3gGeOB5A5/5ISm0f6/ta6y3IVYiVWV15NTTa1boCcw5Tkdhwk8FGUcuC/R+S2No6s8WPzo4fwef5wGk3u/mj9rGR3JWGFmYxVJJNttmrNOGiRk6YvSzBGL+x/448DtWvMqU9s7q+n9k/2eZjA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3957.namprd10.prod.outlook.com (2603:10b6:610:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 04:41:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 04:41:51 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v8 00/17] Enroll kernel keys thru MOK
Date:   Tue, 23 Nov 2021 23:41:07 -0500
Message-Id: <20211124044124.998170-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.10) by SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend Transport; Wed, 24 Nov 2021 04:41:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6ef8d4-b20d-4309-7e10-08d9af04bbaf
X-MS-TrafficTypeDiagnostic: CH2PR10MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR10MB395794E243AFFA31362D00BC87619@CH2PR10MB3957.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySRdHUUxYU8+pY8IrXAE5jWOpdGaobXYg1e/WmBB9QEwUftAEBuqAv/PskE3bhOfcnuKkdqrdazEsjVin1CYigAcT9euxV7ONRItxNOThQJ6fDYo0MC4Zb1xUBeaGikpW3ziInPuj0XO2SzEpsjrtWPb8G0SxMp1iQNJb43EWP8e5sOgJZkgCNlUY1cap4j8JLbg+/uaqf+DqeuNiL4igMSfUB7RQjAqAMjfMeqc55rDfxc8h3OZZZjxy+hHAvWlLMDosnkd3VibpcthUR7GB8Yp/LSv/9/mCFlO4ob8XagF4XWNqwgEkmTqiOMlJDniYZE1hUjecqA/xdb2LgSbBQ/b9dyHol73QNhyR0IO8UIIgHBEk7gq5zzxIlSkp2BLoJ5UKDylRQ9XcvQQJ+ctOysHJ+YzRQpYAvcHsvAc2UMRbHHk5Ww+ixplXMwbg7k8YUIfz9cW11yEITrlbXLnLYe36ipRFmlGWI3y4DfX4deqj0OancK44+Q3VhkEtOg/enKwbrO6ijlT8t7dyvDb+T7gY6TvMhh58x6tFSRa5obeXA0/iOT0grsovawg4D75JEh1xyV/MowGHCV5kH8Oa+fhfSophxfeFvk5zIb4z1A4duPXN85jpbfBvFvHT8bfZZ5OzryZQ9zm8egRqe9kUzfGyOptqBrxzqjYqLsS9GoMW02dvwmo78HE6xxscszX4VlFQMCCWppWg6SxCH/PPTON0zTrjBx9n4jltxw0sdJIglpUxRFC2YURy3DRrHo6FNCu6S3rrifTKHSNkacsE1o7wiOSEH3vpcobZD8iHFaClK962mqXVMj6Kp36QXKg/zKjnFVpOmSvYbKsJ76OOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(36756003)(66476007)(83380400001)(921005)(66556008)(186003)(7416002)(8936002)(52116002)(4326008)(956004)(44832011)(316002)(107886003)(38100700002)(38350700002)(66946007)(8676002)(86362001)(2906002)(7696005)(966005)(1076003)(508600001)(6666004)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EojHdbfkWcrbuYKx/O3wTlalVL0kEPz4gWzzmC1KrtLHqSODlhmwShfzpatu?=
 =?us-ascii?Q?NDfz0eWYYYOMYsOZIFJjFmJlKo/jercA1Koam7Pi54Bga6X6K+kuo9r7CEjN?=
 =?us-ascii?Q?X5sza2g6KS3AWx8mqsIfb4s9mcst6+8VDWSPdaFmJW6f5Vf2ZXpb+JqxIf+n?=
 =?us-ascii?Q?D3zdBK+68BaIcR3OrAVPf4rzU1YNDVRJhujcATf1Mfvdo0HBajlySW9PUruh?=
 =?us-ascii?Q?KEAxKXJMDcqEKezTZf8is4SjBKFhChvVDlKmY7v4RjGeOnGm6QnF/hx5vmNE?=
 =?us-ascii?Q?9/L87lfaQA7kqjRJHlI/DOE++Lg43E4anGGESi55ChUDRndCWo56IM2Itd1O?=
 =?us-ascii?Q?2/4VNJFW4FErGMt2V9mCHSqXkGfSlBcOmChXg21wZn4Ltx2lOM2Nu9WBzRfN?=
 =?us-ascii?Q?XLUow2HVc7q6jOJv2csIPa2xUXn61FZDei7GH4VnSrW6XKeMQZJklnbbIhhc?=
 =?us-ascii?Q?g6eQGnLqY00Gzs/dK7INBpDKyxQo0EynFjhb6ffN1LjhxUeYMzJq1zmmOkeD?=
 =?us-ascii?Q?ppi9n7U9kdyinN4YpkKlw7lj58gqxy31BzKSHZYeqkRwdJH7UHRuLch0mmzS?=
 =?us-ascii?Q?c+9pifHgHDtTiXeCe4rTAiTARMZvcdbTXd0k1bleqcO6Vrr+ufJWv8OC+nIM?=
 =?us-ascii?Q?X8vfUrtnlq8xl7xiiP6mDcxFarOpdNdKRG+yDv5MTnwIOO0D7YmuGz7WEPj0?=
 =?us-ascii?Q?W5JElysFNVXGNP7QxkTjvBrOhjonW141jByt6rX27Wq39DWBjaiDOgjkQQoT?=
 =?us-ascii?Q?eILKZ97/PEqa+9qNnw9IoOoFs1jWwPOTS9cTlqdL2DFHC69FAL4fJDod4QTO?=
 =?us-ascii?Q?+/Gt2H7M3HNRBmSaMS3HbhvEvyAgBVpePcM0i9NVdT7cXhFTs1Qvv/0hoACZ?=
 =?us-ascii?Q?vSXOh40lU2R9+0dIdBnKXLr/Gl7ea3wCDrFZm8jO6TVs9ViQAzznxQKPrtAV?=
 =?us-ascii?Q?YVxQ0H414P3U1vryIhiQT4naQd8nXqedzuhnJoLfvZ/vwb717biTAPyBdYXS?=
 =?us-ascii?Q?DFrCLqICFDGsCn/WkoWE6thXAKRBPYJUCUR/X99kFfaZDm3QBg4EkzL3Du1A?=
 =?us-ascii?Q?YfKJBCIa74N9KRtM/3Jp7NkGmdIzscCB672W1V4rCAYoqOCq109K7k8IDgkI?=
 =?us-ascii?Q?tXi6mcnEoMm8pzodCB/2bfWhTkYi8no73Jl0tT2bEnA2cAWpFPH27EHkFGFS?=
 =?us-ascii?Q?fDf3kdnNKIWBYo2AnM6ORebaGMdS2n/aJ/Tk3z1sZRarJ9NyHwgZgvBT/4u6?=
 =?us-ascii?Q?G5c6MldPB/UTLwN4y5bUL50QHDCocRQyTDikCANGdaQT68qKPtQEaP5fTKZM?=
 =?us-ascii?Q?+M7VImzTgDQk6zKTWal2045xqHV/aEclDz55iuvJRoyVH1vXUOpWTdSQZxVD?=
 =?us-ascii?Q?2ldcquqyVf7o5HZy5yEryTSyHFFsWdz1zc9vqd7twGADSKm6jUflwYw3zkSc?=
 =?us-ascii?Q?y7lK22NxM5kr/no5ZgqZQcuj+ZonGs2lWZBD65RAtiuZZ/jwAEh4CUEddnPV?=
 =?us-ascii?Q?qTvrEClwr56ChevNmTMchnGEgfHhT3uQmkF+FakYITyqP+yzx/QrnaLXyS8+?=
 =?us-ascii?Q?bz31htA5jRh/AnBvgZqs3zVJ4cy9WTIPI8m5BRLoKM94oZbpTZwGfDfwWKdi?=
 =?us-ascii?Q?EG9o/Jv/TaaS3x9qTqazH1ggqA+4s1w9L/gLbkevPWxATNzfYXy4rbae4l4s?=
 =?us-ascii?Q?up/WWQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6ef8d4-b20d-4309-7e10-08d9af04bbaf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 04:41:51.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpZngB1Y8tQ7/7fVtZbYDTl/6hgUDPvYfSgYHWqFtbnkgIsk50D0SQ9pcbKAnR5DniSdIO+ZK7ZUhlk1/EuY7mv85iq30oiuaXdiYrwmmys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3957
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240026
X-Proofpoint-GUID: Td6YvcZq02t_i46VZxSb5mDzOlOgSEil
X-Proofpoint-ORIG-GUID: Td6YvcZq02t_i46VZxSb5mDzOlOgSEil
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Back in 2013 Linus requested a feature to allow end-users to have the 
ability "to add their own keys and sign modules they trust". This was
his *second* order outlined here [1]. There have been many attempts 
over the years to solve this problem, all have been rejected.  Many 
of the failed attempts loaded all preboot firmware keys into the kernel,
including the Secure Boot keys. Many distributions carry one of these 
rejected attempts [2], [3], [4]. This series tries to solve this problem 
with a solution that takes into account all the problems brought up in 
the previous attempts.

On UEFI based systems, this series introduces a new Linux kernel keyring 
containing the Machine Owner Keys (MOK) called machine. It also defines
a new MOK variable in shim. This variable allows the end-user to decide 
if they want to load MOK keys into the machine keyring. Mimi has suggested 
that only CA keys contained within the MOK be loaded into the machine 
keyring. All other certs will load into the platform keyring instead.

By default, nothing changes; MOK keys are not loaded into the machine
keyring.  They are only loaded after the end-user makes the decision 
themselves.  The end-user would set this through mokutil using a new 
--trust-mok option [5]. This would work similar to how the kernel uses 
MOK variables to enable/disable signature validation as well as use/ignore 
the db. Any kernel operation that uses either the builtin or secondary 
trusted keys as a trust source shall also reference the new machine 
keyring as a trust source.

Secure Boot keys will never be loaded into the machine keyring.  They
will always be loaded into the platform keyring.  If an end-user wanted 
to load one, they would need to enroll it into the MOK.

Steps required by the end user:

Sign kernel module with user created key:
$ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
   machine_signing_key.priv machine_signing_key.x509 my_module.ko

Import the key into the MOK
$ mokutil --import machine_signing_key.x509

Setup the kernel to load MOK keys into the .machine keyring
$ mokutil --trust-mok

Then reboot, the MokManager will load and ask if you want to trust the
MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
module will load.

I have included  a link to the mokutil [5] changes I have made to support 
this new functionality.  The shim changes have now been accepted
upstream [6].

Upstream shim is located here [7], the build instructions are here [8].
TLDR:

$ git clone --recurse-submodules https://github.com/rhboot/shim
$ cd shim
$ make

After building shim, move shimx64.efi and mmx64.efi to the vendor or 
distribution specific directory on your EFI System Partition (assuming
you are building on x86). The instructions above are the minimal
steps needed to build shim to test this feature. It is assumed
Secure Boot shall not be enabled for this testing. To do testing
with Secure Boot enabled, all steps in the build instructions [8]
must be followed.

Instructions for building mokutil (including the new changes):

$ git clone -b mokvars-v3 https://github.com/esnowberg/mokutil.git
$ cd mokutil/
$ ./autogen.sh
$ make

[1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
[2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.com/
[3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com/
[5] https://github.com/esnowberg/mokutil/tree/mokvars-v3
[6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f
[7] https://github.com/rhboot/shim
[8] https://github.com/rhboot/shim/blob/main/BUILDING


Eric Snowberg (17):
  KEYS: Create static version of public_key_verify_signature
  integrity: Fix warning about missing prototypes
  integrity: Introduce a Linux keyring called machine
  integrity: Do not allow machine keyring updates following init
  X.509: Parse Basic Constraints for CA
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
  integrity: add new keyring handler for mok keys
  KEYS: Rename get_builtin_and_secondary_restriction
  KEYS: add a reference to machine keyring
  KEYS: Introduce link restriction for machine keys
  KEYS: integrity: change link restriction to trust the machine keyring
  integrity: store reference to machine keyring
  KEYS: link machine trusted keys to secondary_trusted_keys
  efi/mokvar: move up init order
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use machine keyring when uefi_check_trust_mok_keys is
    true

 certs/system_keyring.c                        | 48 +++++++++++-
 crypto/asymmetric_keys/restrict.c             | 43 +++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c     |  9 +++
 drivers/firmware/efi/mokvar-table.c           |  2 +-
 include/crypto/public_key.h                   | 25 ++++++
 include/keys/system_keyring.h                 | 14 ++++
 security/integrity/Kconfig                    | 12 +++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 23 +++++-
 security/integrity/integrity.h                | 17 +++-
 .../platform_certs/keyring_handler.c          | 18 ++++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../platform_certs/machine_keyring.c          | 77 +++++++++++++++++++
 14 files changed, 287 insertions(+), 11 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c


base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
2.18.4

