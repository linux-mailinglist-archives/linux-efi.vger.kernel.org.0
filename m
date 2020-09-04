Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFEE25D26A
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgIDHaL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:30:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:37695 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729829AbgIDHaI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U329ikPO3HVYNh1OH0VUnhnpXFcIAjmLqB0KgFWrbVM=;
        b=gYItN4lifFjvZY7jKiPxXV+8v+FxRYC2g5YbV8O8dbuoU6o3jKRSeEB8rPDl9bIdnN4idA
        kjat5/qekiUODf6UHcIN9OsfYkv9R8zzM4RAxTdeuXcLLIPRh3UWDnpjqtibB2FfdR6GKa
        Rlxq3+QtT5FhPoWHHx4vm4z/+XIScd0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-rXl1I6ZQP6iD4UgB4mRV7g-1;
 Fri, 04 Sep 2020 09:30:04 +0200
X-MC-Unique: rXl1I6ZQP6iD4UgB4mRV7g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buwks09S+RJRGpidWTLWJfkI9Vhu+yebJmGKQ1VTNnddQsaxkKD9QRBKx77kjILvatvRu7l0XLrLbp1jXoIPB+STuHatCob+ERhV98cDQhgbaao9I7Q1rRSI54DsOtctOOEG6Ap/dOs/q71tGXfoKupbsh9EXrmvXPuDeFOIvK33d19EZBJH/jDWO0brVyWl87qIwtiuQzixfEtrm3tQHaXwKEY8crdw6znsQZIE1H2dPMyP9ENxVHOD2DPnMDj9DJbAYzirty+KEatMCBy2FMetenEc4l5fT+cVD6hBGizwa8yDWmZxppbnYYi+FX8CdaB++airQl4ppZb5BrsSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wT8B5U05PQmYomhfbWDQFbQz27bz9PR6cv3cjhQuNA=;
 b=FT/j3Cbf/CAYTIVF22W5y9B3NgMrh0maUgmGI6Y2x8DNpK4zibmMHETma26VxxIBNORNqZozgr2DpK/6R1yEZFtcIjFiHOvgnfxAqaLpcl1HRWcsPMdWASp/f4599pCZphBDry6VQW60EdJxCrnx12U7ZpWT5adwCUWb+nlOh4gFturso2WbJKp4jzINLS/k+9Q5Y/aEyK56imL+25T521q6MwK6vIzVEWnp6SuGx8Fq7qGLwL2x8tc7Wh+oq+cAtw98HsSL/Dbk1R+cjAA1QMCa6dLykERwMFijvZgeBY7OuaCumMBaJiUX5bN+xdDRT+V72fCjBVnVgMZLtfMzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB5534.eurprd04.prod.outlook.com (2603:10a6:803:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 07:30:03 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:30:03 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 4/6] efi/arm: check secure boot status in efi init
Date:   Fri,  4 Sep 2020 15:29:03 +0800
Message-ID: <20200904072905.25332-5-clin@suse.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904072905.25332-1-clin@suse.com>
References: <20200904072905.25332-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:29:58 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b99f771-6d57-4fec-9e12-08d850a45663
X-MS-TrafficTypeDiagnostic: VI1PR04MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5534384095B183B33496CF77AD2D0@VI1PR04MB5534.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVATG4yCjeJcgAFn/ZoDfLKnGYNxdzBe7n8FSrS4zJilk/mzHd3DPb+DsS3W6N8lF3oI9lHsH2IXiZhptwunjkfUZTkBrml1xmQdUJG58D8Fp9ByKGSUXHd/h2p+QbKM2W64jxuzJFzeiDSmNY21CMlmOY36DHv8Qz3LvsX8nPjMEwqykVj5HoUhG9gNe7YphNWpeB1LtPVs5y7UJGZlKBR9j40dmt87K8Q/WJ9Hw27QURVI8bFXYMvEgYCK2LriskIxiXL+FtByhCskGk8xPls7SiVse5M9WSohgPvbv5mDk7xtdxRxfF+Ugswb2sEojae1aHtPc9yk2/3WMnm8FYJKgIdgLWle8q77U8pjuzu4pQEFSi98VQh6VKldhq8r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(5660300002)(2906002)(4744005)(956004)(316002)(66476007)(66946007)(107886003)(66556008)(6506007)(36756003)(8676002)(16526019)(52116002)(186003)(7416002)(6512007)(1076003)(4326008)(8936002)(26005)(2616005)(478600001)(6666004)(86362001)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SRM5UVWkxeo/MsiH3xiKSqZROhxPe8eIctHNC26ORetHvDb9dXdM9cMi5zWK8R9cu/mMoXCRfW/9fFvJMG+ZI4g6oX4RdNIugv7PsDl+UlAE0b1kr6GiRSjAd+ckrt1i+xQ51zc9ndDtvS/X8KIJdzDvSNsnP45osD9ZgtMa04/KEsvxnNW2DugMlo1FtlmqgUEh9S3UVVq7h9rR1wZDJai6STcHwzWB/Xbp9IaPoM+Gbhe6H0+0UB6Vm9rXJI4j7QMOlLU5LYLX4DmT88wtwxDIilgQrmwJiR2c5TjTillprAnM69gAYLiRmLxmAFfjxON8UKMMJp0qUmoLt6i0gPR4u3/GCMv9WORoserqJ3qwj4YvgluP09k1DDjo+sILhfxDked1xKP7LE2XPz5QVrmcpaFJWxiwulHg5RWXtjg7hCnW3yQR5YjnfF1y3uK2L0HXyFkwE20W19OKl68p86Z1kudmZC3EY5xLQbML3vsSP39RVTCZooiHojIBc4TnL6RWYAhT/9jlqkCNFDtOvHcSyC4HT9ZGkOAqGtV1DJeMmy8CM1ABCjjfkh+Tulqf2w6xHuDWxHfKT3oJPBp+4OtpSbXYhugAnAc7BehBmmljN4GO76KHi7QPx13XgY6jzqZmSQm1vtdX6uTCapFFdA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b99f771-6d57-4fec-9e12-08d850a45663
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:30:03.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YInKUozO/YFr/G3ehpfrC3x8zVMRm/Fpx+TrBsDxfRoQHptZUI2oTz6Kqmq4Q4lu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5534
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

set EFI_SECURE_BOOT flag when UEFI secure boot is eanbled on ARM.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/firmware/efi/arm-init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-ini=
t.c
index 71c445d20258..70f2eaf5fb1a 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -234,6 +234,9 @@ void __init efi_init(void)
 		return;
 	}
=20
+	if (efi_secureboot_enabled_in_fdt())
+		set_bit(EFI_SECURE_BOOT, &efi.flags);
+
 	reserve_regions();
 	efi_esrt_init();
=20
--=20
2.26.1

