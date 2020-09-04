Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2325D275
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIDHaE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:30:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:53577 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729820AbgIDHaD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4W5bSW6nA5Xfkb7Y8h/HTLlMqOBYtrf6+XxFBZuEbU=;
        b=XOq2dh2NN59V71NKtSx+KEuy8CN6jemj7O12sz6bNizXixT2zRda0MVE79H1zHBCsIRjrE
        htHeGU7dSZ33bVNyUm1I83zk+jm0C2Dfvj7HI+amRd3Jx0n2ohU4LknlU3XyyKEc7kbgYJ
        wTCQHJXjcB44mKfkLGYF009qqlRFhrw=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-0tbxbXSsMs64XFSzN32a2Q-1; Fri, 04 Sep 2020 09:29:58 +0200
X-MC-Unique: 0tbxbXSsMs64XFSzN32a2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoFym3HQoBsCQiHDJGIiwROXm7+yoEerk0hDiW9TcptZfqFtqXB0GbQ5VrkakfoKeTN61k/iUG9IKXuwNeOkCo4nYLX9Y8QTh7LhRk1d7HU5WXUXSU4dP6bcbGGNrVhD9RG7smdG/0pviNYnBztb9e6XAeDxWV0HJpWmPaZnqlGCHcbqm98fJWhblfXLQSr3vXsI5/nXJ78DzRUepRMTdJAarn7xy66eD8SKLLMNe7QG9bfIHhxOws9xbgPW2fpLaLeQOMzIW3/xO11R3w8LXGMGBoNSuRvg6rLnyMYieWtlqB0OLU9Z5VRTzgL7mUJC4TkFcgd+SUIN5PW+i/rNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntHWF6t6Bu3dc81hgR+PyBCT9MUAWPJ9k0HDA8ELtfY=;
 b=oWQe3AgTrE9Mr57/Db8CH68EU3ZDzXtp7/ibbhPj7MfjymlZ7c1oOeaAHK0YLOgpFjFrzcHNRNYquOd/MVvggUU22G3t5JTBKI4BgT4o3MoTeILgxOvWdqX9i6PQ6t2NbXeDLA3syPi+a5HzgBcEKn6DOoUL1TnQWvuZdiJRTUnOGJqLuSwfHImXOn3cDhySoM9gOrWZNFl4tCUPt016um0GzH5s9esuZrsKPaxMezANg/9F3LVerAS2s1vQg74wEYQS/rxp73TZEEViw81sXX3O+GIHqcG/9I457tSX4OM3mZ3zToUVZ9mpcVMwEK7w0ZAxmCyTFrs1gLNhpganZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0401MB2654.eurprd04.prod.outlook.com (2603:10a6:800:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Fri, 4 Sep
 2020 07:29:56 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:29:56 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 3/6] efi: add secure boot flag
Date:   Fri,  4 Sep 2020 15:29:02 +0800
Message-ID: <20200904072905.25332-4-clin@suse.com>
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
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:29:51 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 562d820f-a813-4922-540f-08d850a45254
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2654B5F0825ABAC4C715A970AD2D0@VI1PR0401MB2654.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZoIkQ+4Sgdj2ZkpU0BPyqoh07GlGwjmM+ky9Ss5NxugukVO0t02+P1svFPbKloWlx8wOZxWdhS4c69zmzI6IRKnYe/+aMDJoI0hB6ZFI5sUCm3lhdYvU1TOAF0lw6Rtxj5/ZV/N0mxgPAQC2as4WVkemB8vbrRHCZHdaXhEGDkP+zSRWJlWQtiWO5T6hFYG0BlcWKZzxtVfxFKsO1/Zl3Ng9OVLzPV2z/UMYOCGMll9xQaEumuqc8Ydw/1BsFkkHPv+AG/znjwZBrbA+OggA1yyREEfK2+oX3eUsTFLZ2RLu4lMRIFMJIbIVSfRfY3gNNVCsgOEwIHxy941R/zx8UHg/m1vpFXZHVrN9VTuwyB9L8u6SjFcbksIH7h8qFkR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(66476007)(478600001)(8676002)(7416002)(52116002)(66556008)(66946007)(2906002)(6512007)(8936002)(4326008)(316002)(186003)(107886003)(6666004)(26005)(5660300002)(16526019)(6506007)(956004)(36756003)(4744005)(1076003)(2616005)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MyIZNVWNi2//3MmZr0lgHSlMojbv08W39emTX30YQQD0waHmOezFQcYN+OotQJrh5z2QCWszDM0moqPrf14pjD0keSLYY7+X1axG7aaq05EctcMzInAAgLYjI5EvMP56beDNVfzfpsjGB2DrlWRbpYcpUx1LItBKbURNZo2MarT5N5BnAVvBKUnvreA+hg5gEJleGvcyM9UwGZJsJ04mFBusnQyFlOg1WvdFrx4avIoxTYw212C1VZSmUYUnejqxy2l+WknUsPGNT7DJ4ck3eng9Hx2POtgwqQ7l5wEugG3umfG11AI0s3W3fJqum1ddKX8PrtSjCQWDb4YuU2zBPbm+2ElIGUE5zEFMGmdEidR9l4lBxBWQLnKZe0AoNKpSnGDfeSW2u6Ebeo3bDZKS8Zlcz8rhrFprFGcLMzkZ2P7mkxGfT46hnU2jOOK70JWv/uh4lIVeZscU/QdW8WqNUCtLxH3SBPwOOqc6xXvuEpIHipesO6q19k/703YBOc3pEJc3II8NfKNYByAiMinbIsdiSGlfMtJDghlKZfFlip4yW20InTz0eNkYX8tTBex7QydLY0B9/qe0K3rb0tR/MJe6UpT13VlkdnGbF6uSikVpPglUIscm/NaHKLFsmD5zlc7LuNkpb+LftNuzWzbsGw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562d820f-a813-4922-540f-08d850a45254
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:29:56.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU+ZCf6JWRki2NktlG8npe54SIFRDF5fCmJf4PQOZUZDi3GLIAe8B4X6niKhiSzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new EFI flag to indicate whether secure boot is enabled by UEFI
firmware or not.

Signed-off-by: Chester Lin <clin@suse.com>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 315126b2f5e9..82a19bb0237a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -784,6 +784,7 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES =
table? */
 #define EFI_MEM_NO_SOFT_RESERVE	11	/* Is the kernel configured to ignore s=
oft reservations? */
 #define EFI_PRESERVE_BS_REGIONS	12	/* Are EFI boot-services memory segment=
s available? */
+#define EFI_SECURE_BOOT		13	/* Is EFI secure-boot enabled? */
=20
 #ifdef CONFIG_EFI
 /*
--=20
2.26.1

