Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9871728DF1B
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 12:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgJNKl1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 06:41:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51904 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729550AbgJNKlY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 06:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602672081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZp8tTwx4SYPTE3mJrCE5h7z5DuBzx7i2FSX3LTFQkk=;
        b=CIUjZzGnSgYsQfVk1lOnZZWMJVxTFqTMI7z9oTek5n/SPj3s31GAh9cRlTF0PgNnIardos
        rT6UDlw3Cggu/pmC63wKlrrTr0YMEcaxk3GvcCUynnC1WFMSitNd+s5Pi6uSBiQQU8V1xJ
        t7HuF67VnPNoo0nOZfKlWIBU08waZms=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-KCezD9qRN8SGUFVzvrg3nQ-1; Wed, 14 Oct 2020 12:41:18 +0200
X-MC-Unique: KCezD9qRN8SGUFVzvrg3nQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D45tGMscuP0lHsPQ6zM94D4eF79JOK5rLcsuBFNuHeetzyp8LLVWWEsgTPJKX7Dr8oufNsn3cSgm8XGFiVXmEFc1ONGRosqsUQtsXCR0if1mA/BkEZJPTgdkoE22BNf7998AzdgNQjDdOlvJf0EEaPxgdZ6dp8bZBV0TaOPrNcTvHzSD8GUObbdQ4V4l1tNNFCz5n0RwN6G4vhCv7Sf891w3ws8/e/HoaMnKhSfyJUpfsrKHoHyd+XlRwRADidR58mf2zAoaz/BfYnRGzLLZdb7ByllEBI5H2e+MFCbASOasDzzE92Zj9bfcuEzPaFBPqs8r/cxjQI8f+hiAZB8BIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Uxy4pZAE5ZeqirkHTxy0387Gn8Uf7Fm4LYbObim3Ig=;
 b=dcSt4HFYNLHk3qXRHHbQzctpFFrLTfTA85Ns4Q540jhZ4WhFeYhtflsxNxrD2YFGxLr7tEZx2QXTnbQ6E5HOUm2OGKT7STxHgkHTbzL9bajA8xpqZt1ksE2c5uxzsoHTqlLFUy54QEAKf4GVfF2rt7I8pnpob7UStNIfiGquW0znOmhAluqmeggT/F6EXecSM42aaQPPlFhDWWJyKbqnFvULYoduUTNKHCz5sJ7CCjCGij3QkojSG+UYjqa+/IOP+v5d6mLquYZPsEYgBTuEmbHVGicdo+EH1/JxuBd6mFfrcVlVWjuyaTFRFl9qZx+ZRBZu3SmBufjrXeI6eAIeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0402MB3600.eurprd04.prod.outlook.com (2603:10a6:803:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 10:41:17 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 10:41:17 +0000
From:   Chester Lin <clin@suse.com>
To:     zohar@linux.ibm.com, ardb@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, samitolvanen@google.com, masahiroy@kernel.org
CC:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-efi@vger.kernel.org, jlee@suse.com, clin@suse.com
Subject: [PATCH v2 0/2] add ima_arch support for ARM64
Date:   Wed, 14 Oct 2020 18:40:30 +0800
Message-ID: <20201014104032.9776-1-clin@suse.com>
X-Mailer: git-send-email 2.26.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [118.166.52.150]
X-ClientProxiedBy: AM0PR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::15) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug.suse.cz (118.166.52.150) by AM0PR01CA0074.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 10:41:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea5f9286-825d-4114-c565-08d8702dae00
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB36000207C0F986E5CBDB302CAD050@VI1PR0402MB3600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C63jioVxARWQzSQKKPoDI+z/OqhFNkyadUue2OtpCD3BRV21xOUmfb9R8R3xL7YRfkEwk0uQZpYxdzXCyaMUOfzWY0CFzHyPCVB7SbZsnWoc2i8jMm/Ojw1CPhrNhyv76zquTAvkhXkWd8XFrpV2LZF7glUirDiMOXwCdfu2pwywmudsMWqWmpa0wHwy3YcMGXCB8jAuDhzg8qjPQR0LdhYBeWNXcKfIcPhtkt8U9OZ2XOnzeLnmoMxzmsg7VChG1TBbsDvqVFM8PlPGUGttxEp94qpw7ehQPeqBOsIgo+KP3onrKaZbS6PAlowXqUa8My3S7T3MBAd/1xQ5pgPhK1ndCaWXhhEheHRB1VivjJkVEU3mvKzhuMZJaA3J6AB3WRrpm5eMfICsbsh9iFyEhNERmN1PehpZ3OYSuriKodtpJVfPlkx3ES7Kn8NHhaFNZJZ4TxGfQENobFzUtGhgNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(83080400001)(26005)(66556008)(5660300002)(2906002)(6666004)(4326008)(66476007)(66946007)(16526019)(186003)(1076003)(83380400001)(316002)(2616005)(956004)(966005)(55236004)(86362001)(6486002)(6506007)(36756003)(107886003)(478600001)(8936002)(6512007)(7416002)(8676002)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V8fyTON3rMtRChZ3r9ir4IWdUhkpZVyMnnyasjySDdyFEg9ju3OwEssAagyBfdv8qDTXrw4igdGO3BylX6F516kkGxnb51zivDO9aHni3+izu50TMEcpTEqUR02gro2CEIFb8RDeSbzjTXdNiIHfpbgR386LuRpW5JCwGPXSDAPRPyZKL231+kJaZV6S2YGnYmFPgF3NQC16MPCSq2aRhnrp0AvGJTxSnJCzef8d1ua+W0OU4c5ZKnnQu7/FQSmY9f31RMhpE2YlzdExwgSAyRCAdUCcPAAU02fpeG+Ssd/7a6nZMo5BhhXy7/slI74+raz171PaIitPNr5sIpWvSenl56rblDc/o/KAfSRpLT5C0rKWeNpCIY19Ip3EZOYaQld4+Anp6d6HtBK2W+iQsla6bBjShuAL+nDkBkDGybydMVnDSBnFCY5Z87RwBkM4YBtW72vN2Op2RCWB7nMDkj8iEMB1iDYwAQxJRaVSR7Rc3hNy0lCOXDsNqwqKD4+D7R/0Q4XoTK2N1A9zbWFAo0WBBApDpChtpuDfVHM7qpTCebEIqHIvS/jSAw528mzjRCnCHJxuLGWf1HElEFGQQr4Vd7elZAsIbZZ9fVKH1MncLrQG3R+Tp6ttkGSWFVcFsTbMLUIibIjaOdEp8TIujg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5f9286-825d-4114-c565-08d8702dae00
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 10:41:17.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQZ2QHrIABSUXDR/8YKOJhqn57AyX6S1DMzeDYZmSjmVWfHc+Nqam/oPxNvRAEzG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3600
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add IMA arch dependent support for ARM64. Some IMA functions can check
arch-specific status before running. For example, the ima_load_data
function or the boot param "ima_appraise=3D" should not be executed when
UEFI secure boot is enabled. We want to fill the gap in order to complete
the IMA support on ARM64.

Changes in v2:
- Separate get_sb_mode() from x86 so all EFI-based architectures can reuse
  the same function.
- Refactor arch/arm64/kernel/ima_arch.c based on Ard's patch[1].

Test platforms:
- QEMU [aarch64-virt] + EDK2/OVMF
- NXP LX2160A-RDB + EDK2

[1] https://www.spinics.net/lists/linux-efi/msg20645.html

Chester Lin (2):
  efi: add secure boot get helper
  arm64/ima: add ima_arch support

 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/Makefile   |  2 ++
 arch/arm64/kernel/ima_arch.c | 46 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/ima_arch.c   | 47 ++----------------------------------
 drivers/firmware/efi/efi.c   | 43 +++++++++++++++++++++++++++++++++
 include/linux/efi.h          |  5 ++++
 6 files changed, 99 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm64/kernel/ima_arch.c

--=20
2.26.1

