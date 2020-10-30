Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C478129FD94
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 07:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ3GJT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 02:09:19 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:54106 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgJ3GJT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 02:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604038155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EwLM8EdiTeXMlJuIRO4KEYoZHa/GGUM2PW4TelbrMJQ=;
        b=YQId5QH9KySPb6veHPR6sn1dceuqHzS1PB3FsozW+QE2uZ6VGX7RGThyuqrGPXLFlOtuXb
        W1T5BUbwxVeIjgf9FNuSSl3rFMBja/txtzkMW1lFbaxFIUDLs78P5mbC0cVHTKC3MYYCE5
        GgFRmvrF7C/NOX797Z+D/rN1dOC1RJ0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-4MIk-P-wMR6_9lbzTx12Yw-1; Fri, 30 Oct 2020 07:09:13 +0100
X-MC-Unique: 4MIk-P-wMR6_9lbzTx12Yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgh5j3vNLkjhMeMNoorek7lT/dJMaeOEDgmxs1ZOlq9zyU639U9KoHQ8SlIIM9H7dEibmb2W+RruIzkDdHV2V3E7oU2mSuTeFJ4vjVYiBBPOT5QsO4cxDfaYZE0RPCGp8Qmg0JELze05No0aIP2Lqs1Ual8VAtiUhcXliswhTInaSbW+MaU7va6gvf/3+3yu0ForNJKReQOswuom/LsW/rzK1PFiuE4R143iS2KY8DQnG2j0drN8pnd+uz8dAGK/29hP3EcRibv13vfXkK0hLek2Ib0HOc1/fgLIo5737lHte/DYidsCahNyltUzYMV86/Ln+hMDK8XsSNIC6Uwk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmNNHcu67n2vdsu1WUtLH5p1UhNHv9xlM+KQkUkoI+k=;
 b=D9mpbQEIcNrSzx9vvRAlD/Nr12G1YcJ4+Nfg8nGTcJR2zfYBEVZA8atZMfGRaiUOajgth4EoUgEwcAsDk4Yj2LmJtKr8DIIv13fIfhl5+B6MDZg/zfxyj5lFJSOPAC2N75UBxqVwbOE+XJDg3zgdkZxHH2ulC6PDNqovWp72xmfM+S38yZ5FekIp684xZzIH1sWaxUjWngIFN6yfk5B51IU99vfv/7AQRLkcSgYoWHlVXJI5oa+k3fa7ewdZPhql+HF2SCFVAEml61dnFQLMcbbObkwCXNxw6JpHIUjw7traCTRGuRzmhjn1mAGYBT0MxvzvdgLYqqUiHmpDX2Ppnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com (2603:10a6:20b:c::23)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 06:09:11 +0000
Received: from AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b]) by AM6PR04MB4919.eurprd04.prod.outlook.com
 ([fe80::f063:76fc:db1a:905b%6]) with mapi id 15.20.3477.035; Fri, 30 Oct 2020
 06:09:11 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH v3 0/3] add ima_arch support for ARM64
Date:   Fri, 30 Oct 2020 14:08:37 +0800
Message-ID: <20201030060840.1810-1-clin@suse.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [36.225.26.227]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To AM6PR04MB4919.eurprd04.prod.outlook.com
 (2603:10a6:20b:c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (36.225.26.227) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 06:09:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab59ff4-316a-4402-1a08-08d87c9a51ab
X-MS-TrafficTypeDiagnostic: AS8PR04MB7943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7943E538B07B57A98A636753AD150@AS8PR04MB7943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0c2Ke/+KB2tDU//XT2Xjh6eKlYecCctsLX/Tv1OllZRfGLxZFdI/YW3mTJkBMAUPhvOTaO10x5OC9LKfKj0RPlwuvLMOBSVVTZPtlcbFSU1tcBwUIWhG0mOnIbGMiMCcXIQP3Xykd7/OzW4UrDdFwAFXxU8YJW52zR8KUIv96Afx3JT07AUnFkWOMsCpqIl3Mcw2TmT7z8UQiF62G67Mcl9YEPuSKrghznv47ZD+L/u4/pm0IQBLaHLtjthHM5sECtr0I9AZOFW/J5Bx5mg5jPFoIPqI3z+2Zp/i3VhajaNoumND2k6Ictl1eCcUnI8Ky11cxXwd2FPVXfysPLvoBFZ79lpYwRkJmAHRFyV46Ez3FQoaigsPWWti3a9HTsfiuOSxGypO8S/DuwvA2hUVzYmRX9ZSr3S4qPL3RgtewN2W3k6XxDIDhfvU0ReW+KmWVIaO4zwesKSZmztLzu2EBZwiL3wDNNkOeWGmmHdRHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(186003)(2906002)(7416002)(36756003)(2616005)(16526019)(1076003)(956004)(5660300002)(52116002)(6486002)(8676002)(6512007)(66556008)(66476007)(66946007)(86362001)(6506007)(26005)(966005)(69590400008)(8936002)(316002)(83380400001)(478600001)(107886003)(6666004)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /tjJi9E+C8+dfN7RLXKN/ZqEcwDt6t/MZahW4WekWhVSB8LxsYBK6ymOAXUwUJC6f4ufJBblRAIWVocmh4IjP4K2eLmNksYiZEe0+KVSZI4GqFXnV+fGOeNchlu98dILt+s3hT8k6JlJMitJaod1JPaul/eHSsuFbqicHTymahUA30ydwPq69cK8YD+W5qYC9MXb12zYk8akfQw1C6Q+nOnLdYpKzMxkDfeHldy59fHH/iTgbxoStxeoL4lkgXwSq2IKXyVdVztFWpKv0UNbFPt6n/ofW+WhvuQNwnjl2tfnFIXP4tJNO7UjAwV2UFMfJZCvTPq4V43r00YBVamgcnZtH05ukAcSAA9ccPK2wq7BoBfwAesmctrcje/wkhas+TlmWs6/J7CHrP4TbkVng2uR8QusZncY9wvbSj6rj/FxUlM1hWD244vF7lD3cVyIKfFC0D27qdw9JsV00+EHCzB+JVsvKrjcBHk4MJ6ZYETxle3hoNp7kn69pAfP1kexZLxiTBT4jgS9pLZkL7wWaE1nsWJDH2n/Ugfm3TbJ9nIYrXbYC/pZSm0+7a7pT/Tkk6PkS1rxzTXaCtWHIhUJjmyaLl/uuuVggc+O2H0RlGtv6yLsyZc8B8zBdnqip3CcwK7tRc9L/ld/RkgB7QVK2g==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab59ff4-316a-4402-1a08-08d87c9a51ab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 06:09:11.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7b/WVi+KhTe3nN9mU0H8ooXU6py2gLtwRliBoMVBM4XO3wzr5LYy4FgzK9oKjcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add IMA arch dependent support for ARM64. Some IMA functions can check
arch-specific status before running. For example, the ima_load_data
function or the boot param "ima_appraise=3D" should not be executed when
UEFI secure boot is enabled. We want to fill the gap in order to complete
the IMA support on ARM64.

Changes in v3:
- Generalize efi_get_secureboot() so both ima_arch and efistub can reuse
  it.
- Implement ima_get_efi_secureboot() as the replacement of get_sb_mode()
  so x86 and arm64 can share the same logic.

Changes in v2:
- Separate get_sb_mode() from x86 so all EFI-based architectures can reuse
  the same function.
- Refactor arch/arm64/kernel/ima_arch.c based on Ard's patch[1].

Test platforms:
- ARM64:  QEMU [aarch64-virt] + EDK2/OVMF
- ARM64:  NXP LX2160A-RDB + EDK2
- X86_64: Dell Lattitude 7490 + (BIOS 1.14.0 01/22/2020)

[1] https://www.spinics.net/lists/linux-efi/msg20645.html

Chester Lin (3):
  efi: generalize efi_get_secureboot
  ima: remove get_sb_mode() and create ima_get_efi_secureboot()
  arm64/ima: add ima_arch support

 arch/arm64/Kconfig                        |  1 +
 arch/arm64/kernel/Makefile                |  2 +
 arch/arm64/kernel/ima_arch.c              | 43 +++++++++++++
 arch/x86/kernel/ima_arch.c                | 69 +++++---------------
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/efi-stub.c   |  2 +-
 drivers/firmware/efi/libstub/efistub.h    | 22 ++++---
 drivers/firmware/efi/libstub/secureboot.c | 76 -----------------------
 drivers/firmware/efi/libstub/x86-stub.c   |  2 +-
 include/linux/efi.h                       | 41 +++++++++++-
 include/linux/ima.h                       | 10 +++
 security/integrity/ima/Makefile           |  1 +
 security/integrity/ima/ima_efi.c          | 26 ++++++++
 13 files changed, 154 insertions(+), 143 deletions(-)
 create mode 100644 arch/arm64/kernel/ima_arch.c
 delete mode 100644 drivers/firmware/efi/libstub/secureboot.c
 create mode 100644 security/integrity/ima/ima_efi.c

--=20
2.28.0

