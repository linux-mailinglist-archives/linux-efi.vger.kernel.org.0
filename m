Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68C259F47
	for <lists+linux-efi@lfdr.de>; Tue,  1 Sep 2020 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgIATgg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Sep 2020 15:36:36 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:42637
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbgIATge (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Sep 2020 15:36:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGrf+u/qWUFnZSed13F3TgYDajRi5qgE3P254CBF3TBHu9JfIHLn82nAIHcIxB91hZLiZEY07Gu/zuMbCedDeM+F7SeK/db8wTQCzfnQmZzIGDijSgSZB0rWgdpXPJRG1d2Q4k5JlA7oizhJ6AXhc/jRFbsM4VrSnco3ezMrjMfYQ3nf72pJ+Tk3xqYmO8i+JpNUO6ILI2LUzC8Pd3zpAjw6Bu3TKcu6YBFkKp6uPzDV7CW5XkOC1ZwF5XtVLE5PnRzozftSkdiOTaQzh/1dw9YDaW4ef/HKcU5hIZPUTau7H8afKY3NeYzaKA0szvw3TWu2vozPC68i1eCtMOe1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNd19dy8/IdiwIdZO+CH46S4dujPVG65h56Y/eFMdak=;
 b=IBw28q9h8xHPNcLJdIwetEVrQ12fSMss7h98P+cJSnQqx0BS49Aej/meVP/tQ1YObvoTSBBgRGtDkjLnepaoFMF9sPrGpLWO4EO6XGz8JBeD0ZqtcOQfedJKF2GZ0eLLGoiBKDtTqtU95+Sz9ZbJoLZwqx7bN89fLl3D1NNAiBXlmqeynMtxTHO++EsYyh+HsCUpkS0A3+2frnkrCwAv1+mfj/sN1e1rDJ8BRrQv8ld8YraNv85cTWuojB114DSNU8RK1/VFThcG4OBOiKmiIfWYtSskRlG69cuzujgUsodNk1F6FlW+M80X/1FCo0di7Kc3Swg7o+Ro59SV8al28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNd19dy8/IdiwIdZO+CH46S4dujPVG65h56Y/eFMdak=;
 b=WSN1LTNmTZvQ+58gxgWpb8+4LFoEozzcMp5SlUBhBWWhig/lzG4CTdVuxwMKcRaVLxUNvMiO/lkp5+fa8XyEGwwzoB1ggijK+AB5gsRggHGTWezc1HpPYzwV6QwCXWLJApniCjRhavD4FCXd/x0bAE1XOZVroVaJ3EVnNKbxYVk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) by
 DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Tue, 1 Sep 2020 19:36:31 +0000
Received: from DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::d950:4d1b:55d0:9720]) by DM6PR12MB3116.namprd12.prod.outlook.com
 ([fe80::d950:4d1b:55d0:9720%5]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 19:36:31 +0000
Date:   Tue, 1 Sep 2020 14:36:24 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200901193624.GA3558296@yaz-nikka.amd.com>
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: DM5PR07CA0123.namprd07.prod.outlook.com
 (2603:10b6:3:13e::13) To DM6PR12MB3116.namprd12.prod.outlook.com
 (2603:10b6:5:38::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM5PR07CA0123.namprd07.prod.outlook.com (2603:10b6:3:13e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 19:36:30 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ec7343e-2549-4500-9ac0-08d84eae5427
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1242C8FB875BE4D60FE0DF23F82E0@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZquAWb5osKduiKJss+Ov7P/nUFj4CUYkASj7JfFLMZRZWDHcjSoLoz5aU7SuzC35PY2hwN8efb95lEDTHj4YlkkrZGudjfdTI56wsCv5b1lNZ/qjFR7d/t2asf2gtyPqoEhzwEc6x0v2UXUdtcU25ncqWMVbVGDAZnrMcSgMaDcWCcZXii/Fxgg1gbu35jRGENXoikZFesfINHJYc6MAwXapSWeT0eTw5u/7igD2Cn4agD/luNlH//gcy4RNwC2yWodllf4toggNIJHPbwMbZpoAufdRs9f5EzFfrKRjDzm4MVEionQeGt5LPTtApyxHwTuNhvzRm3BdXkrAejx+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(83380400001)(7416002)(6666004)(186003)(4326008)(8936002)(8676002)(33656002)(1076003)(2906002)(478600001)(6862004)(52116002)(16576012)(44832011)(5660300002)(26005)(956004)(6636002)(66476007)(6486002)(54906003)(66556008)(66946007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cucAVbATLQnv4CaEE4iT1ttOQZSYwWJjlfB7BOwakQVrDkjGNC2sk2mpIPUya4qvTxiF3lAwXcJ+ZrbW1j66WR1lr8SNW+PfgDRf61eenkuFL9YXgpOYRnQ/xNfOmK3rTTAI0qIK5y4TyRFxTsxV4tB2YlhyLqD2OruJoEf7n+5yY9kB8hGMR4LLNnmznSeEGH/HCHE7bn4oLOirbilNG07mvD8gqb3J1knhs4X5naH//LNi99q94RxAgVKjVbuKA8hiqlVpAxCVSii5Y57su1HV+GeQ49WspEb31KQGEDbfad8OZMC7MJHPjX5bZS6LPdMXidk315x221jxP5LNSYctt+6soJ9CHDfbcA73uTbSJVwYL9Oubc9dg+7yvp8saQWEZuwwH1SYIwgr4+kv+dk9jibLoaU4BqSToMFSGByyV39Hf5sV44rvii4JShTt/aDRNEHcn9VnirM9PGIT0KFs5JhtAjiTaPT0TO4Bf/mAw23z8jTJmwNh0e3Z+ng84ZrL47toSB/UPxD7/sZHTKiV/O/LGTmDphgGTqjuHTTLyhl3Xvkh79Sl973ReGrnxj/zAEWrGostwkVv+xXt5ku8N5Ar0+qprXSvelmN7e7jmKYYw0hhuQcfrd4gioiULjvlyeovYKR5yb0JITfVbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7343e-2549-4500-9ac0-08d84eae5427
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 19:36:31.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01AydhYxT/jyy0H3MZrR/myLBMvPEh21YGq7cXoTa0Wr29S3CDkDKqlGH7ac4j/RVPV14bNV39SyEknO58xb9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 28, 2020 at 03:33:31PM -0500, Smita Koralahalli wrote:
...
> +int apei_mce_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
> +{
> +	const u64 *i_mce = ((const void *) (ctx_info + 1));
> +	unsigned int cpu;
> +	struct mce m;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SMCA))
> +		return -EINVAL;
> +

This function is called on any context type, but it can only decode
"MSR" types that follow the MCAX register layout used on Scalable MCA
systems.

So I think there should be a couple of checks added:
1) Context type is "MSR".
2) Register layout follows what is expected below. There's no explict
way to do this, since the data is implemenation-specific. But at least
there can be a check that the starting MSR address matches the first
expected register: Bank's MCA_STATUS in MCAX space (0xC0002XX1).

For example:

	(ctx_info->msr_addr & 0xC0002001) == 0xC0002001

The raw value in the example should be defined with a name.

> +	mce_setup(&m);
> +
> +	m.extcpu = -1;
> +	m.socketid = -1;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu_data(cpu).initial_apicid == lapic_id) {
> +			m.extcpu = cpu;
> +			m.socketid = cpu_data(m.extcpu).phys_proc_id;
> +			break;
> +		}
> +	}
> +
> +	m.apicid = lapic_id;
> +	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
> +	m.status = *i_mce;
> +	m.addr = *(i_mce + 1);
> +	m.misc = *(i_mce + 2);
> +	/* Skipping MCA_CONFIG */
> +	m.ipid = *(i_mce + 4);
> +	m.synd = *(i_mce + 5);
> +
> +	mce_log(&m);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(apei_mce_report_x86_error);
> +

Thanks,
Yazen
