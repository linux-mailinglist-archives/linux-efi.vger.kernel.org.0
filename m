Return-Path: <linux-efi+bounces-238-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1CF817BCF
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 21:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C2D1C2254B
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0272053;
	Mon, 18 Dec 2023 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/wtw5FK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8871DDFC;
	Mon, 18 Dec 2023 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702931068; x=1734467068;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=78ZwN2BYY8+8GptqPyqFKYboOeCZuUoOPSY+3yxwszI=;
  b=P/wtw5FKkMIlVMsj4TeN3utl+/0EyaX9LfT42PazF9s/Kf794JqePcc6
   fXE2zXz+aESNtZd8gcJJb23Z6GzfWBRD4eWQYATWxM3hF+6CK14/kW1D9
   ah5tbkb55rPv/f8GV7x8eseUClEoOLZnxWExHG7c91fXVCpdJtYzX3GcI
   tHIG3pJSZy1lNVJoTIRpLYuuQmSsa4t5sSCF14PBGLs/QRuIZq8UPu35b
   pBqTTEXVL6DNwxuM31dV5IK5Ua0kWAJH8XIed+3GJoVoQn/jhIHCQbtYb
   8Q9ZoOZ7iRykCM27vvBJhG0DEK5ytvQehH6qKx5uZWzr6M414nTUQfzzn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="9008326"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="9008326"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="866348498"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="866348498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 12:24:27 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 12:24:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 12:24:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 12:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec1gI3wYBDnfB9zCSMLzRlSz7UnnvBzylrZ6SQD4ZpysJOHikKCVPHSuYyp7X1aIBiwNNedT1kjZeFv0irJlSbxYbuFrwNz6SwgG/hkZ6455gp9jjPOTMYwM263v/1iu2HHKrEHeE2WaGx05MvALRUYRUhEfaDpOjjOiZ6BwcefhwGMJFoQbMy4iljW1pPoC0B2lP2V2gNW01L6kgjIAU8iKOCENQGgXYFohksd6Aa1P3kxiY0WiPjL7tfnx+onqLcNeOcNSzpO8E4ZdzwpewLlhlLdO5nvj46VojGscKXyTm9iiKa9wMjnfsLRqtYfYa4/iI3e7hxRaC0ipIxUBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrFOE4At6tae9QsTryAAm+Kiy+P5MxGskx3ye3VoXNc=;
 b=R1HE90Epwp7gz6T3ZPAHLwX3cBLLlKWBhGeFkPRTKtZkdDUMWCft5rXjYqVH6xJ+KkjnkrDKkU/5hKf8a2hKpxv3NpyQxiJrLwfjNp8MiQYCHgywdbSx1iu7Wp5JAtSKyrmcOCvaUwgVlgXn+JA80cBrxDWZjkiDPQPrDmbLZ2CZreXj2g+ESgk7y2EyzPkrPIWxfZfqYxBehy7dysBo8MmktZUGWJO75F6J7L6xuyHYuDmzOGO7HlZmCREH8GusnCTd5ZQqjzJ8blWoMIlG7RsktemzNMTNBID6TnduAtBCRW20HbU8LnIF5hH5Qjqb4LRkCfTiWagU1YlfA1Q3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 20:24:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:24:22 +0000
Date: Mon, 18 Dec 2023 12:24:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] firmware/efi: Process CXL Component Events
Message-ID: <6580aa72ca0d1_269bd294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
 <a32464b2-9810-ca9d-73e5-4ed4cf69fea0@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a32464b2-9810-ca9d-73e5-4ed4cf69fea0@amd.com>
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c224c1-7667-43c7-1840-08dc00075248
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0CZVbchTzZNnT0idsh7pO6usJAAs2y1m3EQy/kZa8CQqaXIChaRXS18muiTxbKq8jQLuhE9d1p7Loca++dnSTk2V6KECJJecib5u87pfrFu5SQ8SVnwZE/ah+bt0AlW/J4TvkPwX5vSqjCApexLtfNGF/o+Y5aeU2TPiTktgwcfsPPV9QTt6as/wy3TjkGQPWyTddcKQPDVmZsS0OFZvisakW07YRMUXO40VaA2AwKd6HTam12ZUnT/HSDuieV/Y9SQ4gIi9PJ/Thf/y6Zdeq8WuGdg9VfttDzuU7UdF5wA2469h0R6ojREMAtlQXMgNe47t5ezTKSCw6UtPRIKs6YL7Qm0ZD3nTMJRYhbwcnoqxGpEy9Xv5nb+61lCXIGI8OWRhbO9bCYeWstpwdHVtxB/Y6M0eL4JCbsLD8NoS2jYYPk+hrVkXKtHPQSqOYz8pxtEDojw3pUvVpIPcBd1kTCS6VwO706KsIzTs0oLAYkr10PwO+H+C4Ljah64vagLMi6ob4xW9bJiDv6gbtn61DQttmaL7nztEIrJB75LUlC7ftwXlIw/Vi+6y8YR0YIG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66946007)(38100700002)(2906002)(86362001)(66556008)(26005)(83380400001)(6506007)(6512007)(82960400001)(53546011)(6666004)(9686003)(5660300002)(316002)(110136005)(6486002)(41300700001)(54906003)(66476007)(8936002)(8676002)(478600001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IruRJYnmRROTUvP8eGJCOmQ4odcXN74DofzxQxEe/A1DDo5wcRXr2zyhYU5?=
 =?us-ascii?Q?zZ+ma2K4ri5aXZcOfD00Cm4WDxsStJUUdpYrsE8kn1zeSZ+TatDh+HplJ92K?=
 =?us-ascii?Q?nBCugFlKlVK1YU+asmFG5YPvaymk5ucxY3mn++gwU+RuqKqcfwQ3AZ8b3gkC?=
 =?us-ascii?Q?A86wRrYPWzEFmN5nYMntKGgYlKLgR6Ryvp3JS2BjoVL9KtSrkpCDqkGhQaQE?=
 =?us-ascii?Q?EXIQeeFilQ9h+MZKKUVIPatsvTKNTZ6eJywrI9ZIkftmohxd0TkDI9wCYswu?=
 =?us-ascii?Q?m9Qj70C+vZpdkaEs8tI66GOCHPBqntBKXJrJdPgcooAJXw/czJWeZe1vyaZm?=
 =?us-ascii?Q?jI+m4VjRj222YgtspfUyVtNj5G9OZgiagOn/IEpswwsZbMJ0dXCY6DHHwYxq?=
 =?us-ascii?Q?yJK0rGPbR/4HcJaaighxpA+S2hH61C1+0v9w90VGWhvvNTYH4A3Ac/EKB9eM?=
 =?us-ascii?Q?QCFT/ryP5M6kCOdPkNF1NOG/T+LrtvuSRI4F644RRbOI46WQXHSLOVe9vjmt?=
 =?us-ascii?Q?buGcNqR2/HHnj2WfmO/SvjfXVAuCXR57d05xqTZ7cYBekvuS3kz3HggmI1+m?=
 =?us-ascii?Q?Lhrl5DVBCxUsocUaQZ17RRotxALPlMTnI2hlUCKv4YbyGloW7gthbaqFr9O0?=
 =?us-ascii?Q?n3ApYAC9OjBnzG8Yd+rcm2rjcklcJ2svXCOF9+4t09Bwk9mxgqGQbWUEBYjR?=
 =?us-ascii?Q?r5/rJyh5FkSia5oHH2yVEe4/Av5BA33Hez+CB3J6CHEhFRgV+XicsB5m4Hz+?=
 =?us-ascii?Q?Bldq5M6kEOJW6uTOQRC1a2qIlAk5U6IG8bGvDO9SVpoJ3HGkQYGBPHQ2dYIX?=
 =?us-ascii?Q?D5fFd1J9WPpvX5WQzMhm53al5hCNw+pZM2hfG0oqHN3yiVG9Ghsafg6KqxEO?=
 =?us-ascii?Q?LWycLWUCaUj7yZfyNf2k4DMYBjwYt8J9+JQNCjVqEIxWeG4c9ylIgZYdRFNN?=
 =?us-ascii?Q?rbq4JAKT8rYtj9p9Inab9+IWnch3HYjbEaJPOe1235whU1aIjBI/wlZbDqY6?=
 =?us-ascii?Q?jcAbu113nUFjd/vn8a2yVySENTmg6krvnQcwStsz4R7K0T3Xsp8K7kjFs/gh?=
 =?us-ascii?Q?Z+PoACfCJpMgTJGI2y/TU6zuHu1nLZURx5DMJMXHQc+g/ycDRfDqIeEInBDL?=
 =?us-ascii?Q?Dzv9WR7UPNHVRivPdvjYgH1Ik1v9mv9EbGRYBcuZDGZHCcq7qW6PNph57M5L?=
 =?us-ascii?Q?CrkKqAoYQ/eQIeL00l4toSTvtoFEb30/HGY1+fRWH0eGQL0nNggigw9KBPMm?=
 =?us-ascii?Q?maUrXbAywsQrFzT+n3pTJcJ1eI8vUu+0vil+wIs+T1lnvL9OcshCSjLoddq1?=
 =?us-ascii?Q?NOPkZxWxaqNgKbV/UHzAAFpC9/mHopOGynypwhDyabIhUsMObn4pc27PjcUb?=
 =?us-ascii?Q?E8fTeF5juVrAWyuEjGhwWzlJAzbUUz3HEitk+wHN1evp0PGj4HhJucmWnmlj?=
 =?us-ascii?Q?9X9BWq0KW491md5pwJsnnST7WePVQTOsLutwmoBB83Fkp60rJoxOl7D58Y73?=
 =?us-ascii?Q?pCCLe8Bq0AA3J/SAUyGnLiwshI80QxHAh9174UjpkDnAuVVTUkQkz+bWe63A?=
 =?us-ascii?Q?9ii1wqArGvS8SBh/CHO8jEMU/DwjRTrR9fhcj/4ANFp0JHpNfCp3u8A0kZ3I?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c224c1-7667-43c7-1840-08dc00075248
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:24:22.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWIpGMOfNVaQMyklMVFvlIZOhGrR9VMl7sKig+6u5B8AY2z5nDrWTmzo6xfBY1RsJa3jQP/3XLgeytS2YFPs3GEcunyraEIyVm1bZKuw5s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 12/15/2023 3:26 PM, Ira Weiny wrote:
> > BIOS can configure memory devices as firmware first.  This will send CXL
> > events to the firmware instead of the OS.  The firmware can then send
> > these events to the OS via UEFI.
> > 
> > UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> > format for CXL Component Events.  The format is mostly the same as the
> > CXL Common Event Record Format.  The difference is the use of a GUID in
> > the Section Type rather than a UUID as part of the event itself.
> > 
> > Add EFI support to detect CXL CPER records and call a registered
> > notifier with the event.  Enforce that only one notifier call can be
> > registered at any time.
> > 
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> [snip]
> 
> > +	struct {
> > +		u32 length;
> > +		u64 validation_bits;
> > +		struct cper_cxl_event_devid {
> > +			u16 vendor_id;
> > +			u16 device_id;
> > +			u8 func_num;
> > +			u8 device_num;
> > +			u8 bus_num;
> > +			u16 segment_num;
> > +			u16 slot_num; /* bits 2:0 reserved */
> > +			u8 reserved;
> > +		} device_id __packed;
> > +		struct cper_cxl_event_sn {
> > +			u32 lower_dw;
> > +			u32 upper_dw;
> > +		} dev_serial_num __packed;
> > +	} hdr __packed;
> > +
> > +	union cxl_event event;
> > +} __packed;
> > +
> 
> For some reason, prefixing the struct name with __packed attribute seems 
> to do the job. ("__packed device_id" and "__packed dev_serial_num").

Good catch, yeah, the expectation is that follows the closing brace not
only to match the predominant style in the kernel, but gcc appears to
not honor it otherwise. Looks better with this on top:

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 2b137aead750..975925029f6d 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -130,12 +130,12 @@ struct cxl_cper_event_rec {
                        u16 segment_num;
                        u16 slot_num; /* bits 2:0 reserved */
                        u8 reserved;
-               } device_id __packed;
+               } __packed device_id;
                struct cper_cxl_event_sn {
                        u32 lower_dw;
                        u32 upper_dw;
-               } dev_serial_num __packed;
-       } hdr __packed;
+               } __packed dev_serial_num;
+       } __packed hdr;
 
        union cxl_event event;
 } __packed;


