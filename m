Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167627DD293
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjJaQrk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbjJaQrZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 12:47:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB73D4E;
        Tue, 31 Oct 2023 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698770800; x=1730306800;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xUDuHlnykQlBKYl5BpG2uLKufhyx+0N8+1XwVnhzNxI=;
  b=OhOKbMxetRiWyE82msCE6Yb+CT+FnywUlAv53+vkzrR2dsII2Tdlpwun
   7bucCESNWRgPaoTvR0MMufN+KTyYA3vv/MIR+ZfDwqyY0rg9UCh4hxU9a
   ggU89s+W+ryDfkQhKihUcV3jj0HT/oQlTjVuDRsNxxWCGBaJ1MONlCsfO
   zSyBS2G4Aw2K/Q7Irnt4+CUHO7XtBfAZpmeuC53hMEOnjKNGIoP3TFxXP
   Rgun/VIIKeqbpovZM4FI01YxGp8irQtuTnt4jpFxhSXQ+qvcETBx/a5zI
   Tq2J7HLT+/SmA6hPE4zYuCGYcEK8lUZKnjo3jtgMUu9bqAV/y3Juuvg0y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="9858056"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="9858056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754190681"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="754190681"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 09:46:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 09:46:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 09:46:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 09:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmjSwiCgLP1Z6wrOvWzEn0vNftnRwxr7F7ZIywSuKW2+Hwq6vy0plC7TSktuuey8E9kWpgqZ381o81/QqR60eipyrja7zcglt7opfET1KcIgDWgUbaIaeiPdCvEoHjk4FsTBsOYDHLVfByrd9x4JEmlDT8oxLgY6TzlA5uPsmQ8zer78+6g6U4KHTJQZkM4iIHxzgunfrSButAvvlrsp+u8GGgNbtBgFuD30fT3qaHb0Z4/k6+nao4wxThdK7V2r7P05YECT8jXl8coInqkNXxTTSQ1XK09h9fXbx9ykfBB3m7jBspEsToiaYU3YW6VjVaYg1V2jOilSo/xHYcdT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bVGG1KFbDYpgIwu6OOaznu0Cc5vahiYiLMdbGChAcg=;
 b=WMvToYRE6KXrmyawdis2dn8osM5G7Ztmo5pNhqWDkgWD6H/Ad5FO24mmFN9B+TyywaYhuLTwcPb1/5Ay4JroYgD8DtdC8nKEv2paGfjC8hru39TfwsSVsa+NaZVTA+dmfXMUO/SlS7F1O6rJYJv9QRJTZQiUc6BKugerr/rlyvqC3Q4HpyiAdjdQ7XPcEj2+NCn/WDIlFuJWWydCNQ3nLrvhT0lx6aTIaIJGVBOaD2GMPofEHp7h5wLoi2Y0Uon/VBqWL0CcBOchdknSumT9gOipa5SWKzK+eoN0oxhjVT0fMrjdP2rIptAfPspLbE7ANnJot6+F1ik2vD68ZcvPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 16:46:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 16:46:26 +0000
Date:   Tue, 31 Oct 2023 09:46:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH RFC v2 2/3] firmware/efi: Process CXL Component Events
Message-ID: <65412f5defc6d_2e75b2948@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-2-314d9c36ab02@intel.com>
 <653ad3f9d3711_780ef29495@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <653ad3f9d3711_780ef29495@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: cc601715-86eb-424d-c615-08dbda30ec0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF1LXsj0vBCNiU1/PWjKofdiA6WDJFdS1+t1BaKrpBnL/zFydb6nZjaJ1mEQ+mxMJve+OBvgBdmDv/4EsVe1A7+SLh+qKr0U1g3VOC4g7gy2ToCpo+JEbtkco/hM1y8Yj1a2b1zZY8i7m/Zb+fpDXXxJE+dGbmXM4IdFyynwHAjLVDUjfvQOP4vDScOBIsMc78TU8bHEAe1SulgYwYKv+FYaz01bBcEx51wwYt517CWnuhJGDluRkZQGvQxrbzGAfX4sM5FoM8i77PbWvQwUGUqODLPp1HtKl+mZMwpYsBj4tHyHK3J8Q1fIW06gwEa/16GPv3m3+u6wO3QgQYIunvQPxXRDFSbqds+THgTDkEe6x7XTXRi6NadjOe6LukcOy/SslAaQh+8RN0DpfhPBwYWkQEmW3wBHSrrrM+H4D8HLKYGHA7TD1DKqz0grfBuVChE0WkqCnNigvBPNwm+ke/kcR7LdarJf1308+0QYgTOa65Ew3HK/GXWpgiap8H5iTGqr0I4UV/RN5ndN/1pTlBfM+gXK5FavuBm/lxXhKr8/OBiXZruyQ9LTPkzsMTLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(6506007)(107886003)(86362001)(38100700002)(6666004)(26005)(6512007)(83380400001)(82960400001)(6486002)(2906002)(478600001)(54906003)(66476007)(66556008)(41300700001)(316002)(44832011)(110136005)(66946007)(4326008)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5otri0J1UyU8chWYXOVGPqwUTvhqiqK7TboYe2IQVmnSzjQuSg+d96NDGBHU?=
 =?us-ascii?Q?/4JzJDpuRjkpIjLFFqtNdn6kGuZZvh2jHKQtvQ6YAuifZlITTo/VzhN5D+aW?=
 =?us-ascii?Q?Qyp8tteAvp4aKXI94WJCv4CqgP7vbkRrO7U2y+6k7Hb52eamY2YkdT39ADcN?=
 =?us-ascii?Q?+BwBl6VhetLY4ObSDHwuUvGWWjiaAXsaOymAr81Ak2WHDL1fY2kKpRx0hgLb?=
 =?us-ascii?Q?14VxQoUOJ0CAS2LvVGb2QuAfR4LRoCerHCaUT4kz8/Ze7se5eR8r/iquOm7y?=
 =?us-ascii?Q?zVF5pv6dhHjBnlQb0VT0jjxc5QyN23zYgKQ88YX3uLL6shS3YKlKx8soXVk9?=
 =?us-ascii?Q?VT0W+2e6eLFkHYm9tPr4XDPBR2ON52aAfq4dyXvwKRlm79EV4kxT9DTJnwaP?=
 =?us-ascii?Q?xMOnIu05NOGYRdCEcxjTXVxk/F4x2YXC36n7OFs/JAaO72F6k4pMenjSLhc0?=
 =?us-ascii?Q?5/E59K+srQefmBkfZXLnCKqXpoiOJtnmojSPDyCX+Mj/l4z3q/fdQz0e9d/f?=
 =?us-ascii?Q?RcQCwExk21aW5LozxxViJSjY35YCd4EqVWEcVGCzphUrVE0nlc2j/mnuBs+5?=
 =?us-ascii?Q?fCzOYvi5iOUvQjpxI15Zd8SOeWAQuVc2zIKGm/jyApdKYXsqhZ3O1AEK/SVd?=
 =?us-ascii?Q?hPSvL+Bq8vyJURAXOsZ/rhHs2+3WBYc1ndlJaD4e4m73JJ4YnqFt0qLm0gMW?=
 =?us-ascii?Q?O2efoT3wjiIcIIPjNwxFk6JOJR8gTbRqaRtlQj18+JmmK4iw65VFLpjixH8G?=
 =?us-ascii?Q?px9njBm1np9hYQlMU3JkMa53cG6ZcKszj0Ttzfn/ot5PnDQMEnrgV0j5KUUB?=
 =?us-ascii?Q?Vs4+Aa83gWCRBqTFlYBp5a396jolzPnsdKXxNjuzfKab8A7g+Me1F5wDS0xe?=
 =?us-ascii?Q?fZ2M9Sxn6OKpvZNyIve26xVeo4VCEh93GDDLmD3WizLjBNc6BgaLAeKbO5kq?=
 =?us-ascii?Q?/wLDKV/QoEpi8hSW+w+1yKt4CHyS1UayKRAQD2BV3c2YE18DaghG+OrVKQmT?=
 =?us-ascii?Q?DHLx8Q+S1ho9/4V6JIiBTyFZDpjJ2qI2QibokT8itUVNOucsT38q/KRXFG7Y?=
 =?us-ascii?Q?DNKaJ4Ge65aVxkwB2/W1W2TuSF2ND5saiOVupGbzw/i8/PCechakh6I+NF/U?=
 =?us-ascii?Q?hYVgZREhMG4iZXQtpXK2MTXAzxRBntOYok5AFwQ4TfH4GeG4Z8TcROOw5Wf6?=
 =?us-ascii?Q?8lCtYGmE5Yw8AlFY/9UfF90KzjTYZL4y/4QZUSeMXkviGGm+lkKTzlhB9nhW?=
 =?us-ascii?Q?ORQswzNLbXwED9uh3P3tv56wqsO7QRMv1znLrupWIDRc9E/gLgzL2SkoCClT?=
 =?us-ascii?Q?lkobmWstpNS54qjvtZpvmyeS9FLetqrYSkVxGBzgOo2aNoilA4gbCyEa4xw3?=
 =?us-ascii?Q?9kaotACj2pwzm9lQXJOet7d5sQm27tAV0dSkPQKwdhXukQEJz3Wlx6z3AixG?=
 =?us-ascii?Q?jOa+Xyp09SVSJzHb9JV8QUDrrVMztxr3LMP4Gv5jpN4arnba8DXxKbobpch8?=
 =?us-ascii?Q?rTEEboqvwBN4p3ypI2ZSVXQ44D90sRJvjC7h6KUqxI+fNpuMTOeFQ7Fmm6KI?=
 =?us-ascii?Q?yRwVV9RDObJHe5vyCam6RbWlCRsBIujFpjD7ZpiH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc601715-86eb-424d-c615-08dbda30ec0a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:46:25.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBdvo4HtJLz3AxXLMGBA90NH1zeovTBeL9duOKXx2penLmpGZq1sHdIEX9uFSpCTaUHIhq41GZo/LE+AVenIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> > 
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 35c37f667781..d6415c94d584 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -607,6 +607,22 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> >  			cper_print_prot_err(newpfx, prot_err);
> >  		else
> >  			goto err_section_too_small;
> > +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA) ||
> > +		   guid_equal(sec_type, &CPER_SEC_CXL_DRAM) ||
> > +		   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE)) {
> > +		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
> > +
> > +		printk("%ssection type: CXL Event\n", newpfx);
> 
> I would say that since this is going to be hanlded elsewhere the kernel
> log can stay silent.

Yep, bad cargo cult.

Removed.

[snip]

> > +
> > +int register_cxl_cper_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&cxl_cper_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL(register_cxl_cper_notifier);
> 
> I think this should be EXPORT_SYMBOL_NS_GPL(..., CXL) since I can't
> imagine a third-party driver use case for this.

Good point.  Done.

[snip]

> >  
> > +/*
> > + * Event log size adjusted for CPER
> > + *
> > + * Base table from CXL r3.0 Table 8-42: (30h + 50h)
> > + * For lack of UUID: - 10h
> > + *
> > + * (30h + 50h) - 10h = 70h
> > + */
> > +#define CPER_CXL_COMP_EVENT_LOG_SIZE 0x70
> > +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> > +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> > +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> > +struct cper_cxl_event_rec {
> > +	struct {
> > +		u32 length;
> > +		u64 validation_bits;
> > +		struct {
> > +			u16 vendor_id;
> > +			u16 device_id;
> > +			u8 func_num;
> > +			u8 device_num;
> > +			u8 bus_num;
> > +			u16 segment_num;
> > +			u16 slot_num; /* bits 2:0 reserved */
> > +			u8 reserved;
> > +		} device_id;
> > +		struct {
> > +			u32 lower_dw;
> > +			u32 upper_dw;
> > +		} dev_serial_num;
> > +	} hdr;
> > +
> > +	u8 comp_event_log[CPER_CXL_COMP_EVENT_LOG_SIZE];
> 
> Rather than define CPER_CXL_COMP_EVENT_LOG_SIZE I would prefer that CXL
> and EFI share a common struct definition for these common fields.
> 
> That would also remove the need for BUILD_BUG_ON() since they literally
> can not disagree on the size in that case.

I don't know if we discussed this publicly or internally but I had
versions which lifted the CXL structs to the core.  But your opinion at
that time was it was not needed.

Looking at it again I might get away with the main event record struct
defined here.  But it is kind of odd to be in efi.h IMO.

> 
> > +};
> > +#define CPER_CXL_REC_LEN(rec) (rec->hdr.length - sizeof(rec->hdr))
> > +
> > +enum cxl_cper_event {
> > +	CXL_CPER_EVENT_GEN_MEDIA,
> > +	CXL_CPER_EVENT_DRAM,
> > +	CXL_CPER_EVENT_MEM_MODULE,
> > +};
> 
> It follows from defining that common data structure above that this enum
> would be a generic CXL namespace that drops "_CPER_". I.e. the CPER
> notification handler and the native driver translate the event to this
> common generic sub-structure that gets emitted.

Ok this would be along the lines of promoting the definitions to a common
header.  Again I kept things pretty separate because it seemed that was
the direction you wanted to go.

I don't particularly like the memcpy which Smita flagged either.  But I
think this will require reworking the trace code to take a 'non-uuid'
structure equal to the payload 'comp_event_log' above.

Based on these comments I'll add some header promotion of common record
structures and see how it works out with the modified trace code.

Do you have any opinions on the name of the core header?

Ira
