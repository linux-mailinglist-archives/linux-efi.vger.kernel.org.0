Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5B25D25E
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgIDH3n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:29:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:43013 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbgIDH3j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uJUATO4/EY2WXtEWe+OauJXndfAxySdduMFm0v1Smgs=;
        b=Ix/rnQmXlz+f1vOfc7YU1QMb0m4WeVpdlXZVptHUWs8un1PitqHR5jrPWvGMS12mRiVu4/
        JUExbhLqJoK5IhbTSR4tdocy6qsLDfHnZWbROHG3eQhRMdlK2GOHnIz0Z9Uz0ExisFcC9p
        GS6IP64rDLbFm49XoJS3sLFvTbt9INM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-8-FtvegQu_OKOEfd_9Z0LxLw-1; Fri, 04 Sep 2020 09:29:34 +0200
X-MC-Unique: FtvegQu_OKOEfd_9Z0LxLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apk9snTrl3a9lxvvGTu/neKLtI/Ru5OOc/jXuBNszTDJYw1AdVJC2hLAy9MJCZwbtqDVDyR+SAl8js601SNmxvt+qh3jKXnAuz8SrV5hUehWDcP5m0V8jkm9kSulCVE8p8a80mm/8BjARDBScjkQdB9GVtQM6xCDNiyavDUAVjswQGQfQgWKrk74GHhOs4cDSHIkwpb5WpTkhebt1R6JcsA+I1D+zw2mlVBGOqlLiM/qo1Txu994t4mnst1mODOctLCPzydizF7q1lxcQY7YsQW3Q2p12TN28YuAKklTcqcwXbz3sQ5qUf99Icj8C/PgjL1NtlG4bEGnjxc7fkENuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBuO3FBRhw0o8kx/V7f+A2WDoFQK/EwFfxMTB6K6X9s=;
 b=HUxMcpxvMulNVxTa19+xhtlupgacsLbRwU1HWeSCxyjMupiaTSqmLXXny6Of54q4hOt3AnCzcSyb1JwUhJdnwFnMmvsAqHqNZ6evPgFYux/H4tpqD9sQsoUMpn0spRXyN0BBzMFl3oUJY/q1uyO1MFpbf8lUIKX0qeKjZbz8jRCi1mH6/8MyS7NrvqtaUfy+qKqNcPMxdPIQQSxxusKUqeunQrQoYD096z10d9WVVqWDbeeKJM7gvK8awI3Fqov07WxwkRKuO1lMM4gamB1fHmgalJuVgK73LbzW445ibRPeuUEpYokXD4zyAOXpwFVT/11EuSQAb3z1npzfUpaJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0401MB2654.eurprd04.prod.outlook.com (2603:10a6:800:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Fri, 4 Sep
 2020 07:29:32 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:29:32 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 0/6] add ima_arch support for ARM64
Date:   Fri,  4 Sep 2020 15:28:59 +0800
Message-ID: <20200904072905.25332-1-clin@suse.com>
X-Mailer: git-send-email 2.26.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:29:26 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16f33a1c-5c94-4039-2796-08d850a443c4
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB26542181D28E0057A0B4AF56AD2D0@VI1PR0401MB2654.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWCKLiDMr40bvpPiKlgbf27VRGCqIjVlEScsMkxXBHg5vYlVx5G3ZXKswAgav54RSo2v5ePFsv3KJxJSY0yMbvtNH5F5oSp8eBTwbHO/krPHDu+0CaeXxe2SbmfqgODW1z1iVzfsELRYUc3Yww5Mno4Hn/AydFsaV+9AUOlBy9TGbpOaz63iMlG+EPyA6HioQA6DTBMCzWrIvMP3YNh+BesKo0CKoC4xQvmr0xW8AAbb9YV3zKPRwL9zTszzS21hxgP5sluPLfvQddMMiT2ScxV6uhD7oSg95pcPaZj56xI7MLjx+0gEqkhv8wEHmpQQrnquSb/bMrXqdHTBuBtlO4CY3c3QMuZMMtbtictnWRFTTlrOLn6lquUoPojPHDMl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(83380400001)(86362001)(66476007)(478600001)(8676002)(7416002)(52116002)(66556008)(66946007)(2906002)(6512007)(8936002)(4326008)(316002)(186003)(107886003)(6666004)(26005)(5660300002)(16526019)(6506007)(956004)(36756003)(1076003)(2616005)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: u7avlDniBIG2KApO6a/WFIOWI/nJGviADnsNBIGh5kKWt2GADakJq3T80xIUtY+7geeGblirIFprxQ/oiU0qGbrIB3pPt6NVnaOWVsp23TcSHAzK4qT9d3l6n2Qu/Ujp+43INpTahP1oFrkGNeGKzEYjSULo0hn6qTqUtBKkBMX8GGQPkdnIfyTP32jNauBE6wbYQfs8AR6MTNX6NoBVi2d+hIslbRwpQ1NEYbzjWzzGL6zYJW+qxu2HrHS7eHIO7LD4p1qK2t24hEs+SS5fVTHwvQ7FAQL0pWS+wAZhwH7qKJUPD+EPttLGAqTJhFCknmu7XWOcvV7ra5S6f7ZI8IqrJ/31Adm5SpMimi0g1qdkIn1uLvydtvKzkjbFk5yzboQD5ejIqnn52q/L0MYkqeI7x95Oi0MfbmAD7MLatCajgawcRu2nWF/6c8hqQPHeEgea7dyETsFQge7barvOBxcKP5CsbqclHHBPLogPNyUfN9e0QnqcqIQBj0i5tmaAVkrieIYYRqKB5reg3dc3pFydGssTByySblSw4Sjwn2PCcXWpNxASm0UhrctZjObHaGAMXe04CyyESq7pOuvwouv96w1heTDRmDu2rfS8gQDMfggOdutHuJJEzLYCxjHFh7mg/ikPvd6HZ0drRjPOaA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f33a1c-5c94-4039-2796-08d850a443c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:29:31.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46wrDScoGkm0B4xHx/WOu1bR35JpIIYaSE+X9fhKs8iCp1got2JCM9nTFOdjxwKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add IMA arch dependent support for ARM64. Some IMA functions can check
arch-specific status before running. For example, the ima_load_data
function or the boot param "ima_appraise=3D" should not be executed when
UEFI secure boot is enabled. We want to fill the gap in order to complete
the IMA support on ARM64.

Chester Lin (6):
  efistub: pass uefi secureboot flag via fdt params
  efi/arm: a helper to parse secure boot param in fdt params
  efi: add secure boot flag
  efi/arm: check secure boot status in efi init
  arm64/ima: add ima arch support
  docs/arm: add the description of uefi-secure-boot param

 Documentation/arm/uefi.rst         |  2 ++
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/kernel/Makefile         |  2 ++
 arch/arm64/kernel/ima_arch.c       | 37 ++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-init.c    |  3 +++
 drivers/firmware/efi/fdtparams.c   | 23 ++++++++++++++++++
 drivers/firmware/efi/libstub/fdt.c | 39 +++++++++++++++++++++++++++++-
 include/linux/efi.h                |  2 ++
 8 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/ima_arch.c

--=20
2.26.1

