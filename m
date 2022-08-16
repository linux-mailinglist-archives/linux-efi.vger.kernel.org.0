Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E5859532D
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 08:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiHPG6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHPG5x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 02:57:53 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63405E992A;
        Mon, 15 Aug 2022 19:20:37 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=h5Q0Mj/CRiIp74GVUJt481AOjRI8TJ3nTLu5n9qyLYBuErZwZOhAuZG/3plR4u1GdLrnl8OGfR0m7x6MIgt02ZMjB06ZA1YinlEYlZdc7poCWz6KQsxMXQygO9jSJy0wqzq9L09GN8T8BER+7nWL22ZKgpwKFlr6A3RLBELfKp/1/lutit6mvKKLMwDhErqpCs2u44+HkOXfd+riYhRb3w5d9Pk27FuUCaaKpVWKxLWBdGZPH6nlS3hT1RfDLpPZByTbkO/M/42kj2KyL9zDccUoyhI3Rvq8bT92u3p1d6Su/LHT8/lj+V7jeKTRQJWLo2w2w0sFEUMAldVy/a4iOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIX+Th33ceTXWHG56MltR68ye18Oh8CFbIrVwB7/58M=;
 b=WomBFSNG47gBimNfGlRLIyE1otnPOkKeyfwnyQcb+2nKe5is/LLwJ7j4Mf9RZfmn4WOe/nPQJULM/Fwaths0a7conFccppeOipIpFtMZFMen+6ZRztHGzi9cMTDBhmX/EqjT7xVhT0qodpIjjg48kHv1CRpntQAsfAUwVwE6v4kr/swwHjwnyiyvUYlGKnNdcuxSlihyS2ZjqvnZyFzGF/Ttp2MJwIAVx4SpVyRbmayYCWvBP3AqH5rSCzK0wwPR0R/BoJmf2Oh7n76hQmKAP7lloZPaUvxoQQuPZJ70DqfIzZgSSrZ0FWhMWSiTSXs0JRcyEd6Nbu+DVT8Gxiccjg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIX+Th33ceTXWHG56MltR68ye18Oh8CFbIrVwB7/58M=;
 b=i9f353VbAyfXdIoucgMN1Bm8dGtXfjX8/IrVMqt+1A4jjXFuODUULwnjoqXTA4/yMNZNJbfxzvWUAyO+jX0PBBSfyLUUaYJtb9MwbpntXruacA5pvyfCDCFfF66vZyQ1imyjjrEXXxKz06oFZNcNyTx0KyQ97Jfwk8C6Ge8woeU=
Received: from AS8PR04CA0172.eurprd04.prod.outlook.com (2603:10a6:20b:331::27)
 by DB8PR08MB5403.eurprd08.prod.outlook.com (2603:10a6:10:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 02:20:33 +0000
Received: from AM7EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::a4) by AS8PR04CA0172.outlook.office365.com
 (2603:10a6:20b:331::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Tue, 16 Aug 2022 02:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT040.mail.protection.outlook.com (100.127.140.128) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Tue, 16 Aug 2022 02:20:33 +0000
Received: ("Tessian outbound 73dd6a25223d:v123"); Tue, 16 Aug 2022 02:20:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e32135e8978d070e
X-CR-MTA-TID: 64aa7808
Received: from 15bd9e51e4d6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E459D119-625C-4E9A-AA87-96B281D91190.1;
        Tue, 16 Aug 2022 02:20:22 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 15bd9e51e4d6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 16 Aug 2022 02:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8nFpu98AJGzwO3YVUgcE1R8XCS184Xv3jJ2nsFHmKr2mjrMcabbVb/PrDzyC0+qI/KH6DTpTM6UbPkSf0qGsjGWy3VvL2aptHWaO2cnAph/2yb/btwREyt+Yhyf9w5ZQHSliG/zY0zAQnYfEa+1YmZsG8015xKVkDGrsYvK37VxOEZxgFCkX+LjE/k2gqGGslr0+2AgGr+2HvKvGYRb+06sllFnhGufmtDlCz+3KQCt3GcnSszIfuqoUsYuhbEhSRFp1BswJfoWUQocfNJ6S+SZ9duMILo+q5Yrnje3FwAskQj+1Zxx3uLzjuhGGSKeHV8li4dY2dCi/yf/A/z11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIX+Th33ceTXWHG56MltR68ye18Oh8CFbIrVwB7/58M=;
 b=UuLwcnqMVPDqtFJiWLkoDUja1XaXNJLoKOFyjsFaQGs9XIjuS7lgoyvo+nEAzNK48xhgbcBB+ALOXvdVR5aB1nA4DbFFpGR3zTQsjOWmi7FREKHqamsTH5BRurZRat4gOkKUFCVHohYdgPf8eokqY9EoCFoAOCx1s80jjXAtf/9NaM8S2beAkDkUTSapYqRU6xrzsQOUh8CTn2b/z3iEOVrgcrPeieQ8qHqXYf7OBvdqZH3nPAwaQ5IDg+rtAWDtw11b3N+j5sipAe2L4IRY68k0nX9sFgjTzfC9oE802dyOTzrCLhJObjT4BPjvB0ErXsjUgzoGdPu5M9GJkGwIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIX+Th33ceTXWHG56MltR68ye18Oh8CFbIrVwB7/58M=;
 b=i9f353VbAyfXdIoucgMN1Bm8dGtXfjX8/IrVMqt+1A4jjXFuODUULwnjoqXTA4/yMNZNJbfxzvWUAyO+jX0PBBSfyLUUaYJtb9MwbpntXruacA5pvyfCDCFfF66vZyQ1imyjjrEXXxKz06oFZNcNyTx0KyQ97Jfwk8C6Ge8woeU=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by VE1PR08MB5839.eurprd08.prod.outlook.com (2603:10a6:800:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 02:20:19 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.025; Tue, 16 Aug 2022
 02:20:19 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Topic: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Index: AQHYrWM9z4laCnaXtkSIa72TszXQIa2rWbmAgAV2I/A=
Date:   Tue, 16 Aug 2022 02:20:19 +0000
Message-ID: <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com> <YvZnrTrXhRn8FV3I@zn.tnic>
In-Reply-To: <YvZnrTrXhRn8FV3I@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 32c8dc0e-f296-45d7-816f-08da7f2de617
x-ms-traffictypediagnostic: VE1PR08MB5839:EE_|AM7EUR03FT040:EE_|DB8PR08MB5403:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MlP7oMTZaE/KwI+OX0nAPAbVK0NdUuReensKXeadsTYp2WxW4T1uJVjJx8IGPFk9Hwikr2t7Z0c5To1NWvHecCBR71S8Nn32dAcPTbCzZJPlI9Kv/t8RBK5pwTDr7DJA/C40io4ES3YE7+hshWkpPeutvlp3B5Rb4DPVQEltTXT7zcdJIFyuwXNAx2FjYXzrwZ/BfdvOa7PIOLeOMAJFQZlFWmMzs/J1U6jQr+oZaI5s8uDiJcjlsK3Yd3u4TyDxs6buwc96QM7fCJT7FSbJQPMeePmvEfrMbJbLEfSH2Q1u8V8/H+JElJXOlkxHXbuWAzimdQc/yWY/uGJCD0/qx88YTZYPihVWgu9PILucc5PneeX+tH7E0qHA065RmA/EhBueflLHwUcn6n87ChNe41dGlQvVRtzqyeWyHcfERwwSSxUh/tkttme6tvsQpyx3zXx3eOs/gH9nmGk/qkDT+2ThU8p0+7txNe0zuuKm97XGsDHruEDjUhrBsFvsI2fQ/V2TdCRzRX1w5SG9PygNsx7gg9FYwqOeUSz0WmzaTRthtZ84WkA5450MzwSfs1b5PaYhSZ+F0THUoeKI7wFG9ZbbIROpd9g1VsiNEGQ+rK03efs9FFKkuQPKn2noPXKYgt5Hx52w7d+qKSjj+bQCr5SQClUBFqGsGwk9SYuzFhS+XaiUlYNIABcPnPycp0uOP0QA+f1de3d7Y3fPWGnV2f9rlhG7Is1bg7Q8na1+9OGpOzwwCPxjBLWQ++vf84vk26qUH34E7SUZrZ/HbRuKskcSSzpPaaSHrOKXj8zQpftN9M6xDapnQ0JK2+mlaLrR
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(53546011)(186003)(33656002)(26005)(38100700002)(122000001)(9686003)(86362001)(6506007)(38070700005)(7416002)(110136005)(83380400001)(71200400001)(478600001)(41300700001)(54906003)(66446008)(5660300002)(316002)(66946007)(2906002)(76116006)(66556008)(8676002)(55016003)(64756008)(8936002)(66476007)(52536014)(7696005)(4326008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5839
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d549cf5b-30ea-4bf5-8847-08da7f2ddd5f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TruevySZATFQTGZuQAem5SqXDBa7Zcg3wAORiM7+BLgr3KBUofIQNVJiye96I1R+4I6MSQZ+eUjobxX5z9MpQak825H4EYXBe+z0fSRom7+vMhvLDMtw5b1YojgCNVjtNq/AgpGLsGInvmVM/UbntO6S53OGFWz/94EVkWYqZLJJvrixnLuneiCGvPWxPggD4I0qqosb7NB6J5SvTQa4DfcjqmuqyGmsS8DsDil70UWvJlANkgXl6yFodp8eN9AQ6G7wkVPY2Hl8+FZF4J4ymxx25Nvv7cnk4xjyJkk4AWr/9ZTAXGbd2Wi9K8S1g9PJFjB/wV8ZoY/5UUjE+vS0aTRWnpGBEGWutPpU4Vv6/74GAuU2vqns63IpNQz8QJpgukMU/kqNzDHWtBcE7AnhiB8CYwcD9OVg3aSKCtEhz/CjjFkpw/2lUOUyIFAXHXJuUwz2WsnbPTtUKMce662dSeV8b3z3WnCzTIDL0PjApSSC94GTnlxvz5NIHgPDO5WJ1tmAIDQygRYNwbD6g0fJYHRKEDGZCP7dXVOcMEzOrNwotfT5mwOOH+GmGtDhMcjfvUFf4YmVzUL5l3XvddMPujPOkIJRyLPnE6SMOy0Byc/fNRPo2tLThjL/++yN8z8xZkYpHQYcxpoqWiCu/C/R3cTOKjShXg5CkqRplkm5ySstJEHqNyToqHTujJf9aLjZrj39MKPjQGUef+IRBjbSKiWToZY6+U++Tatyy3fjtHsAZM9NV7fcZK6LT2v1eSX0clVcNQ2DJkMla3kywzjbi29rojiXyo4mQffQuBb+sWDki6TkK8h7dm4pZeCK+JeU
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(70586007)(4326008)(47076005)(53546011)(26005)(70206006)(316002)(8676002)(83380400001)(186003)(450100002)(9686003)(336012)(33656002)(52536014)(81166007)(2906002)(356005)(82740400003)(5660300002)(86362001)(55016003)(40480700001)(8936002)(478600001)(41300700001)(82310400005)(54906003)(110136005)(6506007)(7696005)(36860700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 02:20:33.5652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c8dc0e-f296-45d7-816f-08da7f2de617
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5403
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXNsYXYgJiBUb3NoaQ0KUGxlYXNlIHNlZSBteSBxdWVzdGlvbnMgYmVsb3c6DQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBh
bGllbjguZGU+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDEyLCAyMDIyIDEwOjQ2IFBNDQo+IFRv
OiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogQXJkIEJpZXNoZXV2ZWwgPGFy
ZGJAa2VybmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgSmFtZXMNCj4gTW9y
c2UgPEphbWVzLk1vcnNlQGFybS5jb20+OyBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+
OyBNYXVybw0KPiBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBS
aWNodGVyIDxycmljQGtlcm5lbC5vcmc+Ow0KPiBSb2JlcnQgTW9vcmUgPHJvYmVydC5tb29yZUBp
bnRlbC5jb20+OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5v
cmc7DQo+IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBTaHVhaSBYdWUN
Cj4gPHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPjsgSmFya2tvIFNha2tpbmVuIDxqYXJra29A
a2VybmVsLm9yZz47DQo+IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7IG5kIDxuZEBhcm0uY29t
PjsgdG9zaGkua2FuaUBocGUuY29tOw0KPiBzdGFibGVAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDIvMl0gRURBQy9naGVzOiBNb2R1bGFyaXplIGdoZXNfZWRhYyBkcml2ZXIgdG8g
cmVtb3ZlDQo+IHRoZSBkZXBlbmRlbmN5IG9uIGdoZXMNCj4gDQo+IE9uIFRodSwgQXVnIDExLCAy
MDIyIGF0IDA5OjE3OjEzQU0gKzAwMDAsIEppYSBIZSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIGluZGV4
DQo+ID4gZDkxYWQzNzhjMDBkLi5lZDY1MTlmM2Q0NWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9hY3BpL2FwZWkvZ2hlcy5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+
ID4gQEAgLTk0LDYgKzk0LDggQEANCj4gPiAgI2RlZmluZSBGSVhfQVBFSV9HSEVTX1NERUlfQ1JJ
VElDQUwJX19lbmRfb2ZfZml4ZWRfYWRkcmVzc2VzDQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gK0FU
T01JQ19OT1RJRklFUl9IRUFEKGdoZXNfcmVwb3J0X2NoYWluKTsNCj4gDQo+IHN0YXRpYy4gWW91
IG5lZWQgZnVuY3Rpb24gd3JhcHBlcnMgd2hpY2ggY2FsbCB0aGUgbm90aWZpZXIgZnJvbSB0aGUg
bW9kdWxlLg0KPiANCj4gQWxzbywgd2h5IGF0b21pYz8geDg2X21jZV9kZWNvZGVyX2NoYWluIGlz
IGEgYmxvY2tpbmcgb25lLg0KPiANCj4gQWxzbywgdGhlIHdob2xlIG5vdGlmaWVyIGFkZGluZyB0
aGluZyBuZWVkcyB0byBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KPiANCj4gPiBAQCAtMTQ5NywzICsx
NTA0LDM3IEBAIHZvaWQgX19pbml0IGFjcGlfZ2hlc19pbml0KHZvaWQpDQo+ID4gIAllbHNlDQo+
ID4gIAkJcHJfaW5mbyhHSEVTX1BGWCAiRmFpbGVkIHRvIGVuYWJsZSBBUEVJIGZpcm13YXJlIGZp
cnN0IG1vZGUuXG4iKTsNCj4gPiB9DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBLbm93biB4ODYg
c3lzdGVtcyB0aGF0IHByZWZlciBHSEVTIGVycm9yIHJlcG9ydGluZzoNCj4gPiArICovDQo+ID4g
K3N0YXRpYyBzdHJ1Y3QgYWNwaV9wbGF0Zm9ybV9saXN0IHBsYXRfbGlzdFtdID0gew0KPiA+ICsJ
eyJIUEUgICAiLCAiU2VydmVyICAiLCAwLCBBQ1BJX1NJR19GQURULCBhbGxfdmVyc2lvbnN9LA0K
PiA+ICsJeyB9IC8qIEVuZCAqLw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IGxpc3RfaGVh
ZCAqZ2hlc19nZXRfZGV2aWNlcyhib29sIGZvcmNlKSB7DQo+ID4gKwlpbnQgaWR4ID0gLTE7DQo+
ID4gKw0KPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4NikpIHsNCj4gPiArCQlpZHggPSBh
Y3BpX21hdGNoX3BsYXRmb3JtX2xpc3QocGxhdF9saXN0KTsNCj4gPiArCQlpZiAoaWR4IDwgMCAm
JiAhZm9yY2UpDQo+ID4gKwkJCXJldHVybiBOVUxMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJl
dHVybiAmZ2hlc19kZXZzOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGdoZXNfZ2V0
X2RldmljZXMpOw0KPiANCj4gQW5kIHllcywgYXMgVG9zaGkgcG9pbnRzIG91dCwgdGhlIG90aGVy
IEVEQUMgZHJpdmVycyAtIHNiX2VkYWMsIHNreF9lZGFjIGFuZA0KPiBhbWQ2NF9lZGFjIC0gc2hv
dWxkIGNhbGwgdGhpcyBmdW5jdGlvbiBpbiB0aGVpciBpbml0IGZ1bmN0aW9ucyBzbyB0aGF0IGl0
IGNhbiBnZXQNCj4gc2VsZWN0ZWQgd2hpY2ggZHJpdmVyIHRvIGxvYWQgb24gSFBFIHNlcnZlciBw
bGF0Zm9ybXMuDQo+IA0KSSBhc3N1bWUgdGhhdCBhbGwgdGhvc2UgZWRhYyBkcml2ZXJzIHdoaWNo
IHVzZWQgb3duZXIgY2hlY2tpbmcgYXJlDQppbXBhY3RlZCwgcmlnaHQ/IFNvIHRoZSBpbXBhY3Rl
ZCBsaXN0IHNob3VsZCBiZToNCmRyaXZlcnMvZWRhYy9wbmQyX2VkYWMuYzoxNTMyOiAgaWYgKG93
bmVyICYmIHN0cm5jbXAob3duZXIsIEVEQUNfTU9EX1NUUiwgc2l6ZW9mKEVEQUNfTU9EX1NUUikp
KQ0KZHJpdmVycy9lZGFjL3NiX2VkYWMuYzozNTEzOiAgICBpZiAob3duZXIgJiYgc3RybmNtcChv
d25lciwgRURBQ19NT0RfU1RSLCBzaXplb2YoRURBQ19NT0RfU1RSKSkpDQpkcml2ZXJzL2VkYWMv
YW1kNjRfZWRhYy5jOjQzMzM6IGlmIChvd25lciAmJiBzdHJuY21wKG93bmVyLCBFREFDX01PRF9T
VFIsIHNpemVvZihFREFDX01PRF9TVFIpKSkNCmRyaXZlcnMvZWRhYy9pMTBubV9iYXNlLmM6NTUy
OiAgaWYgKG93bmVyICYmIHN0cm5jbXAob3duZXIsIEVEQUNfTU9EX1NUUiwgc2l6ZW9mKEVEQUNf
TU9EX1NUUikpKQ0KZHJpdmVycy9lZGFjL3NreF9iYXNlLmM6NjU3OiAgICBpZiAob3duZXIgJiYg
c3RybmNtcChvd25lciwgRURBQ19NT0RfU1RSLCBzaXplb2YoRURBQ19NT0RfU1RSKSkpDQpkcml2
ZXJzL2VkYWMvaWdlbjZfZWRhYy5jOjEyNzU6IGlmIChvd25lciAmJiBzdHJuY21wKG93bmVyLCBF
REFDX01PRF9TVFIsIHNpemVvZihFREFDX01PRF9TVFIpKSkNCg0KRnVydGhlcm1vcmUsIHNob3Vs
ZCBJIHRvdGFsbHkgcmVtb3ZlIHRoZSBvd25lciBjaGVjayBpbiBhYm92ZSBkcml2ZXINClhYX2lu
aXQoKT8gQmVjYXVzZSBhZnRlciB0aGUgbmV3IGhlbHBlciBnaGVzX2dldF9kZXZpY2UoKSBjaGVj
a2luZywgdGhvc2UNCmRyaXZlcnMgY2FuJ3QgYmUgaW5pdGlhbGl6ZWQgYWZ0ZXIgZ2hlc19lZGFj
IGlzIGxvYWRlZC4gSWYgZ2hlc19lZGFjIGlzIE5PVA0KbG9hZGVkLCB0aGUgZWRhY19tY19vd25l
ciBjaGVjayBpbiBlZGFjX21jX2FkZF9tY193aXRoX2dyb3VwcygpIGNhbiBndWFyYW50ZWUNCnRo
YXQgdGhlcmUgaXMgb25seSBvbmUgcmVndWxhciBlZGFjIGRyaXZlci4NCg0KV2hhdCBkbyB5b3Ug
dGhpbmsgb2YgaXQ/DQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg==
