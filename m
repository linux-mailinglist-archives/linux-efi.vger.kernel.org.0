Return-Path: <linux-efi+bounces-363-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E87827CE9
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097611F2436B
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710E187E;
	Tue,  9 Jan 2024 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHdQt7lI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1303ECA;
	Tue,  9 Jan 2024 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704767539; x=1736303539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3FcUlkcwMHKgHK9hWNfufrufMukM0bgfeG5tL8+ZjjY=;
  b=NHdQt7lI77ov71k3WJubFsRguZcCUHz/yjqJhrRnKG6BhMQx4qqQ89Wn
   6Hdbq4sUlZq4GgTqHnxRmXh39+wwoBVLNzhyOVTGbuPtgFT5JzW60RMCt
   V8Wn+af3qeiGNwb62G/aisxXGDEfVqOYH0eMfGr3Rt6XqygqpanRqkx6M
   5z7vfNvnpUSRf4xf0GLKPTOFdUFsbyfsyt9SnvZSJpgI53t8imcXNKNsv
   rnTSnJiYkxx2Se3HcbChY5antNFQgGSZMPi0uDNer+VjRmgNjofsgzEIr
   dqLYoeuohA50EMmVCMcCTmqDdlmirfAeBCCTVeFE5CJauvOFvvq6njwjP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="401857279"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="401857279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="731317751"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="731317751"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 18:32:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:32:17 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:32:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 18:32:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 18:32:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSnHPx4y+deJMxhaeGvCcOTPWxod0RkWmYojKf9B6NR1U6jzkjsmd3CfH8XTHeCQzgs3DsgXcxBrGalUvix0gkEdi9+/bGpey4C480Z73Y3cHFXKriqOow0CpPHTwZSsXe7/2DekxbUH0xUrcaZhiq5fY8qHKN5PHrba947VcBJi3NXEfqQRQMBhZ1CA7iIt4cToIf2Qy7rcEDz+OylbsNEDauNJoUYsQ8B2gw+FZvMlKLPUZPiyp605EFjYN5rrW4U4EFmCEBUBF0iK6Yfk8jCYAFRrTkQvAnkSnJs+iFJ2FnQwZhgMY0eip9E0KLG8XcGFuWnr4ocPubHPJ9S5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4+xM1g/KgQHowmNhQhPCUJOoOHB5IDBYTo+HTVDCBA=;
 b=jQZe9ue4LkLFajdNQWjM6OtlpW14Y4YiFmNTyLIbvRMh33oeXCZt8WvOA7HDH1DRorXDxvlBro+fmVMZYQguZ3YU/EctMNYQ7vlKy1uw/ggNvuCKJzYSvmUfa3CgmFzOgCs96ZIawvsL/vNPuWuQYcSVbnqchmrUmvcHuUOIuaGsSACZ/v15fg6xLCjgNHTpa3BGuSBCn7M5B9YFk3kBXc+hLLquud9QMjcDb4P0PuI4MA1aO0YMZWPqm0J8FV7c0K4GW981NMp0qXFcDYOSG4Uzmkgp4Rb4oL/4juKh1ZehPiWXlFo12vQ5N0E1H+rVRz+5uQVfumb6yk3wAy9qhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB8216.namprd11.prod.outlook.com (2603:10b6:610:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:32:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:32:14 +0000
Date: Mon, 8 Jan 2024 18:32:09 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <659cb0295ac1_8d749294b@iweiny-mobl.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com>
 <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
 <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 55be26f8-e628-481e-7187-08dc10bb3108
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +282B6PCthU1d/X9m98te95euFS6VaGDYjUCIaS0yiaX/8FLIz1GV0+8i3Sxv+DcM8YqdX99BxcVYVFK+3W6yUFCR5WYYRIl/XPagY5BBMag7svONam9IWvSgN5GLokt8SJ/hvrVYNrWENgPK8Qu8cq06CCHYD2seEou8ylSzWRO0OZTDCqyervWijjIrLcBQga8IJsi+kNPeIaCkUMNB+s+Vqf/Mwbx8W8+vRN5j/H8+ZpkJYwzb8JIHKajgf8oTGfH+b5z+UKKM/QR7vjeKfdaTsDlrD0vke7fm4y+MddeXltMLkCyUoaAtT0BZtnAFSDhEq7y/g3tlyn2l8+3lOkoylQzklXyKV3vBr2Eg27lmCKkRYIN1vMeY1sHWkgUZhnJCw6N0IpNQJF1N/WQsV3xtULtIvMgRMjn4Yo2aDCr4UZvu/VnowU2EkkJ4WY0xHBe2Mpm63JIH2fSjQBmlLHeHUABnyS7ew//GDMX9TFjODhxKlH7Y1msyrjMTz9hXfO3Jn0AjOmizFhIv9KvSFUt3JZssp6HbQAVeeqKsV+yVxyXZ12SnZhC4PKFPGL+E9EIIiNmLrGSNPbNPAEU3Ka0HQJuG8Nm4kf/6mEsjZEHC/iGZgwvgGLCxunvQzHK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(9686003)(53546011)(38100700002)(44832011)(8676002)(8936002)(4326008)(7416002)(5660300002)(2906002)(6486002)(6506007)(6666004)(478600001)(54906003)(110136005)(66476007)(66556008)(316002)(66946007)(41300700001)(82960400001)(86362001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PPq1lw5+fyDMJ2GLZWp8cyY0+kfbrrgQUmtG2R03m7i8sBwloySFNDI7c36W?=
 =?us-ascii?Q?OYabQcxCJawKEqlmu4hoJbwtF+FnYiJpiBw3Mm1meCbe4rkNCG5j1u7ti7JM?=
 =?us-ascii?Q?P2M5lLe2hwToFG4oqlNBYH00I6rThgiTrik+xvm/nqDqF6CjwpYA8V5nAglU?=
 =?us-ascii?Q?HSjtA+wrShKiKZmrycMq0bWm6ACO9IdQnk3n76v9hjgil1/OFjoVhQOoywke?=
 =?us-ascii?Q?6sdLic2OGEfTLQuU95/o+k9a7EZTp3TQ3lYDVFnCaehCoktI6YozoCv7kU91?=
 =?us-ascii?Q?S5Y9l3xJMkCas60xBOaqvRgkJDWlTloOxiSwNtdIu3NiQCnXuxH5WtuC+ZLb?=
 =?us-ascii?Q?b6bcZx7hw8Qc4cB9tKcv1ROR0lP5C8BHjAQ6gJ7Aumd5lspHpZ3uwvV1vV34?=
 =?us-ascii?Q?ThajEc9kQNEATN55JNwToDLzC4gcoEXT2aY9D9vbHClOJz6+gVHUtEidwEqd?=
 =?us-ascii?Q?88xDsRb5tnROJfC2oadFhg9C0fylCTPK3K4tLt41lxU4Y8qHHNE6nYthTeDm?=
 =?us-ascii?Q?5T2nHlh3UPzpiTYUgvchHRy93sQpDCob86EqxgocLVDc+pAhLiWejPsMwmYX?=
 =?us-ascii?Q?hKG0EPONhPIClYf833h+LkMtWhUSFrBkQz5BxnhOyQsK1o6YxrXTQKZpp6Ck?=
 =?us-ascii?Q?+CV8dxYKG9N7EkxlHSBbPNj1sGvIn1tvl7Xzoao+L9BWlVmuHFpYDDyhQkBE?=
 =?us-ascii?Q?7b/rvoyNHUTYvSzqLHzGxf6FhtDJcBkVmBFqxOzv2sQ5v/azm3M+mW6PMVCj?=
 =?us-ascii?Q?jXCakPj6INkEh0/MUQU45jWGOkUyncIICm1zs19aPvp8BNIijPvoFmLhfe/+?=
 =?us-ascii?Q?OuESe4bOWwqGc4dLbEJPBgXClNin9J0ZzUD0C98ppcMZYD4hmOnRKnDPvGJa?=
 =?us-ascii?Q?C/phT6DAbVI/amOqHp83xORgh3/ROApUr/jfPMtMFrfYFPtN8Cxz3WkrSQfo?=
 =?us-ascii?Q?4TDYPfizyEhhfhltNxQyjobBgN7X6ihePstqOTy1E6HWuXdCTk0m9DjPD6h+?=
 =?us-ascii?Q?nEiHkfm+bJWQDuzyiAejYPXPIrDzdHaULOrjdMmPFFnuxNMMmke64bzGpeAb?=
 =?us-ascii?Q?/9ZxNCStisMrPzVDTOxb5mzgHUaKw7xUZzFnVo68NPCw5saTHVmSgAivcpsM?=
 =?us-ascii?Q?yDw8z2JXZ+vcfn6ch0TcFipc4dY9qh2Afj2wbQDutPTKq2QvLCRFPR3EHR1J?=
 =?us-ascii?Q?BQN6nHN9ChDchq1QUXylhuckx8Ae5nBsc9Pm+IC3PxIlu39h6/LoE+nHTL5s?=
 =?us-ascii?Q?8fwx+NPos0whBGKZTt4O6Wg/S2PnXWOncsGFriQLkUvYlkym533YR9Yhfxsg?=
 =?us-ascii?Q?/Sk3QLMqnzLDxOeiJQrwqm4r+oX10TWwAaRXi+UBN6iXtx61EIbl99dCRU8Z?=
 =?us-ascii?Q?Glhz3I65cRBu0Sz+/CCvGO0d598oFmS63imbP2HnFAESxttQPAou/WRfbLKc?=
 =?us-ascii?Q?D1XAd+MRuLYY1+qsBZJj8Uu/MktcGln1Ap7Re3VFJ3nOwCNEDU67tKy8jSy9?=
 =?us-ascii?Q?gzkUkiSpc5O9g4QTgolgFSDfRegxwvD4myLrvykSttPI6+dDlnfyH7aAYvd2?=
 =?us-ascii?Q?ukM9aNpVVCtJqkklWfsirSGmss2pmt1RfIl9m9hbYXO/h3JfLiN4PEpX6Cq2?=
 =?us-ascii?Q?08cF9nnebTauiSRrKglHlm7t/tMu94v13trnim15xqyV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55be26f8-e628-481e-7187-08dc10bb3108
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:32:14.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLBMafwQUWRAg8DvpiUI1efEakISf/KSIZR7IVNu9kwOlHN95fRsJu3JPiM0uQLHnVp0A9KLJYbCOfvIOc16Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8216
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Smita Koralahalli wrote:
> > On 1/8/2024 8:58 AM, Jonathan Cameron wrote:
> > > On Wed, 20 Dec 2023 16:17:27 -0800
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > 
> > >> Series status/background
> > >> ========================
> > >>
> > >> Smita has been a great help with this series.  Thank you again!
> > >>
> > >> Smita's testing found that the GHES code ended up printing the events
> > >> twice.  This version avoids the duplicate print by calling the callback
> > >> from the GHES code instead of the EFI code as suggested by Dan.
> > > 
> > > I'm not sure this is working as intended.
> > > 
> > > There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> > > and now the EFI code handling that pretty printed things is missing we get
> > > the horrible kernel logging for an unknown block instead.
> > > 
> > > So I think we need some minimal code in cper.c to match the guids then not
> > > log them (on basis we are arguing there is no need for new cper records).
> > > Otherwise we are in for some messy kernel logs
> > > 
> > > Something like:
> > > 
> > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > > {1}[Hardware Error]: event severity: recoverable
> > > {1}[Hardware Error]:  Error 0, type: recoverable
> > > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > > {1}[Hardware Error]:   section length: 0x90
> > > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> > > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> > > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> > > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> > > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> > > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> > > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> > > cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> > > 
> > > (I'm filling the record with 0s currently)
> > 
> > Yeah, when I tested this, I thought its okay for the hexdump to be there 
> > in dmesg from EFI as the handling is done in trace events from GHES.
> > 
> > If, we need to handle from EFI, then it would be a good reason to move 
> > the GUIDs out from GHES and place it in a common location for EFI/cper 
> > to share similar to protocol errors.
> 
> Ah, yes, my expectation was more aligned with Jonathan's observation to
> do the processing in GHES code *and* skip the processing in the CPER
> code, something like:
> 

Agreed this was intended I did not realize the above.

> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..0a4eed470750 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -24,6 +24,7 @@
>  #include <linux/bcd.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> +#include <linux/cxl-event.h>
>  #include "cper_cxl.h"
>  
>  /*
> @@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  			cper_print_prot_err(newpfx, prot_err);
>  		else
>  			goto err_section_too_small;
> +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> +		printk("%ssection_type: CXL General Media Error\n", newpfx);

Do we want the printk's here?  I did not realize that a generic event
would be printed.  So intention was nothing would be done on this path.

Ira

