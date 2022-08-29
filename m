Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978AB5A50D4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiH2P7n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2P7m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 11:59:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5597B19;
        Mon, 29 Aug 2022 08:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edlGcgDrmC3XMZ/CeXOCNOxhGEqj/Gsw0XM5Uu5t4/uMfWJ7cZVCaAfkqrpNV5dON44GEdVDPPmXgBJHzf4H8nfRuHIwkEdjSFcKiTWypcwgX+eLHD70iSWC4nkGo86fewNGz+zwDg9c8+KQ0qj7L4pQ6DA5BryHkc+zizraOudasrW/6TeAflf0j71RfEhKkhwqCWdVRNijLmK6sS6MFuBzuQhDXbRsqDPE3otCV3oaI/wc2DvWkFFTds1z6i3tEDmupuYox55LRDLBnApUDgN6VcEBx6b2hSvFYTH6asXFJwr7uCrTdWLyYg3TEKTXCVfHFiS1+vqPfGSmypprJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM7yaYW/eClJS9YfGzXtfkljYAyNS+SRRPd3pYmVb20=;
 b=Kv3L2dcEjzYAD6SO6+51mMtzLm0fT4xzTdh41slws5TGMgJXFMB5RTZhgVkbXM/H89fiQtySQQ4BJZmJVEdUSMQKugF+fGKWFtqUo7H11DoshcOY29uEKJe3td2EzSdmZKJX0F+m0WdD4hZD4brOuuggSkdsB5AtgYY3yvM9P79zS5jGNW/3ZpC5l7P6Q+i8JTek7tOnUHEddCrxaloQOpMIhiBw/+zJEhnm9XR+/uyfQZpSyTq9WMCTq0pcl4kwwr7x2yBUy+XokPdFQ8pp5DWDuAq54Q4loCUhPY4uQHFMbENqYVGjC3BATw9tw5PhztoOa/YG3SOpUhBwd2ox6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM7yaYW/eClJS9YfGzXtfkljYAyNS+SRRPd3pYmVb20=;
 b=VBlCKMjB5U3iFXtmBbp7VIBgrOfyUYidkJDL6gglKxohM57d/6MUwSSahbD8ObnKr1YZu38WglWcDuj+/sNZst5307WWNFaoipxMOu61BTcFezrY7uNyetWUDokNOoAW+UtdYkZ0O4tcNcc4DUFecSbfx8Roa8NaWjTu1sEtebg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 15:59:39 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8cb2:3d2f:c63e:be2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8cb2:3d2f:c63e:be2%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:59:39 +0000
Date:   Mon, 29 Aug 2022 15:59:28 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Message-ID: <YwziYFGWyEe2/kIp@yaz-fattaah>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com>
 <MW5PR84MB1842F7107770654C46CB0311AB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <YwmqKPaYtgTS4xYT@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwmqKPaYtgTS4xYT@zn.tnic>
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360cc3d5-5c34-4002-a638-08da89d77a2e
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5611:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voq359ETNnMX3I/8MsdqnJJsKhtDKoXCOH5PO+l21UCfTkalgkkG6o3NpsFrHzTWY0Pf58fEjEi+iV29l/sxHx8UOROUCrU+9yGDPSOYq6CFdGry0Y1BPdQPP4UHYHkg48KkQFe7B8bR9w6wLUQRnKLupwKSQtd/d+H1/aUxOKK9zA1CxQxiGGXfls5RWkXAWL7keQhW55iwFuywDTNjoGJljwTFzhCQs0irgD2BxA+rdUgAIWG98Jym+Jo4znQF99XcTavWVz7mV8Fn64rTXMHjeDTCtSa5CtzjSEyYJP40ycz6mnVHhNvR3GBQpEJ9ucvm1vT6N29tEQIUGRQY64HuqxzMBmnCkjku5ccvPUmam5YxKDXtzoXTkSqDyMN1iHjbuZeBa3JtsHZ/At0dWJA7r9dOwtxCKoq/WmNkvwsK3AYdo716B8FLESUlBoep4b08kgAi54bituu6PAoe5SFKY2z6tG89XwleMsTv0CMzSgO4goqLsnoDjhHXEj8JuLjOZm8PDbVtETvWBBySi4xuVqmgGPXVkcVMD8HZiCc+n4dG4l36t4UTr1oanpRY4y0QnOwYfjx9Dm9LwhLsHTMOtKEN0hRF8HZdbduH1E90SbpMuJw2wkKmrbeHw+F5vNYjnk38gautQ/LpnGS4DbiM5mPAT1rsJl7hMLOSJig5GGKfODaDv0NXf3RWi5lwO3o5jfD2v9EhC2gT66W08g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(5660300002)(26005)(6512007)(9686003)(38100700002)(41300700001)(44832011)(7406005)(6666004)(4744005)(7416002)(478600001)(86362001)(8936002)(8676002)(4326008)(66476007)(2906002)(6486002)(6506007)(66946007)(66556008)(316002)(54906003)(186003)(6916009)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4vXOe6VyaXa2GYKkA2uqy9qEPgHUB8sZ8lHlXfO3rmY3H9Vg0n/3aICAUwr?=
 =?us-ascii?Q?rwDuqr8ULAfLQQ396A3tMkFsfdBD//ANxCiBfMP8o6Z3Sdovm6BPjzlqwmUK?=
 =?us-ascii?Q?TCd8angQQfhXyIbnRzXd2HYWQERxCiiNCXZJfMheuey4UtxpPZ5FsdQ1b18L?=
 =?us-ascii?Q?EmOSbGi1XOQiCb6XPDnBd+RHLyuoswf8hEmxKDDPGDxXfz8vw7tOLySXF9pE?=
 =?us-ascii?Q?1lbXT5FP4IM9jVN8qu/aSE4BmWrQytGiqnkY3uRhbMPFkxm9ENVm8UHlZtn8?=
 =?us-ascii?Q?eYZKda+hyuIqzPmJKMsq1z38M+WKJjXWEZ9D5OHikrxrAMKjuB5qvKROrG6t?=
 =?us-ascii?Q?8TTjHIdB2eY2kHYQyj7T9LOGKmyiV4cSTVLQJZaOSR25402dNrP7tGzlTIIL?=
 =?us-ascii?Q?og1lzkLwC2K7ZAeVaBEe5tuGmIbkqu4GtsDQFV+pdI288ChSq2JR664NOGV0?=
 =?us-ascii?Q?+qiJg5zg2TG+stSrEl8+nj6gLhhGgf527iEQEyggWX3QnMwMWJrzWwNxRHD3?=
 =?us-ascii?Q?DYhxyigN+4+zWzm5KhEQxqVs8njFtLT2mqivaVUz7oWfOo/WXkcot2mKgVG/?=
 =?us-ascii?Q?PxKOXzoOh2BAgGOAjFEe+Ld4boKLI937hAgqMIhzEKdGK4gy79A6UEvBZ+tg?=
 =?us-ascii?Q?2BCUH0XIvklM8B91PpKcwKaRB6bOs+SFZYLJkY/uhjYunv1MbhrPVVpSaLXZ?=
 =?us-ascii?Q?QwPT28to+lGbytgnR/dn6mOkjyiVoLyrRwkI8QE52weNYssbSKBPNmEWhRIj?=
 =?us-ascii?Q?jZ5yCkPqGOWoQfZJf/h9Xc1IfAk6Om5bSjAPmMz5AfG7wvbxgSWW4ffCGSe7?=
 =?us-ascii?Q?DEfY6/2w7KBJ7tvtOBS/kdlr0cbjvIQbXkOGku/hwfZ731N37jbKJCHj5672?=
 =?us-ascii?Q?nQ68qJZZrHDJIr/3icDAFZOpWFiweBIZZWfiREGpolsDc0Q9nxD6ezSZnRCr?=
 =?us-ascii?Q?rM+4kmu2a78MJH/zUlDTNjSOt7xeADhOF3fwyLSJlEdUxTvUwJ4wpbhFJfpY?=
 =?us-ascii?Q?Xi1VXfluI66zmQWYcDs0W3tP9kOKjFL95sv0LdU98RmTHRrTWrnmIG4mLgkO?=
 =?us-ascii?Q?WkBKnBmiXdrRfzOe8AuJv/F4nLS6BHSOakk5KZv3gNEzeOVgdBMsT9WYs4zn?=
 =?us-ascii?Q?Y/5vMEDnGNayqDD/UmrYasYwivThD3gAKhgULer2RCw4QHRo1qefAY7hb9t1?=
 =?us-ascii?Q?d9fsFnTYyZDyUXk4haa2g9oBI4cwL3udfIvQSoLUaXoy+Rt9lZw5fxZUMLBZ?=
 =?us-ascii?Q?fBFu8BSqquLP3LFetb9spTz5wXccDQ4EZu5lMer89vx56wXws8tcrf1R9OMs?=
 =?us-ascii?Q?mS6y1emcE14XumXZc0cy9jD56VajdsixG1nhG+5trzCVMRlFe2GIVyROrpD2?=
 =?us-ascii?Q?xlcFJmb/TJB+rSIaxygbRkBN0IwTrc1XMW8QMYYEOdM6vCIaP3EiayFpQTVQ?=
 =?us-ascii?Q?ounGH6oP7sJ/Dd2EZSoGnOYKWGpjmxC6Z3Ct2JK7PIElMHY4+4FYD+Ncp/UQ?=
 =?us-ascii?Q?TCORnCbLYkoKJFn+9OVCokRJi3Xrpc79n1Moc2+PjCjWdh+6n2QW0w7dqFbJ?=
 =?us-ascii?Q?Q/prCrwGYKxZECSp6oLnogy7xMGgOg+ZGI9GucJd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360cc3d5-5c34-4002-a638-08da89d77a2e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:59:38.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+a48sw9zUVAGV/2Q1b4pdZtMWiHu+HIXxcpKcOrhVdwN5lCpu/FvWm6PVe3UWpKOtpI/FvuOa15UKkVuhQQbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 27, 2022 at 07:22:48AM +0200, Borislav Petkov wrote:
> On Fri, Aug 26, 2022 at 10:42:13PM +0000, Elliott, Robert (Servers) wrote:
> > 4. In the help text for each module that looks for GHES and refuses to load 
> > (e.g., EDAC_AMD64), add a sentence:
> > 
> >   This module does not load on a system supporting ACPI GHES.
> 
> It is not "system supporting ACPI GHES." - it is on a system which is
> *known* to have a more or less tested GHES implementation. The notoriety
> of firmware RAS brokenness is well known.
> 
> So please stop this - there's a world outside HP BIOS.
> 
> None of this is needed for this patchset.
>

GHES can be used for more than just memory errors. There are platforms where
memory errors are handled through the OS MCA, and PCIe AER errors are handled
through the FW, for example.

Is the HPE Server platform guaranteed to always provide memory errors through
GHES regardless of CPU vendor/architecture?

Thanks,
Yazen
