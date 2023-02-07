Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F868CD64
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 04:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBGDVw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Feb 2023 22:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBGDVv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Feb 2023 22:21:51 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C102E273B;
        Mon,  6 Feb 2023 19:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcMyqTrQwBGDUF2ezShwZ5DodgXrseYYu+6TfyG+LKQ=;
 b=P4+u73vdo8+hETnuDpq9nUsgBEOs4CLL32aZafKbPtWesC3wA2fMTISBTMWrQo9dbxFEsX8u44s+weAvYHIiky+fNAG2T9mrq1maB12ecbvRuiJJWpaViWitTZqj/XZXSDlyP65lDhGxY4+UEYIl/IBS8VL0+h7mXBmw6B/T2fM=
Received: from DU2PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:10:3b::24)
 by DU0PR08MB7542.eurprd08.prod.outlook.com (2603:10a6:10:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 03:21:38 +0000
Received: from DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::da) by DU2PR04CA0019.outlook.office365.com
 (2603:10a6:10:3b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 03:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT015.mail.protection.outlook.com (100.127.142.112) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 03:21:38 +0000
Received: ("Tessian outbound 6e565e48ed4a:v132"); Tue, 07 Feb 2023 03:21:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d9e92a62030b9020
X-CR-MTA-TID: 64aa7808
Received: from 93bef5ffdaea.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 58C3C59D-F78B-4052-82ED-7D72947AF10A.1;
        Tue, 07 Feb 2023 03:21:32 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 93bef5ffdaea.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Feb 2023 03:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiGgzgz25thjvi0vHw4sMlF7qdmg65CtPm8nK9QGQh3ul2p19VqwlthDUtDIjujjGTKcDs/EAiWsIajVK2hyyPj9nwjl5RTF+od4QqRcBvuhAkq5K3Gog3nleCNB4XJdCAh1ClBsMEvg85Pt9dtuHqeL8n2qQsRpnm/l/ZtLj86bKCancKW50XS19l6uk7uthGgDIul6EHZuBsjDibkPrjeTKPN5wS/VFFRwpvKcSCnsSdi24cwcf5+qgb2JpqHD9HDnuC61GHaG3F3vUZPA+MzrpkMSOAvWWNHe8phTxRAA1p/d78xppgI+JM5fCKLn1cpRvZYSQ31w+PohPRxwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcMyqTrQwBGDUF2ezShwZ5DodgXrseYYu+6TfyG+LKQ=;
 b=W3DUK1YjjMfqGzG7bdjsHE3/kacSkE+mpnM+7KbCzIFGiyLUC2S62wusimpdtwVJboJfyWYj01vLM/+1F113JA0t4+W0yJEe6LC3lUJTquBNvCoCTe6foPfJA2DQApzM+8Sn7B/c3ihRh82gBGacCuR69KF2MdZ7O4fLlH93prxIpXx3hf6ipcIohqqg+dw5rt9dIS3+EyHvm7JWA95oM+g5rsT5GXvzPqG1vp7yToc7GTh7pjnP4LFJwb5kilVAiYoGIMwcAj5dhRMFU9sgGYCR5H9oYFDr0rj9Kk/fKco51lY6U5c7YA7sMJj+31gLNGfrfYEJNWstOt1EE28QeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcMyqTrQwBGDUF2ezShwZ5DodgXrseYYu+6TfyG+LKQ=;
 b=P4+u73vdo8+hETnuDpq9nUsgBEOs4CLL32aZafKbPtWesC3wA2fMTISBTMWrQo9dbxFEsX8u44s+weAvYHIiky+fNAG2T9mrq1maB12ecbvRuiJJWpaViWitTZqj/XZXSDlyP65lDhGxY4+UEYIl/IBS8VL0+h7mXBmw6B/T2fM=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAXPR08MB7352.eurprd08.prod.outlook.com (2603:10a6:102:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 03:21:29 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 03:21:29 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAADyOAIAAeGJQgAmHX6A=
Date:   Tue, 7 Feb 2023 03:21:29 +0000
Message-ID: <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com>
 <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|PAXPR08MB7352:EE_|DBAEUR03FT015:EE_|DU0PR08MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a2b365-3ec8-490d-d635-08db08ba6ceb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: n78qi0OJfE9wroCayxdv6qaV3RFGJyc3LUtoQ6vfpvNXJ2qkRM7ruL+wcz3aPRMz0FcgboWyvqY9JqFpJoqqaR8n+JmWQKfSzncOM0KgbwJi9Jui5T4kJapSIzucd2l2LoP0GMmldIkeqT3EeR7U6jGtRE1NyQ6vY+an99tai1ow1MQMoogvKPQi8sq1cqWM2nelTUlu7W5Hhcn29xqdcT7GQo7xdnBwXHO+PaofShMLjHbhUknu5T6LsoW5ple/ZJ6auI1OgNaSQBZ074pGI26WnviS2Tm6FMg/oPHfNik0IhoT90PMgjozJUGQ+zQJXYD+CVN6BB6he9cD/Nd+8fBM2CBoCwFEmJHgg4ajdikS7RNkEkcf0O6VHLWcYxhSlRuWQqdcgeMZZ3Lidpb2J+aUcLX0/OVuE4dXKyPhhJgyRuIaP2t/OfnnQALXQBMQbWatdemNFKabKEgswNUgG62cjQ4KAmnyYAnp1/BwEsXw2R1DaUkQPhjx7+W3hlQDF7y2NHJQxq4GKZKRYLP86NspTvfn89wVd0LXchzey/qHkVxibbBDe0O3A+T2SrmmiGDGM8dIh7hOLtlyMtQu2RoGm8K7P4Dod13XXWOcUJCTmTdijdS0T0dLTUEWXsLAwGgT9f/ocKD8ZhFx4ZFXQvKye3jViOIDM36bXNX37V5+SJqQDqpbCFt8RzXnkd3RhM3GoSkx4h0KAftREcmEMA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(4744005)(38070700005)(71200400001)(52536014)(41300700001)(7696005)(86362001)(8936002)(5660300002)(478600001)(122000001)(33656002)(9686003)(54906003)(186003)(26005)(64756008)(38100700002)(316002)(66476007)(6506007)(66556008)(76116006)(66946007)(55016003)(6916009)(4326008)(2906002)(8676002)(83380400001)(66446008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7352
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2bd0105f-7039-4c93-2803-08db08ba672d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRlW8rTotdM8XAK3nUaVq5a2bn1XsV9muQOE15hJvza3Q9jboatbnM3TN2/vvBLEf4WAtwny8LCf5acJJScZ/0QJ/7yYWbNrvLGGinCnlzkG9jjYGcnWFz6mWe3xILgvzewysqCR/QBJP/YxpqJIgL1KGejN6LUQY9LtIAk64y/ScQ1h2fBIl12E9DicW7DdaFhaicVup1q8NFg9hKhlVV70ps3y0gvLjkbsq/jU+Bjp2wIcP0QqdEtKiFgDlmOx47bGnCITmRLIJbWNA2Qgbfjw/VQCjRxCF/0vcqPRR2vuKVn+lP97A/Nj7mhLcVgA+sFD3O6I+buFh0n/Box+HNy2a/9czPyDS0/D1w10r4ZW/VAx7r0Czg9QFvNcO6zpQ/x0ncq/mInV33lVMjiNlrlybeFU0GgbfmJUj71ge3EGEQlmdzpbZDwzr6HbfdaPB//n4sfQB4B+CP974JhBItuVGNL7h7/vRcDj/B98c/rNixKYDBZuDJm9V42dgNHXDImUoEJM7He0EcUCS+2JQdoofkm4xp/GcarticST7rXp6pnfmixTMaczaUkgnJDAM8R1721D/SFaBXG1tlrYPD0FmnJHIv5YVRe7mSNuEctkOtpCcSv3VZB/cRI1agn98Z+Vk1tfXaoRwwBVMgQyTPW8WjNJB+psVR0imOAmMaNVyh4LOpqgj+MkGRJ7/qtPkzfLAPcNZZ553xgQxKoCaQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(356005)(81166007)(86362001)(82740400003)(33656002)(70586007)(40460700003)(450100002)(36860700001)(41300700001)(8936002)(8676002)(6862004)(54906003)(4326008)(52536014)(70206006)(55016003)(47076005)(4744005)(5660300002)(40480700001)(336012)(478600001)(2906002)(7696005)(82310400005)(83380400001)(9686003)(186003)(26005)(6506007)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:21:38.7391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a2b365-3ec8-490d-d635-08db08ba6ceb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7542
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQXJkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NClsuLi5dDQo+IEFzIHlvdXIg
c3VnZ2VzdGVkIChjb21tZW50IGFib3ZlIGV4ZWN1dGVfd2l0aF9pbml0aWFsaXplZF9ybmcgaW4g
bGF0ZXN0DQo+IGtlcm5lbCk6DQo+IFRoZSBlZmlib290bWdyIC10IFggd2lsbCBiZSBodW5nLiBM
b29rcyBsaWtlIG9uZSBjZXJ0YWluIGNvbW1pdCBiZWZvcmUgeW91cg0KPiBwYXRjaCBicm9rZSB0
aGUgc2V0X3ZhcmlhYmxlIGVmaSBjYWxsLiBJIHdpbGwgZGlnIGludG8gdGhlIGZ1cnRoZXIgZGVi
dWcgYW5kIHRlbGwNCj4geW91IHRoZSByZXN1bHQuDQoNClRoZSByb290IGNhdXNlIG9mIHRoZSBo
dW5nIElNTyBtaWdodCBiZSBzaW1pbGFyIHRvIA0KY29tbWl0IDU1MGIzM2NmZDQ0NTI5Njg2OGE0
NzhlODQxM2ZmYjJlOTYzZWVkMzINCkF1dGhvcjogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVs
Lm9yZz4NCkRhdGU6ICAgVGh1IE5vdiAxMCAxMDozNjoyMCAyMDIyICswMTAwDQoNCiAgICBhcm02
NDogZWZpOiBGb3JjZSB0aGUgdXNlIG9mIFNldFZpcnR1YWxBZGRyZXNzTWFwKCkgb24gQWx0cmEg
bWFjaGluZXMNCg0KRG8geW91IGFncmVlIHdpdGggdGhlIGlkZWEgaWYgSSBhZGQgQW1wZXJlIOKA
nWVNQUfigJ0gbWFjaGluZSBpbnRvIHRoZSBsaXN0IG9mDQpVc2luZyBTZXRWaXJ0dWFsQWRkcmVz
c01hcCgpIGZvcmNpYmx5Pw0KDQpQbGVhc2Ugbm90ZSB0aGF0IGV2ZW4gaW4gcHJldmlvdXMga2Vy
bmVsIHBhdGNoLCB0aGUgZWZpYm9vdG1nciAtdCAxMCB3aWxsIG1ha2UNCmtlcm5lbCBodW5nIGlm
IEkgcGFzc2VkICJlZmk9bm92YW1hcCIgdG8gdGhlIGJvb3QgcGFyYW1ldGVyLg0KDQoNCi0tDQpD
aGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg==
