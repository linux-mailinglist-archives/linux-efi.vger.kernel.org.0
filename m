Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095CA49C190
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 04:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiAZDAK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jan 2022 22:00:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40230 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236716AbiAZDAJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jan 2022 22:00:09 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMmuPX004064;
        Wed, 26 Jan 2022 02:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=ksG74+G1hE4gOVM9gnVW8VXwwcvw2ccI018s9sAgVXM=;
 b=q5Uv/quiwAZAPPoceRG9MuYPZOEhJ2qRI24FF8Qc2hzrVY/dzT1KryO3OsPyMxJJ/Hsn
 VIjH5vMSartvdEKsfIcOTJj0tl67PbmrxKwJc4UKVcB5N1TPdG+qhPGiAr49MDpGVoaF
 DJ1NtWF4S5YkgQlhrdzQiDeTCmboBhOxI+ek7NspOmEIy7VRiVllP6RqpljWs8ntFifV
 aOT1914vpj1GwJRCvETKQa5QqQic9z1q9Gt7fkiRsyZzxbSJObj/aoTBSJoeycg4teFz
 BFQqaHtJ4xOpVGIbmaZRPmaPLs6972ukx6u2uL1WLWwDKAn0XNCrQoocoqrVAln5trh/ MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaad0xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2oS7d068311;
        Wed, 26 Jan 2022 02:59:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3drbcq7v4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuGYtMM9PIiHgmVRWryHdyfUpeYmrwgwNb+7DhjfuUqgG8P4UkulABdX1wuJmPA+Zro6zJMZbLQsCQ7vW3SAh3u00vVpR3jhnomfVQVTa79piMoijl3jOlDZTaO1ZU2xGukYQ1Nhq0n3tgOjVsbAnN7kvs3dI6ALkqlOogGSB8CviuXkc4GRwwUl4plDHOfknklb5M7u1m+yUVykdQ6KTVQtcPumhx99ekynFkSu6bssh7BXMV2X03myS1uM6WAZCuMkjplw3ZBOVbKnqGY5mzRVl1dV1CCpPwBdip51yC81Cfxjpyyhd+ro8Derilm1iKP5ejWKNvHLBcBI/QA2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksG74+G1hE4gOVM9gnVW8VXwwcvw2ccI018s9sAgVXM=;
 b=PFW3fGjqBlrHTOPuVtl65HHr/aaR/X9kUplx+7XfkWJemTP6tzi7dHxoI+cPMEOaLTklME93ZKHb8XWj6nHdjYNYFLaHnXbEGs1husgOCSCkgA+eQxFTSsntREjoaUEdgstZkiE9PAh+NwwpSbwefmO6e1WwuRXg/88/pk8a6rJ2x64wGGb7a/vggVFQzznxSN/PV55EjU95nafb2pbG+rrjINRJTHkFbd7DbVtJGyjZMwNTQMOiD33OhxjmKBhyqI9gyUvI0DDUcqXn7vaIR7vT0PKP+jbKGrkWz33Ylz0WzsA+u2OADqbz5Oxk77IkkGGp3KorUvhLAX8irMiwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksG74+G1hE4gOVM9gnVW8VXwwcvw2ccI018s9sAgVXM=;
 b=Cu+51O3VO6YM3Rnf5rTwuDeJeksnyqcQ2MOJmPD0jf/8l0UdbaKj2rSGw8YmFDoDHjJi4vIq2DXTrmhvRdD9kLiOGO8O5mL6H5hcSfWt9vBzItB7io3qTx1JkNGj1K2LM3ybYZZsrR2EP+4zC8nOBOzHPBKjgH6Zlmr5LPtKepI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:59:29 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:59:28 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v10 0/8] Enroll kernel keys thru MOK
Date:   Tue, 25 Jan 2022 21:58:26 -0500
Message-Id: <20220126025834.255493-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: CY4PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:903:c6::13) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6263f757-b62d-4279-0e06-08d9e077de6e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46543BBF1E24CC56C016FA6B87209@SJ0PR10MB4654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgThGRGAcR8jcnldC8q6WyTPjnOGT6ApPEcWwqCVCK5qlwYo9UXAQ5sOPAojrIJOTkJUhGDw52mMLmLhEKxi177PXxaTQf3dyLf5ZmWkqCtlB+erjS94ovwC3H0g72j4JHyLsOmMcKKo1OQDXHlpvFBULZUdF0rSamUCmW+0LL//Or/SfKTrmOy2K7Jd8IZAp/UP0E3Q7vwzQ5YClQRXeSstRpBes40hz/v19Oqb1HnyY7pOcDaRmMnf/M5uhe9LEyZEumrt/RNTK/6GoQgwAiJwUX7AtnJ2H6+Ep+3PwuY+wlOQFySzOnnw1q0Vxd+ZBrDdwl63eB2a/Z7xFWJkmef6gQP8RMtRFysbiXbQ2xqGk7rQENEG4BNClXIWK/pXNKR/kUfnmQpPVnWgWdzAA12Zqz9cvQUOMOeLxHrMknyvGgFhLu3wk/TeEdR9Mc/TGiScMTMhIph+PKqyXtfd3fm0I42YrtFoonrBRTRTIjetoY0q+Y2JiXhWPaIgY5bPwxCJxWe0EHRYcIbFHF8/l5nBsBwVK6fHstcBV5/LiYn5GzuTlV7/oblgxRGFhBmp5ZkkB2bX9CYIXtDMVb6Z0qCKfixWWouuQwLH5Y4yJk6edTx4qQSNYWCa2YvsSChp3b5UJJUVkQbUTsXAPD65wFtByxzYZhJWrWRLgHiOiaZSZ6t7t4C5mCgEg1KdVGTSzcyYAm2Kx57khLu+IIDkPLjkgck7pZUiYnz5z2qCbJtsk4CDvo4RZ6ix/hGsYObML4rN9VaBpY5QPEoXxRjbye43l5kpzrMTHBHKg/FgY2Ckhr3G/rlEZvBt7cYBcNORKtSle7+GH3nbfp+b84Sqzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(83380400001)(8936002)(8676002)(5660300002)(1076003)(66556008)(66476007)(52116002)(6486002)(66946007)(316002)(2616005)(2906002)(44832011)(86362001)(36756003)(4326008)(508600001)(186003)(6512007)(107886003)(26005)(6506007)(38350700002)(38100700002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VZiOfylY8QIeTVUYXhBZ/3BS+stuKwlcxG2RI+FBtXVbXLz5sHAaEIyE0oH?=
 =?us-ascii?Q?0jdyqe0lHi+1X0Dn3YPTxAVZOky2GDDzMS9rB7aKW1rjHYc78oNA2KrzqP02?=
 =?us-ascii?Q?psy6O/zPjQ0ehdDLWZmJLMIZXO4asmfTLawKHEh5q7PLr6tLQzQbXkiqB8qe?=
 =?us-ascii?Q?RZgkwdXDHvl9bqChrzLthMCG1/oqNC17u5tiDykFtNDS8domhXR5MeVvId/S?=
 =?us-ascii?Q?2G8E1x1BYT4ZNqfpiQDhExJqdcq3PuuV46wY4x9uNlfj6Ho4K54Au+bWxbLR?=
 =?us-ascii?Q?UC2TtjM/OnYEDhnYE7HnbQ2PnzDogmorXi1qiGAcwgrv3o75Bz5KGZnmdLuD?=
 =?us-ascii?Q?23fsmRFh19HHW3H/WsyzplE8x4AhsvWCtBqaNyeDFuJCc5gmrKWC42hTMprA?=
 =?us-ascii?Q?5GdjDLLXWog2vyMfbVTi4ra25qn7NRFH7+zx0/vWjmY59rsaFQ4BXuyJ6f/k?=
 =?us-ascii?Q?qkJ7rDJhhCXS8EScxDZFhxQ1TZx9XLOoif3C3/obaJiFR9oIHWxtLHlJMggr?=
 =?us-ascii?Q?GJ9dpIbDh0Z3f2ZomD5TvJ1Nm+ulinRIfIqy0/e59ZXPtjhtKlcNYRyM1oWo?=
 =?us-ascii?Q?6YTkOhMrlDSPy6qF1PbHI09gKm5yysTPApOPu67vq78h2QT8pAU0G4HNPYac?=
 =?us-ascii?Q?RvS5vDVt+tJrqQITD+O/KDi3Cv3/DM9VEBzHQDeUr9vzp7yx4dBjw5VuyxI/?=
 =?us-ascii?Q?kWeD+/LeiivEWYYVwFNcVIkzebSi/AVB/TpxbKel1edd4Fuji8UneC78ykHp?=
 =?us-ascii?Q?1U6qKH7bI7uATg2c2z7GfDYPZo+70a1xC5uYaDBwYlPjYM4HBs+680lDrVgW?=
 =?us-ascii?Q?Bv7mYkUUlJCFbcD2ReCmWyG0zJTQkfCIDa8dsMiTfwYVRkNEkGlx+IGEsdgt?=
 =?us-ascii?Q?bE+Dzmtmrcp5ltT2bHWGE8VgEnwx1plcHBqDrqNLKMmPhMX6vHYrda2hZUbR?=
 =?us-ascii?Q?S96xquEcmgzSHRQrn4nNPt5R+ZKLrHk3mgcxuAwJlgADcop/pU3KzPY5iePA?=
 =?us-ascii?Q?McK5BkzNcYvHxZ6vKWdNdhACj69vjmnDhjWi6xCpqFuXyPZE+AQldkdgAcjP?=
 =?us-ascii?Q?1yqg7K7BlZ2enewAnnVAkoSF5IlfghHV6IGPXBGQPK2l2IvCrXg0W1Vmj4iA?=
 =?us-ascii?Q?P8lVgWnpt/L/02HOOW9ttj6pUdmr56/+A+KCNI1kbbjqBhkce5fXO/HSzCmK?=
 =?us-ascii?Q?U8IFNKF2P11FkTN3KDE1St+3tJWBAq6pXc/QSKji7MB3hbzZMCNPKKD7opwm?=
 =?us-ascii?Q?qRRJvkpPb6LCvxwEQ+VAR/2LPVdLgR2ooBDxChylixtqFPmBPaweAZ6XR6NZ?=
 =?us-ascii?Q?JUHJnF5yFavewZkOiS7bjczAo5wQubC3p4d4Kl9crlafNecgYN0i3xEzezVV?=
 =?us-ascii?Q?1bzA5G3blTpOD87Q34j+p2owFroY03GZYlWUS5pch75WPGjow/C8tR42fG2E?=
 =?us-ascii?Q?NmLT4LXPg3C6BZiLO4gxg6vi2d9a6c52Q+fM+p1JeUj8JBPBQeyl3VxKI0mk?=
 =?us-ascii?Q?YgbnF5OFESmpZ4/dHt2oHjMltNhQO6SBcU6ZE6xVS4QarQYSUCuuEzVQhCi+?=
 =?us-ascii?Q?NUoHnW1rrTXSZc4MIEaX3cwZq5mwxuCfIwtXiPjTz2W3mPW9FJvDtaG67/Pu?=
 =?us-ascii?Q?jb1fBOQ0A5rrzR6QKj8j4IJetji29PdkziM2SybTJTWGyDtSiYGzl3JYva1w?=
 =?us-ascii?Q?0L+kGVVo8/YqzAIUz+ilnxAMeZ0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6263f757-b62d-4279-0e06-08d9e077de6e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 02:59:28.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMvyHfCXWKKjJwpH7HeOxBgz4t3ZnxGu9NlSviuArv1li8YUEp8utRsC2+SojXxiPUPs/DJUHb6UQzqORrczZkb0CKBYqiW1BIxUC3GfvNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260011
X-Proofpoint-GUID: cmMkCd5yUmNU5kw5P6KXZuyVNflNLAQ5
X-Proofpoint-ORIG-GUID: cmMkCd5yUmNU5kw5P6KXZuyVNflNLAQ5
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
if they want to load MOK keys into the machine keyring. 

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

Unlike previous versions of this patch set, IMA support has been removed
to simplify the series. After acceptance, a follow-on series will add IMA 
support.

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

Eric Snowberg (8):
  integrity: Fix warning about missing prototypes
  integrity: Introduce a Linux keyring called machine
  integrity: add new keyring handler for mok keys
  KEYS: store reference to machine keyring
  KEYS: Introduce link restriction for machine keys
  efi/mokvar: move up init order
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use machine keyring when uefi_check_trust_mok_keys is
    true

 certs/system_keyring.c                        | 44 ++++++++++-
 drivers/firmware/efi/mokvar-table.c           |  2 +-
 include/keys/system_keyring.h                 | 14 ++++
 security/integrity/Kconfig                    | 13 ++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 15 +++-
 security/integrity/integrity.h                | 17 +++-
 .../platform_certs/keyring_handler.c          | 18 ++++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../platform_certs/machine_keyring.c          | 77 +++++++++++++++++++
 11 files changed, 202 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.18.4

