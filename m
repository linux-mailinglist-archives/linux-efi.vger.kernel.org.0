Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583CE25D271
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgIDHaY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 03:30:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:33439 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729852AbgIDHaV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 03:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599204619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72re7vusdOxoLzgqJfmhLeegZrKKyDRUc/vVZJrenpk=;
        b=DmXYvGxeE/CCaYiurzENRQf2U/tyqosQeEPeUYnbff1pKdXbqAEjcI71slDfOncxYPtG42
        4Dvl7Uk73ol1vliZUqi4CiIKpvLcKaAHJCgy86P+ZvOf0EYRuskCdmihwOXYLNeXXOoLSI
        rgfXHEjUHrNb7PsbG+s8z1bMQnflOJ4=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-DePQbbT8OZSg1gwywSDlrw-1; Fri, 04 Sep 2020 09:30:17 +0200
X-MC-Unique: DePQbbT8OZSg1gwywSDlrw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPwNLSVSsjU4dy5cKnOqqGrX2zDx/ljq8aEugYJBvDyh1oT6NMfVTQpQDxW0yN5jNU6GQG4T4RSG5G6i7VctIex8od7Hj18apseAYv00Qpsgd7SEqe60yklwtNiQnwUuLWFdnWPwxowZ7RCRIynRwi7DyuZinq7hw0Seb/hNEsDsq9GOqkbjH4gplLVhCJ+6uK9Beg0BUCVL53sttAckiLafCHmbsLaO0oZQIDqLGCMT9CLqbYWUPzJM/tJT7YqeOaeLhu9J8FCee/55YRQPcpdonXY+9Zpcc6+v6FII9Neyi4xKYly7vWafl0wJPJ/6ozrm69gqFYIR636Ay7KxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFgljBTy0E3a0DrVZoNcEneznYHJAwVHrFHWqhF5L84=;
 b=OyBJR1+Pc/XgJIhZeBIIiCaxLbgXJJIUiYxA3wJUyFWNYphcTV7YevOwpSDPlLKIQtJrfq8CuX9GMiO7WZiuh+kOjevQyNzE3WQ5Z4EwBEdmVXVpfzOyeZSbJCw1B37wjH7GAAnuj8i+66DpNJ7L6l9k+G2WeIopw79m6X20fsUximYKSDuoXezGrACN7/dfWIdAEa3PTkBWttqoKQXz86zXhZVz5gDzYJhYNT0Sx9G7k50sa7vIwP/DmfI9aO4PmYyrE1SydJH2zc91/BYuHQ3pPzThh7VCTwg3X6Hw79y6TVCV/trY/W6wt530F+gNt+EYZaCUVbS8q4Sy9W+kZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB5534.eurprd04.prod.outlook.com (2603:10a6:803:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 07:30:17 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::859b:fe60:4cfd:efa3%2]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:30:16 +0000
From:   Chester Lin <clin@suse.com>
To:     ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, corbet@lwn.net,
        mark.rutland@arm.com, vincenzo.frascino@arm.com,
        samitolvanen@google.com, masahiroy@kernel.org, mingo@kernel.org
CC:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        jlee@suse.com, clin@suse.com
Subject: [PATCH 6/6] docs/arm: add the description of uefi-secure-boot param
Date:   Fri,  4 Sep 2020 15:29:05 +0800
Message-ID: <20200904072905.25332-7-clin@suse.com>
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
Received: from linux-8mug.suse.de (114.24.10.103) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 07:30:10 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [114.24.10.103]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc7f0d9-7c52-4cfc-c729-08d850a45db4
X-MS-TrafficTypeDiagnostic: VI1PR04MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB55346CAFE7FBB7461E64C8BEAD2D0@VI1PR04MB5534.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z113vKSfjvU2amPkkSQtoobHN/YF+dqInhgu+9ZUEbxFgruL3w/2+QAc26Zds05oOec+wuWAj3LLOftbXokEzEsFyogFsN/Jc8HkJ1ZNjaQU3C2VcahgncLt5kft2AzLswOKXz5pgNX4sxOeKTluVeQT48GvU+TlYcJOS342pj8bvIAozkzO7XFYu8vuNXnU3OmFsMid2G5v9Gv+3rkW2b+vpn6ny72vq/qq2XKT5S+yLOoALcKlzplviT4gEzNpJYDVdZOPIRS7k0O/qACzmiaBlSsrsOQoa3aHsJTbnmAhPeneLzdLWZoOT9Sr0UiKSmjVQNm4L/BA3i/GGL0mPgnKp7m06FZzAMqaEN4ajn4Sn7uypKIuo+pWbrhABBKZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(5660300002)(2906002)(4744005)(956004)(316002)(66476007)(66946007)(107886003)(66556008)(6506007)(36756003)(8676002)(16526019)(52116002)(186003)(7416002)(83380400001)(6512007)(1076003)(4326008)(8936002)(26005)(2616005)(478600001)(6666004)(86362001)(6486002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6LlXfIf1QgoHKOROt0bdNQyQKPpGmU+tIvdtCfuWYFNOQquckQLvEA++36oV/hPeW4N4Ksq0RFZf3oQAin5kutSX3UOgjtdwpbbi5R65U9fLHgwJz/OxvjoRiwRavpKZTej32TmQ5pCXQoc7rjJzuBwgvaYCfe8vEDcYCGIMlx/BWLI7mxTGJKEd9U/rABkD/YN3p0shrrImQug61Ee5v7QI5oG+iOYDohoGSwUA5UpcG3tt4sx7eqtSBQG0SeD3wBOTLWaQo9fpUj4NP+cJ5IzWgI0OHS3noOOYK13xznoSVqmBTCOBppZOpUOQf6AlcnFNT2W0O+aVWHfv7MmnOFRe2EP9Q9ist8hKSbu1Q0I2X4iYLVNF7oQfID6/xG+nuD7bzVolESjrrG1zsTsALS/VxlNKDE0t7qwQrt+f//RjhmRWDzyit0KkgVtTxHmh8guHGN/A6aOSJJ5l3Ob5Ck2ghzjnsb1SLLTohRoPtGjOmNO5+pHwQ+o64WuK5StZfJdCsHLBVqLiCyD2DwCQJpCHUAFClCa32pp8N0kJ4nZT7f3JLcGg8ZTgBizU8ogJtAJiVSW8ilOfxlE70DsfPgdm61eDSX0EiOqu0P4aT0JBtrl9p+YngVce4ijBJ2LfJUOdCUJ19AnihX/Osh42xQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc7f0d9-7c52-4cfc-c729-08d850a45db4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 07:30:16.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twwMf6etf08XAPXQvTKat0NLGsyTXUX+ZWTHPmM1xLye0CS/dGf+gj5NwgnRqkCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5534
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the description of "linux,uefi-secure-boot" param.

Signed-off-by: Chester Lin <clin@suse.com>
---
 Documentation/arm/uefi.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index f868330df6be..7d9c6a1697af 100644
--- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -64,4 +64,6 @@ linux,uefi-mmap-desc-size   32-bit   Size in bytes of eac=
h entry in the UEFI
                                      memory map.
=20
 linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format=
.
+
+linux,uefi-secure-boot      32-bit   UEFI Secure Boot [0: Disabled 1: Enab=
led]
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
--=20
2.26.1

