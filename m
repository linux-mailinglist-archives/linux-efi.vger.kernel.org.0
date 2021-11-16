Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3C0451CBC
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 01:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhKPAWM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 19:22:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54664 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352234AbhKPAUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 19:20:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFND6HX009039;
        Tue, 16 Nov 2021 00:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=LRyl9EOYXLUhvvm+A4Lks50Kaucjr3HyfqzgGnitWV8=;
 b=0hLHTfMyvC5+GQIZVlmLo9p+Rfl0Cb4Q4b95tN664yfBaKWGRdXIXUYLULXQLuU9ev9C
 QN/Xh+CEKAKwaG2kCSRWVQ7UBuD9UIL2HZbi+roKYz1Qcbe7Z0adjg3DzVJbA2g1U9V8
 +IHTHCXBjZnsWQzoEzEe35sqeR0oeRRTaLoasAmoeoCXTYqtVJBwaPMMYqbZ0/R1ZhYw
 whw4zQ1bfUdZFkymXdlqw9+GGwg0buXvPjhafDB8vOZBj6qdaPjNiHCnz0nRepXZyCOa
 hq+9QQzcrPx4gvscWnSM6Ox7t3FtcDC99Mxb4on9qxlSvWI+fM4VxqYLu6ttCDo/xVsd 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv7xb2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG0AAp1136120;
        Tue, 16 Nov 2021 00:16:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3ca2fvcg9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 00:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HayDajiz8r58acGnXqTbTBqpKKUykJs8ppbB5bGE5oGN1nh3vh1Bw8G9f4YhmLuI3JHP0KAXHEKOKmBUAu2hokFAAJVCJooKAGVbQ2IuzCkY1I84DNBEcZuH3eFBZcwB8kSiIWT5+1pxHN1KvVJLehDPRNn2/VcZvRxogFRf+4Azt0vir16Eyjh4OtjxIrRrPXwbJFm0q+mZAfbat69XliCZKxF+oGomwWeGolPwRS5aoDMYW08r9BWQuGXTPKDC7q/WvAhtrczNfAneRJ02aWIB3sZEkt6Iae9RWNiSDB/csPCBCsURMoW0vJ8C/4HJoshCOcZyNVV6morD9Qn6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRyl9EOYXLUhvvm+A4Lks50Kaucjr3HyfqzgGnitWV8=;
 b=iCShZ+HjBvJnOaJIect/SnTJYXkbK/akXDHETmQGEzw5GXoIq6a011+O6nJ7CTrOXW+Y7GfXxqtAj34Jcj04lSdsxGruZ0pKs+EcPm0oXChQ23Z8Q7jV5bdLROXGVbYc/36Dhcc/qaq+cIv9vfeuhV9TeY8u4fXRxCoiaQLThMnfQR1Xc5OFd3cT0Z6sqzmFJcb9E9dYIzNXTr8thI4iLsNlLYRn79YmaxyGYLzofFUqn23z5Mt7Gi3SMwIKdNKGdb+Z5kYSvlxIcwYnmZOhHyEtWXSqmcvpNTh1fanTGRWg0gZ2jxtjN8DVGkUfW0NDLJAxRDhnT6RRj23yFqz7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRyl9EOYXLUhvvm+A4Lks50Kaucjr3HyfqzgGnitWV8=;
 b=RDsSaPvtWtuZhGNJE4Cal9aGl4M88E8Ey6KLgCFJe8IFlg39t3rwEX7+IplQHctOIM+7LMCEn1L1lIEbStZ9YPQyZ15KzXdevqJRtcOwjTZxXRtRsPLZGEmL4Vc61rplqS3rdIYzxT9Ketxj9z8x00gI7CxfNnKEFCBSpA9C4EE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4358.namprd10.prod.outlook.com (2603:10b6:610:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 00:16:10 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 00:16:10 +0000
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
Subject: [PATCH v7 00/17] Enroll kernel keys thru MOK
Date:   Mon, 15 Nov 2021 19:15:28 -0500
Message-Id: <20211116001545.2639333-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from ca-dev113.us.oracle.com (148.87.23.5) by SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 00:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e1945e3-bf69-43dc-2164-08d9a8964ae5
X-MS-TrafficTypeDiagnostic: CH2PR10MB4358:
X-Microsoft-Antispam-PRVS: <CH2PR10MB43580C5CB04C24D1BBB4D0E587999@CH2PR10MB4358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4ILroS5led61x0MO80OjbBJT3KNdQcN2HFbnHU8mddijDrCo2lvEuR1RgXPbAqcMP9iu1ny+mplhSBZU7mIIs0XPcVpJCJVybi/YHp4ZUb86Xjno85Pvt4QiTx7iMm7xvr2T4ps7XgEv598B7IJb9lqSHxOdoWnQQrml6u/m/uaop6gfTkSjBB0nUy1N1cBr3BecYF79eqneG2cY4M2VFQNz7Z3iFUqm4v1NSTcbO3NCJTC1tHcMrvg9b5PIHV96Y0mxP8lkltOv8Y3uHZJRryHKurwU2qMGQWN+CVSJvZd/eUsrkgoc2w48yD6kNDnPjCrcrn+82cVpKpVqmztlQHWDZNRhaCvCdpa2zRofYPIUlAmK2g99vJ7K5NwyE+fxwm9gAWoFkgxCHqls4oCz+PVpiK6235gUdD7J+QZnH1LYKx8E2lgxcZ5NA070zba0cwiZlO9UPmAfDH5GVJ5ZFZHHfPl0q6igabVUuUNSpvezNF+JGQLz4cR9+4g6iji4UgCweiIBWg9T4Cfc4r6crZE1JMlbxAoOJCoEmqD8ozUrOf7HvUMAWeoLlVjYS2h3gIqoKXmjchCKoFllSGOyZxRkTxDmXK+zBiXx9i8swzFobXeTsqP+TR6S+JZpeAIXs9pzvigwkt8wy33NaJYW6g866IZe+41bbfBjA7wvUg06oUDqVQQ+qK9YhvZP7TnyUesIKb9RFccizwfX7Xkgt0MLTybByOxH7Xwz0v8Kr8oi/mZMMCQx+XmZXZ5ePZur9Ku3hEFZ8qnDxmgGTo+fuqizVBis8mq7Yd83eTocc9CZj0MvNRsJS9RQWi/kygYdk+APHHjnREb1w21RrE6DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(38350700002)(186003)(86362001)(66556008)(38100700002)(8676002)(26005)(316002)(4326008)(8936002)(83380400001)(52116002)(508600001)(6486002)(7696005)(966005)(5660300002)(921005)(107886003)(1076003)(44832011)(6666004)(956004)(2616005)(36756003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYrGdigQ1UKCegG7MDYKp19KFdQhqDs6uRrOb+EBxOxQSOAPiVaNKadftZfr?=
 =?us-ascii?Q?63YtlAdAdONa0stmA+K+xUxyBBK9/M6kk1hlVrXH8dZWK8eySQVrcR/VqVfL?=
 =?us-ascii?Q?tkjyYsY3O1SJfOUx/o1im3fihMZGEqajBH+27FaD2g5kGcFl1glgRYTSCtUO?=
 =?us-ascii?Q?SmSiKscHSgSAihJUiRWcJDlqVzEM/VdEhiTZPb5VmGYsrPUBZTJBynjDOFYY?=
 =?us-ascii?Q?kR6d6yqdoTPGl2NR0vYZaXc1EnoaZm/OV9uvcR1I8b6WkQHDvgyzI3S7SVwA?=
 =?us-ascii?Q?23aAA/LjbhzT/V+HN3z9ciuJM5tkosCOlJSrvGMC7AQ0XXFaKaPZ+picOdHx?=
 =?us-ascii?Q?0mm3OHIP6m9qnEZ9kZOJhy/Y6wXuTsKJmGsF1HwtU5kYysZUlxaqHaIWkR9i?=
 =?us-ascii?Q?ck1mfFYBzXEfwJwk+PFFCVkhnJHAw+swdcuL6BUzaVk9YkF4lGERPQzjyi42?=
 =?us-ascii?Q?phrJguuS0u/Hx/zg9+/q0fz5prwCGIzdEUYZJ7tZb1ub5B4/gKrg95AAHBBV?=
 =?us-ascii?Q?/nDXlvNg7r5XuctJxL7CIQ6SmFDdTVKguyAX6UbuilxWMOQcqaEDYA8AcGiF?=
 =?us-ascii?Q?2OXW74o9oCli9TNxZdrxNR+/wRHYyhGERe/ahex68xhq2kVOFM+68ZceKOnW?=
 =?us-ascii?Q?Ucg+WjQbR+raDAhE7IM74PeRYx+SAVGIJxn5Jl9itI/XR0BC1tz/PUOUKdQ2?=
 =?us-ascii?Q?DpXJDOdPQBV5TsGBD3wAxcIp9a1AQ8EGYYTk2jJ8PsyBpmpms0D8lBXjOaDo?=
 =?us-ascii?Q?1a8b+EFKabJg6bKSxnVoPW9FRuEgIqECsBd8IbW943zdZOR9B2fgmU/BwOiv?=
 =?us-ascii?Q?2YNt3rpBa+fMqusqzThsjX/9RqSssgpSBKQEc3k2vgivYrTydxJOkHlFH0Gw?=
 =?us-ascii?Q?61wYKqVEA8lHDkYdbKbY2A/VnhUmbwdIDkeRPDTomvSYGBCv5tEWaL7DJaCt?=
 =?us-ascii?Q?vPP2MWLilzvO3yLu0v9m6DzynXH1TamUSIaBFCQ23vA5c2arhlm/V/G9JTQe?=
 =?us-ascii?Q?h89Rx5mD7kX1UAUrFUbc/mmutWQ+khJD6hqSgIABU4koTsCjKWMOVMmbbtI7?=
 =?us-ascii?Q?/AKAYT96guzezBapqbvQ4dXgNr1hExsH/UJmEmmn2koEQPr3dsPR4rE7AwuC?=
 =?us-ascii?Q?pgEruPcjMmzlyTeAnmgYOqtlGISul5350GLQPXT08Y9z5pCnEWGdLErusZkn?=
 =?us-ascii?Q?lwbALhhlSsjpzPfbcNx31g+sczQ2X/bRN+i/Ze+rWVMnWuYhWOhy61SXAQZ2?=
 =?us-ascii?Q?/leeQMokBkBlmUhqJeebKdPSdO2sbv7sUp/YCbnyCxfprVGdV/a7ZIFBkk8y?=
 =?us-ascii?Q?I1GFfY1+BG8GifW7aB2IcT/OBWu8XgMk/N8IsAPtJTozEq8Y/y1vYp0eb6Ds?=
 =?us-ascii?Q?5g1lOhcCFANt/TXv8OxkN5nXhYNTAlvzVLmxRs4/clNzjQ1LGJx0VG2VKlMB?=
 =?us-ascii?Q?aaV37wUBICaSXwlxINm/GAITTp2Plg9yRT6ffZ9QNDOqNtnpeg5c92ayvnyG?=
 =?us-ascii?Q?4zHGlVy/znUot0mxduTxOzZsFeyllkGrkjs9c+NHVbyZmlhRki2vsMB+vfLH?=
 =?us-ascii?Q?E5bOom4IiO5jNmAbmOTcx5kMECEFMNg2NeiHHLZLoIEWNWZhXQOQVx0Yzvg7?=
 =?us-ascii?Q?umXhmRO+2Hvd5jWFltTQuEroljveqBSLYyziNdHDkJs/QmAhzlZbmP+FeKPw?=
 =?us-ascii?Q?k/Sghg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1945e3-bf69-43dc-2164-08d9a8964ae5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 00:16:10.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olCoYrGBZYqy9v9PNLyv0Ybe5j3lUdXi/AuVggf9cLuL5ne+57HYDDePJCgnXWVwuT9wCmih52w2oTujFgaU3jWZMjascq/0wk0/oux+iz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150124
X-Proofpoint-GUID: zwH3XApdw6g7gKf91TKh9OfLcpmnNSWY
X-Proofpoint-ORIG-GUID: zwH3XApdw6g7gKf91TKh9OfLcpmnNSWY
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

[1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
[2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.com/
[3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com/
[5] https://github.com/esnowberg/mokutil/tree/mokvars-v3
[6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f

Eric Snowberg (17):
  integrity: Introduce a Linux keyring called machine
  integrity: Do not allow machine keyring updates following init
  KEYS: Create static version of public_key_verify_signature
  X.509: Parse Basic Constraints for CA
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
  integrity: Fix warning about missing prototypes
  integrity: add new keyring handler for mok keys
  KEYS: Rename get_builtin_and_secondary_restriction
  KEYS: add a reference to machine keyring
  KEYS: Introduce link restriction for machine keys
  KEYS: integrity: change link restriction to trust the machine keyring
  KEYS: link secondary_trusted_keys to machine trusted keys
  integrity: store reference to machine keyring
  efi/mokvar: move up init order
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use machine keyring when uefi_check_trust_mok_keys is
    true

 certs/system_keyring.c                        | 44 ++++++++++-
 crypto/asymmetric_keys/restrict.c             | 43 +++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c     |  9 +++
 drivers/firmware/efi/mokvar-table.c           |  2 +-
 include/crypto/public_key.h                   | 15 ++++
 include/keys/system_keyring.h                 | 14 ++++
 security/integrity/Kconfig                    | 12 +++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 23 +++++-
 security/integrity/integrity.h                | 17 +++-
 .../platform_certs/keyring_handler.c          | 18 ++++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../platform_certs/machine_keyring.c          | 77 +++++++++++++++++++
 14 files changed, 273 insertions(+), 11 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.18.4

