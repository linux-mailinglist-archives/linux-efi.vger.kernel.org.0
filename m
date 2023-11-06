Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455A57E2F68
	for <lists+linux-efi@lfdr.de>; Mon,  6 Nov 2023 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjKFWFx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Nov 2023 17:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWFv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Nov 2023 17:05:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B910A;
        Mon,  6 Nov 2023 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699308349; x=1730844349;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EH9dxnM8vExteJGS8svXYpkbuBOu+VPA6oN9NTkBqvU=;
  b=McM4JN/cV1zv7xYAD5cRx+fRkMGFk+/5qQUqxIBiuO/DR68+o+AOJg7B
   emAo7pIF7FqM3vWPb7KxY+Gr2iX0QcZC5TIglY+5RofNpEp8KcNJBlbAr
   UG33o+Aq4ecRa/uPXXCcpEE9wONYdzceoiRa1ZRJVoxbILhQWspYn7ELm
   QnRsjkk6bGW6WFDtjSNzRpKoSskczx2NdqHTB1CU+xHRoD9cBcFigJkLp
   zar9aF7WgOzuMrvSuGTLh2ZqVU84+ICJi/Hwbtcr9dweT7l/45p19//NI
   75GkLPYSollQA4BOtIJe74twdYt/EJNwzMOPiqIOAcPirtF7SyUHOrADV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393271548"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393271548"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828360667"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="828360667"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 14:05:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:05:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 14:05:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 14:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrmTmF1EPAFnhmpigEamv/FCh55o3VUL+LcGVBJIESB83swBu7DgZdh9aXLR0vGIbm8+HJLnQebujD/IR/DjIhzi0T9A0KiRJgHYuW02/tOyjR5YVB4dDfjuaBv6Ct1QCpbZSxniEJZ7dZ9BVt7OIeLZPODViiGW7EYyHq3qKKTypx57sZEEoHN7ddJXlr9O4R6t2G1Yp0/oT4f4z3EdmHJNPcDMK2DT093ZAUajSSbtmyjmqr4Stco3S0ml72WOVEN1aTiIYxyXwAEuB1F5MiAs6VjR74DgGyMnksJDsO2E8AJ4hYjplg2OqgH+KESz6c8FGOv4h++pX57JVrB1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmCUU4JQILi56vL6ZF+lIU+O1SEyL/Vb93HZLTvgFbc=;
 b=hlnzhJEF3l0XrlfBpHxqtBSLheO8KseFLZpl4y0vi0MQrbB6s3DrvJ1tlWSv2MDWIttY4qJMIwJllcdVILHjvnsdKy8XAEVZQdjwKOqjmFKIqCMxIa0RocHRYvNDptviUUMBiKYhYlr1YrzL/YF7DO1XSBdtNiLA2rY3MpyxtaNYHMDM703kPc7dyWKkSK3mLbotrkbZ8l6gSJV9ECkNKz+EiJy+iU816GV0gS+ODe9Nx0CmeGohb1kjOH2HatApE7moN0Q/Vf2I14y9QElEhdbLbz6/Yo8aFfynM0cS20IAPDXI/MesoQsoJI/+OkdWsKBQRK56pihrCG3YLNYV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:05:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:05:44 +0000
Date:   Mon, 6 Nov 2023 14:05:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Message-ID: <65496333c1dc9_90fed29479@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
 <20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
 <20231103142756.00000e20@Huawei.com>
 <547d055eb85d4cee9c636c69e89a82ed@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <547d055eb85d4cee9c636c69e89a82ed@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: d8514910-d04f-4c73-4c39-08dbdf1485d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMzZMte1LJjFK/lbqZloSLqdh3QRWTyJKU6klaQfbo6L3BOpyc+J1j8HO29cdQ3vVDWp/9YSGqKyMxUh72fI7mSrxyrVU94AMVgrb7EqxtywHeC10mjEeTVV6ViIMC4hHTnj6SWjF7D7LB9GZHeEt0ojDBnjl5ISCF1x6NDcYG1+59HhBx/PWdUCpi/52lYXBhQH/1K5NDOklik5/dwWVsMW+WLa+5YmxdkHPmGostJIAluRUeqjlDEReEQ9omE7ZWYrs0wlUNfgskdNQP1mNAQl+WqOAmKMkCIEa5h4DvqU6BATG6u02ZOIhWE+bQDrkgixJdO7KI3tVqXkjgC+9XNpPuMMcluf7AfTmGnbzcrHHGnUw29mT1rRTVq4DyVzSln0l4D96JcviMOWw915nXMxboE6Oz6qsQ5sDZKI1IKT9g8gu5R2aSY/C4wJVko/V2JVfxvsc+n/vgpBIRDZ/jeWtUxhWjIqclqo5dSpQHMdiBI1J4L3n31/fVkYpdRbHC4p9hQNRKUtg+797fRKmNDTrfrSEIPgeq2TTxI4xCmivE46IEP2qVgcyHAmqTTu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(316002)(38100700002)(82960400001)(478600001)(6666004)(6506007)(6486002)(110136005)(66556008)(66476007)(54906003)(9686003)(6512007)(66946007)(26005)(5660300002)(2906002)(8676002)(4326008)(86362001)(8936002)(41300700001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zSoRDJ5ppo5BrQoYWP7kBNJxdgfBgK48EWh3cfLYidzIqoSDYfEYNKjP46hS?=
 =?us-ascii?Q?qcm1MevV44KPPmF3Bqk/pk29KQ3+XLMWHIsGmuOnVrSi9rmQrBRapEg59XGD?=
 =?us-ascii?Q?ntcrgMks7KIDGhkg5BPd+kzndN+QMRo/DFak0AhKBJPwbrU1TWpN3rtiP6yo?=
 =?us-ascii?Q?Rn7G3os6PE5SAlYqdLqRLmWgqoZHqKqxbrrhyFmoSl77LLGFaCeFXYyXgHHH?=
 =?us-ascii?Q?WkyiiRG0KptQXbMpGJFRkunAiVvmkZxj1MXGInYSFME0zEzh4DgHUIU2MLGF?=
 =?us-ascii?Q?ASC+uiBOwbzZjaFlt7DvMNmv63g0ga3bjGTSHjNjfAi+qBrbghthQJ7R0MZZ?=
 =?us-ascii?Q?TZzaj7/Y1FrYl//Gl84ldUfAppvzAoO5Je8DrCtLoz8BbwohCAI4gKQNPKrt?=
 =?us-ascii?Q?keBe3tizPOWO+KUJGp/T8uTjhvwhTAKM6PJk4EMCjke0vh6ol32yNc7JAbRM?=
 =?us-ascii?Q?ZB968DUeHeAJTrz7PWJ6jME1lIC8SdQFSjJLrb7R0Ui7LLnK09eeAVcVvtk8?=
 =?us-ascii?Q?LI7pLRA4aRw0wFuxjDdlt9LRcxlhcEO2w8dtYX2Y2EJPWWexGZ8b+807+e59?=
 =?us-ascii?Q?ERQOoWd5Lfi8+TqivpTU+ZWGzvVj1S+qyvAt2N6szZqMRgqqvoT/tQsLQQZO?=
 =?us-ascii?Q?WfkKwtH96ZmPiuoKnawImQbq1LiWZAUCAbPjktmv8fsBMsVi7WEcGr+bMDZi?=
 =?us-ascii?Q?nifEsCj+z+ni7rZlgrlILg3c16BN+bmtiVRfoGT7NsjDR8iFBuAkah6Vu5JZ?=
 =?us-ascii?Q?t4kwGbmgtwMMjYdZrx7MyeABlkKfkZCyuB1QwGfOGsCjC+b3wO85ZRYvf1bS?=
 =?us-ascii?Q?NCfqGWWDkst/Wvx25UYKht4b774NBT/CS/OwSmPJuxyN/eJHJlPmmN+KEIMU?=
 =?us-ascii?Q?eLd5BU3dgUIFnIXWKLRovflOnZB3sEYu1W+1nwvL7osRUm0N4D6ifZPVgwVM?=
 =?us-ascii?Q?Q5lMzhIuLuHI6tA4Ta4sAtYaIJyMWn2M3gpKZ4gnCV1KULwnrkHXveLAomXp?=
 =?us-ascii?Q?lOew2FPIzoQQ8ivswR2MUmh0gO8lzDmcgnledf9V457Mnc8mAp47Q8RfbZmG?=
 =?us-ascii?Q?S53dNh+NZObr7/Y6dgWTW3xn5LaheTpiKhJNND6M+Qj9lJgy7MvThGz9Tuyt?=
 =?us-ascii?Q?azTtFvqEBVr++oUlGu1q6lTRtjzwm+xjWw1cP5/QVpbhYcyMz3lddSMCpYQ3?=
 =?us-ascii?Q?OIwr6jEDmy8PKqdfsVUhi5NwglOeAVjmFgVy7yHxxah5V0IrG51CsWd2NL2z?=
 =?us-ascii?Q?8xJ6BAkOxfv7jR9MoAgqwrOXGuNBMXz/i340su/YwI4XjuYSjjOjHp3gjIL7?=
 =?us-ascii?Q?2xocncaCXwIrb7fZ0AiOqY03hk3sjxqqAe5T9ydYrsr2GcsCEHj0PMsDDYb3?=
 =?us-ascii?Q?CnCuCXYMVjYrpR5GtoCmbTOJrBLz2tRmZEhVWaGHOSDGwzPBo7qA2wfd4L4Y?=
 =?us-ascii?Q?a1yeJNGPOK/gCqPBI3XAvWMufwlZnv55fkWE5w1zWFNP2MhxZAY6bcFgui45?=
 =?us-ascii?Q?7OpWmMjSx9RejnKhxgo/dfGXHLretPAo/UiAqD80avj9VYDXp4tYU5HW9d8X?=
 =?us-ascii?Q?p6o44lriMej77faPvEj720qpttyFLrncrds/dciu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8514910-d04f-4c73-4c39-08dbdf1485d7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:05:44.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyrR8RM/m/sAJA/NP0ZrD4if3woxakP1mOyKQ11Ov6IR97clTXBVte0NeqEF7JVYuKanhTIwYm87AiX8/1lLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Shiju Jose wrote:
> 
> 
> >-----Original Message-----
> >From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >Sent: 03 November 2023 14:28
> >To: Ira Weiny <ira.weiny@intel.com>
> >Cc: Dan Williams <dan.j.williams@intel.com>; Smita Koralahalli
> ><Smita.KoralahalliChannabasappa@amd.com>; Yazen Ghannam
> ><yazen.ghannam@amd.com>; Davidlohr Bueso <dave@stgolabs.net>; Dave
> >Jiang <dave.jiang@intel.com>; Alison Schofield <alison.schofield@intel.com>;
> >Vishal Verma <vishal.l.verma@intel.com>; Ard Biesheuvel <ardb@kernel.org>;
> >linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> >cxl@vger.kernel.org; Shiju Jose <shiju.jose@huawei.com>
> >Subject: Re: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
> >events
> >
> >On Wed, 01 Nov 2023 14:11:18 -0700
> >Ira Weiny <ira.weiny@intel.com> wrote:
> >
> >> The uuid printed in the well known events is redundant.  The uuid
> >> defines what the event was.
> >>
> >> Remove the uuid from the known events and only report it in the
> >> generic event as it remains informative there.
> >>
> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> >Removing the print is fine, but look like this also removes the actual trace point
> >field.  That's userspace ABI.  Expanding it is fine, but taking fields away is more
> >problematic.
> >
> >Are we sure we don't break anyone?  Shiju, will rasdaemon be fine with this
> >change?
> 
> The field hdr_uuid is removed from the common CXL_EVT_TP_entry shared by the
> trace events cxl_generic_event, cxl_general_media, cxl_dram and cxl_memory_module .
> rasdaemon will break because of this while processing these trace events
> and also affects the corresponding error records in the SQLite data base. 
> Rasdaemon needs update to avoid this.
>  

Ok we can leave the uuid field in easy enough.

But does rasdaemon use the value of the field for anything?  In other
words does CPER record processing need to generate a proper UUID value?

Ira
