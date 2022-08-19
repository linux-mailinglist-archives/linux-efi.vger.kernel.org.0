Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9865999DB
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347454AbiHSKfJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347036AbiHSKfH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 06:35:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C055E7258;
        Fri, 19 Aug 2022 03:35:05 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZaXaTSb2TblXNdGtD93PU5BVPETE577EzyAXOAKYl3YPEKSJ0Pkxrs/GOcLzN/JLC/JmS+3OkM811vQq8uf6y/6rBmNyjp+gF3Gg7tg+f4SiWN/lBAPgQiMvSuSW8w3/+swF20E9KP1nKd0h9nTqstviW/YLc12mqPcbg9COU+JMLEyFxCdkW6ySWCTP6VgNqe1XpX8mxoOs1kX79bJjAQEwy8xrXhd7xoDDNcG5DfzsdfKbdMLOWqQWcuyxEf5J+/91ldFELlE/kWY2Gnx9hMaCMehpXLHc0kQT5fi2LidDkOsqADrqxF4XDtKm1enVSLtWZQJ4cxvET68iauLwLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4wTFfVAfz0eXAFO5Tdj/hLD8WWtU9FqlUd0fb8TlBA=;
 b=IYP4O3zOrGcuSMWbrDu3ax+1W6IR6jl098MncKP9Q5zyEY8YLteVqYZdUiwQLF/SdFLZ85GHSPWmx4t26fuHLGoFMpx8NqMX9NtKHD3QOJBkS2Q5ri/SBPzEMjp8+CAew7YuozpQWZphTDSVaeBmjmTcLO0Wd1xEfksDbcqwquY9j1QQYH+ZVz9tDs/mH4fP8+iLHuwPJgYQ70Q6a/6Gbd4nIHfnijNeCpAX2GFQO1FmvIl/yfMZxMezQZO30wSKiJwj+A00XsJGn6ozrdUAbyN0nxN+KVocMoTVxA//oFTnpv5sgp7IbV+1UD2CLRkMTLzKfP3fnGDUS2FiTi70SQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4wTFfVAfz0eXAFO5Tdj/hLD8WWtU9FqlUd0fb8TlBA=;
 b=VRToPnGcNavrSsmTQFWdiy1uJZ903+KanCyCoCKLDy0MDqKdIyn5rHCWFVahp9aA5H6IQ7+1A3RP5AqBA2HZi+PIpeG8EjSv23gAYuAvKKnzeLR0nR6J9cQgrgbv8Y89Jccyak98SWBvNPaxew4qxUjxeSOyktNjkMBcm2FJjHA=
Received: from AS9PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:20b:48b::21)
 by DB7PR08MB3836.eurprd08.prod.outlook.com (2603:10a6:10:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 10:34:57 +0000
Received: from AM7EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::dd) by AS9PR04CA0065.outlook.office365.com
 (2603:10a6:20b:48b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Fri, 19 Aug 2022 10:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT026.mail.protection.outlook.com (100.127.140.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 10:34:57 +0000
Received: ("Tessian outbound 2af316122c7a:v123"); Fri, 19 Aug 2022 10:34:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 70856d71b8dc82aa
X-CR-MTA-TID: 64aa7808
Received: from 4e7c88563a9f.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FDB67EE1-4235-4E6C-9D9B-542D49A2D25B.1;
        Fri, 19 Aug 2022 10:34:47 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4e7c88563a9f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 19 Aug 2022 10:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD4Xu6by7tSY90xK38h2mtoSf1v+CFtLe5lVdEvNp59/0r79IvHiS49nJ/WloSDeHDX84K/7YApQCSpJpGnOaeVdPszsDzZIfcnn5u0PSnl2zOyhlAHpIlsljE1S2TzqHeIqqOajisdAYzyHCo2AxrGFN0+0d+FKcyWKF5tnAi2CTdVlbMSiQPBd3Bhk1e4c7PYS1TlLewdlofbJZBrBkk45X00JWRwAFELnMMfwmz/BF0fPtLpYB+BXK1z+29UlH1CifZlkupgmSCn2AU0rPq6Q9OEhb78RP1s7KhNnBSz0a3eib0RFYhSwIwjCqdYpJFbgPa5PwrkGt8Xbb3UUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4wTFfVAfz0eXAFO5Tdj/hLD8WWtU9FqlUd0fb8TlBA=;
 b=khaIH7TeEaI3YZkixPDCXEVRhj2WxOuLL+6uIPWcy9ZRm/QOMhW+lVMz3OY79p/5KHLBrDFLQedC3l8cDLrz3qz3HFhIpV3T5M9QhXjQkYG69wPm6/pgsD3AHwYeMO76DaAP8gFr0G2IIaNLZ9XQ/aZLbTH6kGxfrYGfOnQ3tvRnAxygTY/JUg3CH52i19qXdT16OajiSqJnK1WwshjVM6BZnFMK9Kjb/dIiuslTKoII/nAr/6IWO/UWQCHEdXl+iFt4saEjBs3LkUVvXy9B4R7GLO4pmZlm1yihacR+P0mfvF0sPxPTVbr+jA9x0kxXXe4bzlL4v73JYOKQKR2Wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4wTFfVAfz0eXAFO5Tdj/hLD8WWtU9FqlUd0fb8TlBA=;
 b=VRToPnGcNavrSsmTQFWdiy1uJZ903+KanCyCoCKLDy0MDqKdIyn5rHCWFVahp9aA5H6IQ7+1A3RP5AqBA2HZi+PIpeG8EjSv23gAYuAvKKnzeLR0nR6J9cQgrgbv8Y89Jccyak98SWBvNPaxew4qxUjxeSOyktNjkMBcm2FJjHA=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AM6PR08MB4613.eurprd08.prod.outlook.com (2603:10a6:20b:80::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 19 Aug
 2022 10:34:44 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 10:34:43 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Topic: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Index: AQHYskaw+YptHWRYhESB20W2eY/mCK21cbqAgAB3bLA=
Date:   Fri, 19 Aug 2022 10:34:43 +0000
Message-ID: <DBBPR08MB453891E87563F1BBE291248AF76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
 <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 36327672-e20b-42ab-1284-08da81ce7667
x-ms-traffictypediagnostic: AM6PR08MB4613:EE_|AM7EUR03FT026:EE_|DB7PR08MB3836:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZQuopD3uZ6/IpS6sB1VRcmfvPgX1Ojbxgf2gbj8H7l4/UVRk1pZy9f9ApkJUXN70B9hbGdQrWJFx4LlpWC+yCaTsNby+P/KYe5Eqy2QgifyXj02xeboouhy57kdcgmxgGhMpYwaGs0lfy5TBeA7yXftvU4S5HcO4GtwNjIL5x+YSrdYN69Hr4dicBiuwu8/McYQ/xbxi49WmrsShJQtUalyCzobc/lne40s6ARGx5ul6XpyZm7VGnQE9dK4dwL4H3kJYByqbUK/+F41++AcGb5KP1y1YPXriotCkFOs9kKpkH44wq0kvqUth/zzvT8r3zsvUw/bi545zD/Eaa89p6+L0cw6aHdY4ef52C5oQQbQYWtJhMkeaqfOdb8eTsLm/BYSsAdF9oVoEoUWCWrZ93XG3XogB+uFt3Y/AevMro7tBld1QHXxza+W7yuD5kzVWE9RrrxW1X6gj6HK2YAb8OCzdvVx8DFUL41DB0eazDj24O+UlZMUQVI0uCz+85P8fvlvekeszFmsqUBihZZmZCKlWsJVRUs+mxLTDZQleEtRtsdjkitBS+axX2nfaGNVcWx70aQSOSEWJHwsxIrGegkeg+/fYHag9qntSJc8nx9TvgmtiNaI01B0yThKtbaonf1YoVo+JQWa9NoKtaNH6tO/PGfpdxyqDuO8qb1Z6H19/1I/z9IAxMdrHdR4YWZYCRdWLnArd1NPx2TtQFbp5qJKuuVLHQ18DWpd3xH/nm6oAfQSBOo3rH2O4i4qBsmh0NXHGbAVEMe4T3mrf1H2qLw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(8936002)(186003)(26005)(9686003)(52536014)(83380400001)(55016003)(53546011)(7416002)(5660300002)(6506007)(7696005)(33656002)(478600001)(6916009)(41300700001)(71200400001)(38070700005)(86362001)(76116006)(316002)(122000001)(38100700002)(2906002)(296002)(54906003)(4326008)(66556008)(64756008)(66446008)(66476007)(8676002)(66946007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4613
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 99e11c82-c4ee-4d4d-631e-08da81ce6e35
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+I6s/74+ys6WgvU+BrRvtD8u86xp92B30OM1o0Oh+K+GML9QYP1QCFLgTbZvtSDdF/TeNpwlLgpTNpjSpya0vK4bptf8UQd47HgOD61IuCFs5QznpFiOAl7SvAyW6hw/OidTgjTpGHXA4YKVpSCg3fq4/NC7xJdmJHnxcK86XNsG5Ci1ntLItA5VVUUreH3tkJh7mMzSIJVUzFN69AfTIjM3L+4I1okcyBLSsB3blLMoAiOvGVewPoCn4EdS/hFzT7pioSaDhFUSqmdU655+6a6PkYHvjQlsH76BSBC1E5zI60QS6La/AqKH01yENDWAI8eEMWICko21XV4MsI0EFZu4xz02eJa12SZDSo37bmfmii5JHuu0t0lhcx7T1TxB9lwljx9COT8Fyu0FX+b2Y1NngoZ3BxLeGkVbfpJ+ofO4nYIY9hGiTNANvB3VCb2hoLI3XBYXFqFpehbi1xBv825rCJGKx82I3MJvOcpIsXSP/wpWwHRdAUmLkpWlaam4E8tA+EVW5hmEFOy6y/Sg4NOpan82uLIUt8X6EJy/As8S+jcrE0WEGx6pFa2DgJkxBpQJrp8y8U3xdkxRTG2cg4T9XHg6SS5/zscVLI9wSek2LhcSqCvSEnBVIpnC/sJgWtVA5kBGykkNTy3YkJFW3ocdzOWf0OozcCLiSGbaW112vtomjjJvzAL5i/aAmlH2Ywm5gxDIK03jUuq7+nFEhztA9WfIXl14AI6R8gt6piXfy82Hb8cYtw7sBrQgWejyUav0aKQayBhwacVLaEGLA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(186003)(33656002)(40460700003)(6506007)(5660300002)(52536014)(2906002)(8936002)(6862004)(40480700001)(86362001)(82310400005)(55016003)(81166007)(356005)(26005)(7696005)(41300700001)(36860700001)(9686003)(336012)(478600001)(4326008)(83380400001)(47076005)(53546011)(8676002)(82740400003)(316002)(70206006)(54906003)(450100002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 10:34:57.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36327672-e20b-42ab-1284-08da81ce7667
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3836
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Toshi,

> -----Original Message-----
> From: Kani, Toshi <toshi.kani@hpe.com>
> Sent: Friday, August 19, 2022 9:30 AM
> To: Justin He <Justin.He@arm.com>; Ard Biesheuvel <ardb@kernel.org>; Len
> Brown <lenb@kernel.org>; James Morse <James.Morse@arm.com>; Tony Luck
> <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; Robert Richter <rric@kernel.org>; Robert
> Moore <robert.moore@intel.com>; Qiuxu Zhuo <qiuxu.zhuo@intel.com>;
> Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-edac@vger.kernel.org; devel@acpica.org; Rafael J . Wysocki
> <rafael@kernel.org>; Shuai Xue <xueshuai@linux.alibaba.com>; Jarkko
> Sakkinen <jarkko@kernel.org>; linux-efi@vger.kernel.org; nd <nd@arm.com>
> Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
> loading after ghes_edac is registered
>=20
> On Wednesday, August 17, 2022 8:35 AM, Jia He wrote:
> > Previous, there is only one edac can be registering in the EDAC core.
> > After ghes_edac is modularized, the registering of ghes devices may be
> > deferred when ghes_edac is loaded. Prevent the chipset-specific edac
> > drivers from loading after ghes_edac is registered, which allow the
> > edac drivers to get selected in e.g. HPE platform.
> ...
> > @@ -1382,6 +1395,7 @@ static int ghes_probe(struct platform_device
> > *ghes_dev)
> >  	platform_set_drvdata(ghes_dev, ghes);
> >
> >  	ghes->dev =3D &ghes_dev->dev;
> > +	set_ghes_devs_registered(false);
>=20
> This does not look right to me.
>=20
> The condition of using ghes_edac is (ghes-present) && (ghes-preferred),
> where:
>  - ghes-present is latched on ghes_probe()
>  - ghes-preferred is true if the platform-check passes.
>=20
> ghes_get_device() introduced in the previous patch works as the
> ghes-preferred check.
>=20
> We cannot use ghes_edac registration as the ghes-present check in this
> scheme since it is deferred to module_init().

What is the logic for ghes-present check? In this patch, I assumed it is eq=
ual to=20
"ghes_edac devices have been registered". Seems it is not correct.
But should we consider the case as follows:
What if sbridge_init () is invoked before ghes_edac_init()? i.e. Should we =
get
sb_edac driver selected when ghes_edac is not loaded yet (e.g. on HPE)?

>=20
> I'd suggest the following changes:
> - Update ghes_get_device() to check a flag latched on ghes_probe().

Still need your elaborating about the details of the flag. i.e. When is thi=
s flag
latched? When is it unlatched?

> - Remove 'force' argument from ghes_get_device().  ghes_edac_init() is to=
o
> late to set this flag.  Also, other edac drivers should not be able to co=
ntrol this
> flag.  I think this force_load kernel option needs to belong to ghes with=
 this
> scheme.
Agree, I will remove force_load in ghes_get_device(), and put all check/upd=
ate of
force_load in ghes

> - ghes_get_device() exposes 'ghes_devs' to chipset-specific edac drivers,=
 which
> should be internal to ghes.  ghes_get_device() may be renamed to somethin=
g
> like ghes_edac_preferred() which returns true / false.
>=20

Okay, agree

--
Cheers,
Justin (Jia He)


