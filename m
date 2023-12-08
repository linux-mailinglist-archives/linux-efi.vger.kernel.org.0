Return-Path: <linux-efi+bounces-136-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1BE80973B
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 01:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07F71C20CA3
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 00:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8720371;
	Fri,  8 Dec 2023 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtylvYm2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C410DA;
	Thu,  7 Dec 2023 16:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701995495; x=1733531495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bzsUbaj1ch0qHaYJ7LTpYjTaIFp/vhzAB/8r+nEWSfY=;
  b=XtylvYm2Qgx3i+UHMC4HEcyOukhWFf0SeL1e9XF9KuyaNrxLA4FBBrh7
   mVc2218P25w+NB9Qjoj/RFalPwgy/OclqxZCYxVkLiCcqJaCJByGHeAdU
   HG87KvUCwrNFctSTnxKn/FIq8JT2EAH2+JjyOuUXBkdQOVAcpMiXpGkbq
   HtLW3R/0p8ODqZtBHYD/1zpatd2KI+EovPpKvmZ3bmavyEoUHjxScbzV3
   oebFoOmq4bdeb80qhe72z5IKBc7E9UObBeuOFsFBpo/mnGhAfPTupCAf9
   Q9BRRxnnQ4bi8m+Bro+7kgET6/a2uJ932uaw3dx6rRXsKl4ECjFXyNjax
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="379337122"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="379337122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:31:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915759132"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="915759132"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 16:31:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 16:31:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 16:31:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 16:31:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCFRAdRzFUPoGdAi58Stm7kzq41dbxjRQGU5xO+Dg10IRxZBdLc5JtRjokQRcTatrRnrsvb+Sk3JGwUMU9Kyfe91/tB1zgvWBKvB++UGM+rAjS6aqMDBeA+SXocTN9QNrfE1m/XMnoGcZjI2heoZkhDCUdf83yUoXrrAmRC0KTgI7FK4NWO3BDVKKAlsBNQbaDYbFdWguPKsqy860SpHnsUZCpAFtfxv0N+6on+MS2nmaa8iuKj8GPxuQqzAWH3RHpZ0wcknVz52FrRNRkGoFXvIuXIqxokV7tBC8SAYEWOTYWM+KO1TUUZ3chrap9qhPRUz+dAWcJ5epoEV0tK0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsA0oSXjkX35y6MGxussQ/vExsohUC7p4tOEUpPjC+k=;
 b=lHVl2ygv27LI5ULkWnqlkj211UvFznMfVpb5oAl1p0pSKgSrw8zR6UTCyvuV+2Smlm4lhpI6pw4C2Efs46HtlqviQDrA84yNlF8mTn9VjCQvWtOqUf4I0Gj8XJK01YqY8rvZyhxuDmrVxyWwEg4+wyiyF3FG1MJ9vKotVJUx0erVfEeS7XDbp2b9rl9ZqJ4YCUIh7A9ZGNJ9aeJBMQipwUpclhsaMBj1+kVSXLQbfmS+Sq29QxhhO4ag/ZtRBu1pde3Eau/tUBK2ZlkZB7wxtsvRaIe38c4+7sPJxNJ8+faUAjEzPV0z96da/ACnOjE17zbg9wRHMcA3R7OBkK14Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Fri, 8 Dec
 2023 00:31:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 00:31:01 +0000
Date: Thu, 7 Dec 2023 16:30:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH 1/6] cxl/trace: Pass uuid explicitly to event traces
Message-ID: <657263c249c4c_45e0129471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-1-d19f1ac18ab6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v1-1-d19f1ac18ab6@intel.com>
X-ClientProxiedBy: MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ad20c9-8312-4430-020f-08dbf784f444
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6lH2Y6MyMUC4OgFb9WGB7IE5ytMYtEK7zTE7Hm919qIoNlLIdJOkkcJQ3pROSJnFouFTI0ifTXjh59j/U1xuaPJx2ewBwNu46UizogG1axNaizck+72bEef3z4fQZRzpW7fzKhIxWi1ThyE10TjkGVUmvJnuSBOcdeE7dofQq1uHe7bfErpXoQdEg8okGIZXTuNxA7kilQfQJFJWJs+tP2JFUmnQWbj5ZZwfzgr75xoy5Sb56AlR4/u8+CWFGm1sa0M5i6URZgCposulIBUz5UjwUZQfsrsAX8CkFegBRGRH0Qw3li7EDfFdWpVxujgx4e9V2j1lJ0DHPKGCg0txfaSqd0sNUV0niFoItQHJeigojt3hh+IDRfs7AzY/ZiULJnugjfnD4iJrHygfBvNMdG2/krvnR82gNPrjD5F4PDlPUcfxKAEq2gLBUIInSNeEPBN4bcAdQjZ34bfaTti2cx8vHuh3pCe9l33bNdBG0EaqzcE/Cdmz0y6V3Fm0g/lc8lW7FMBUlDpDGAnvAP0vlnOSzWt5rlag7AhYZQLxjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(316002)(110136005)(54906003)(66556008)(478600001)(6486002)(966005)(6666004)(41300700001)(2906002)(5660300002)(86362001)(4326008)(8936002)(38100700002)(107886003)(83380400001)(26005)(6512007)(6506007)(9686003)(8676002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQ6Dlf3b3D//V+8YkH4vmeZHKNjbnqIjDxl9lqaGbKgBe3rmvgqwZrCgBOMk?=
 =?us-ascii?Q?9uwjNv4TcL84E9cVqYLv+5KKu8OjjgS43VtQsFpqV0L5vP7JWXjtkRWOlFQK?=
 =?us-ascii?Q?Y0i58YryhJGGu20BvK8sPox2x0q4fqwhHMSGlOG3Bo6Ma7UlNBHVvkm6Rtxd?=
 =?us-ascii?Q?j/qEDYfJCZdazc6ZJ+wQ1TV4ifkwTauK65kmrYzAi2nGSWDSmJ5ERIEpA5zy?=
 =?us-ascii?Q?brnpk3RD256hwZO3IgadwypVHEbb1NstosdT2xMJJH6c/1wcOXYh2kS2/Qox?=
 =?us-ascii?Q?BeOr9s2psRzxRcUxA0bPkJGevoAs4sAG8ux9U1Rv/C0FQn88TJ3C1tvp6hpz?=
 =?us-ascii?Q?YHHYvsPermCWmGFmHM9aml3Y9wDfbZ3PWzKqziv7kDDF6DSV0CYyKs2xdzpX?=
 =?us-ascii?Q?D4m7/JaOY1HPZZxXdG5r4NvW+BA2Bn5fpBB0b1NpG2PT9VH3DZMrV8NHVcEz?=
 =?us-ascii?Q?SAmPNX1oTOBjTb3wPFtEi9ZSmRHDTSqBLhcm8sqljXQLWQFD7OxGasgb5MwT?=
 =?us-ascii?Q?vrhQ2az4qOWGAnp096/7TCc9gzZN9BGF/OzEm/FoOh/OT15WBjBXGyS7/SiI?=
 =?us-ascii?Q?EWBbsp0T2KMd6Kd5oWualDWlpU1bIsAfIBiKI7ZKtg6qO4kVgGHlRNMDzV/0?=
 =?us-ascii?Q?LiYo9KoULIXO0sjhIqZIBMALiS4LFxw2XWeql27oRqBhbPf3Ny4dlcIVhYcn?=
 =?us-ascii?Q?h26NpFodIb5NXthfn4qOpQyG69xmKptNZlp7Nsr7vmY0GBY2a5BNiDPuGVin?=
 =?us-ascii?Q?K9CX2IukbVowVse6D3TtKNlu02bVNQ0JgcOmQXqGh8ggJvFhwBJdYYOPQLOz?=
 =?us-ascii?Q?/UoRolBHXaUyTVt8gQBvtj70kAZvVF4Wsmth5DMRnEetyFy7PcvapPFVF5R0?=
 =?us-ascii?Q?cqRWX6dux5vhviP5Tx7+B1Y+3vvOkr+m7ezh0QWO678flKldlMONYsns1Bfc?=
 =?us-ascii?Q?9Szk6ZDQOksN6sW0RIzHS281uy9dO9BUtVzK9zbdUJ4+dOjXADF2qzKa5FJA?=
 =?us-ascii?Q?JNWUPKVBcZ3dGvLQXzrA55Zqilu4wxQY/ZA+ui2CeCI9eAltC7MY8wDYOlZR?=
 =?us-ascii?Q?jRWiSIE4Ck6Wpy7q7cGYVGKUMrE4+w/0nrjm5/5CEFMmP6x2R24Htt9qdw0w?=
 =?us-ascii?Q?ETEGlxK4JsZW/CgTwUCu4I+/1eH+pnYH4PYDY1f2e5JKAdvKlZ+uCmmvKu6+?=
 =?us-ascii?Q?63STcaN2Pt+oliwgKX+3b/nzOosjjnF8w1m/ycIUqCChNwYn3mw+POB+3FXB?=
 =?us-ascii?Q?qJUCc99YiQpisUyNJIVTH7MYATK6X1TxucA3m/iZ7FGeCaSDcZkqLkqgECBj?=
 =?us-ascii?Q?U/yizW1fRYePJ0I1VZGUUaLvT8Z1mCcuVfS+tt+cy2bVxAdGb9y7Ng1yi+Zh?=
 =?us-ascii?Q?B6tiF00sjP3gzDrH8xhccrP0dn794hkNFToHPzAaxVpD49BSjPhp92FkroKS?=
 =?us-ascii?Q?MY7mXUwudXmdhs/9UeihzESHsyEz4laKIUZxFP2/BDMshF0LoLnixM2dH7hb?=
 =?us-ascii?Q?wK/0JehMcI/gRq7omRhcCbrNgy4gzyW9AaKt48SzEFCfp7zsQG+YTynCLfsk?=
 =?us-ascii?Q?EIYi86DQdTJRqaIFENCjrSS9OraIvlK0F4xfKc74DD1nXBU9szQt6iOtvjiG?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ad20c9-8312-4430-020f-08dbf784f444
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:31:01.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5k0gamr82En54cu2/khUyMK2pXvjiJOEuV0eqIpplh+ubzVMwElw3WXLj2Aodzmm6KBD9WNIgH6OXcYMmaj7cGmu1ZGwD2s1f28UWzJLrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> CPER CXL events do not have a UUID associated with them.  It is
> desirable to share event structures between the CPER CXL event and the
> CXL event log events.

This parses strange to me, maybe it is trying to capture too many
changes in too few sentences? Something like this instead?

"CXL CPER events are identified by the CPER Section Type GUID. The GUID
correlates with the CXL UUID for the event record. It turns out that a
CXL CPER record is a strict subset of the CXL event record, only the
UUID header field is chopped.

In order to unify handling between native and CPER flavors of CXL
events, prepare the code for the UUID to be passed in rather than
inferred from the record itself.

Later patches update the passed in record to only refer to the common
data between the formats."

> 
> Pass the UUID explicitly to each trace event to be able to remove the
> UUID from the event structures.
> 
> Originally it was desirable to remove the UUID from the well known event
> because the UUID value was redundant.  However, the trace API was
> already in place.[1]
> 
> [1] https://lore.kernel.org/all/36f2d12934d64a278f2c0313cbd01abc@huawei.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/mbox.c  |  8 ++++----
>  drivers/cxl/core/trace.h | 32 ++++++++++++++++----------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 36270dcfb42e..00f429c440df 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -870,19 +870,19 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		struct cxl_event_gen_media *rec =
>  				(struct cxl_event_gen_media *)record;
>  
> -		trace_cxl_general_media(cxlmd, type, rec);
> +		trace_cxl_general_media(cxlmd, type, id, rec);
>  	} else if (uuid_equal(id, &dram_event_uuid)) {
>  		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
>  
> -		trace_cxl_dram(cxlmd, type, rec);
> +		trace_cxl_dram(cxlmd, type, id, rec);
>  	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
>  		struct cxl_event_mem_module *rec =
>  				(struct cxl_event_mem_module *)record;
>  
> -		trace_cxl_memory_module(cxlmd, type, rec);
> +		trace_cxl_memory_module(cxlmd, type, id, rec);
>  	} else {
>  		/* For unknown record types print just the header */
> -		trace_cxl_generic_event(cxlmd, type, record);
> +		trace_cxl_generic_event(cxlmd, type, id, record);
>  	}
>  }
>  
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a0b5819bc70b..2aef185f4cd0 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -189,7 +189,7 @@ TRACE_EVENT(cxl_overflow,
>  	__string(memdev, dev_name(&cxlmd->dev))			\
>  	__string(host, dev_name(cxlmd->dev.parent))		\
>  	__field(int, log)					\
> -	__field_struct(uuid_t, hdr_uuid)			\
> +	__field_struct(uuid_t, uuid)				\

Hmm, is it too late to make this rename? I.e. would a script that is
looking for "hdr_uuid" in one kernel be broken by the rename of the
field to "uuid" in the next?

>  	__field(u64, serial)					\
>  	__field(u32, hdr_flags)					\
>  	__field(u16, hdr_handle)				\
> @@ -198,12 +198,12 @@ TRACE_EVENT(cxl_overflow,
>  	__field(u8, hdr_length)					\
>  	__field(u8, hdr_maint_op_class)
>  
> -#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
> +#define CXL_EVT_TP_fast_assign(cxlmd, l, uuid, hdr)				\
>  	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
>  	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
>  	__entry->log = (l);							\
>  	__entry->serial = (cxlmd)->cxlds->serial;				\
> -	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> +	memcpy(&__entry->uuid, (uuid), sizeof(uuid_t));				\

Per above this would be:

	memcpy(&__entry->hdr_uuid, (uuid), sizeof(uuid_t));				\

>  	__entry->hdr_length = (hdr).length;					\
>  	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
>  	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> @@ -217,7 +217,7 @@ TRACE_EVENT(cxl_overflow,
>  		"maint_op_class=%u : " fmt,					\
>  		__get_str(memdev), __get_str(host), __entry->serial,		\
>  		cxl_event_log_type_str(__entry->log),				\
> -		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +		__entry->hdr_timestamp, &__entry->uuid, __entry->hdr_length,	\

...and this change could be dropped.

Other than that, this looks good to me.

