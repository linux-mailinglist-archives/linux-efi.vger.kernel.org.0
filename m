Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1D527DC1
	for <lists+linux-efi@lfdr.de>; Mon, 16 May 2022 08:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiEPGrK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 May 2022 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiEPGrJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 May 2022 02:47:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95CDF5D;
        Sun, 15 May 2022 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652683627; x=1684219627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u2DL5kh/ahtrjhyccdrAADy+tIeizNmjzYVUrECOtTw=;
  b=LelfwhwTWQ4aJYQBB6xmaQPV9BC8D9EuNqCzaYIN91ALaTw/Gbl/YrNi
   JzwRX430gJtJ41uZ+tr70s1ElFhlxmOk3eZk+m3d1WhOLcx6H8q/TfTDY
   hy+5TmT7C/7bTJRCg1K3+bIyyfTsAQPhTMmklCQ9rvBi68mJLWnC/ah6N
   WGYay9zrGU3ZZbhJP4Kgej8SIzrt3NIqRhZ3CEw+tIdmjNXUvaE/j33op
   015RBts+mUAnSApDwES/sfRA22Dq8OUoPzkNqZoHcs2pBNFfHUqujiEI3
   PmgKNFYBVynZD6PTZDzZaLK/vPi0TxKRziPZ+QHOHk7cyNVSaUprcWVXH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="252818388"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="252818388"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 23:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="568183001"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2022 23:46:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 15 May 2022 23:46:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 15 May 2022 23:46:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 15 May 2022 23:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbETYeoxxqaDbnDc3HSOtZqMy4Q54T8f5JS+0XgdIJoU5lLe9vHJztQM+wJc70AJ3D8Ub9VfoGIj+1j1nnD7rMnKPzt5Ua03x6CJWGZT7/7P2jwuxNfntfjYlbm8Ftk+RFkNcR0ImlkJ31Cn7InotYzpEO54yDKqZ3evL39XxBZ/wBJS0yDf2B6vxCxOCIenf9/8/Jh09u1tCsTUXJV/4RpLD8+2XBuPqJT423tnABwjUyrfbvngvCCjO5LzRtKfrTCIh8eQtYWgux+UOirS7tRiUMb0tIK5nRRiSRv6fNN5aW+BJL/Pu1AzTRyQYhrE1TTfbMzLnn5KfjmQf3T3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2DL5kh/ahtrjhyccdrAADy+tIeizNmjzYVUrECOtTw=;
 b=kpKyRIjA/k9E88z9Qvolk9sY1JBLPYCUK1TP3RDgogdfgl+1dIx+ht7+nrLy+sqi4/Ste0XEm9vscTXfZSuh1LCt8lkbEZY2d0L21Ahjh7wZPojP/Kqrwyd1ex5SzydLQVaNsAqL+SpRr5agGlQkIfV6rFv9SUL4dTktAbjOnQAeCNLHXYawpAIlijVyrlsvTdRa01yA7AQk3s8Dt7qBy/MZHIYOvQr65QpsCBZSpP4mI83CJfLeSvayvrzrpmitLEgemEtxpkAIF1ZsuIw6d3aLzEcqUJa/OkpSu7fSTYwC8SqSSuobhOKZJbIKBnZouPCTavq914PtYdPdH4wA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15)
 by DM5PR11MB1418.namprd11.prod.outlook.com (2603:10b6:3:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 06:46:53 +0000
Received: from PH0PR11MB5064.namprd11.prod.outlook.com
 ([fe80::1844:3fca:639e:7c56]) by PH0PR11MB5064.namprd11.prod.outlook.com
 ([fe80::1844:3fca:639e:7c56%6]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 06:46:53 +0000
From:   "Xu, Min M" <min.m.xu@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>
CC:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        "Dario Faggioli" <dfaggioli@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Thread-Topic: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Thread-Index: AQHYZtgcM5CpDUl/gkuqqiQv4xAy4a0hDHpA
Date:   Mon, 16 May 2022 06:46:53 +0000
Message-ID: <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic>
 <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
In-Reply-To: <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6c3d69c-db6f-4fdb-ff3e-08da3707dcbd
x-ms-traffictypediagnostic: DM5PR11MB1418:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB14181598B59327AD4403A19FC5CF9@DM5PR11MB1418.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oilb9NIbtTLXkmw5N8++Jrbjz/wA88jMSUSYf8skoVtYEUF6/ym+rzpzh0Q6QTuGaIx0FV7jFhJQ77F9QXVshbwGKnV7cSFtAOe8gTl43HbpGSZbWvReSC6zYmqMWgsemdm87LJMN5SiFSZnbN1dWlvaoBpA/n9U1PlZFkcthcAq4o6OzJ2KcjA37VZKZmAMFNFDC0MHf8nX+BZPOUrm4Vai+ZVHrBKn3soZ4pee1N9sVlhjY6AtUyjBOAbVZpIpcY4vLE4nChnsLDieD5lRYB6SzlDbLP+mObt/csfHq6NgBIjcQQZfg4BHyy0sO7IFOvW0NzXspAZOZbK2nkbLBooaPER/x9O+ZjZpd/HrQpWVYxjTV9F9gxpXCaobSAdXs34Lf3P02JQLiIzroGHhlBj1CvIxSPd4aM1i07waoTaPndEUbfZL48Ce86tI7k/022ggGo9pGVRM2g+FAMqLr2q71Z3ebx2lloxqt8kelo65vOqI+Iklrg/jM8Q8PG7R6itWzrt1wJGT+WzHR/nk64RnjdyBCOEH0itr95bYw9HDHAvsyAM+EEbe7brvfb8SIPQTTw+g25s13je7sovDjzbH6CJ0ogZlu5CosXmz3P0tBHR2SV+ka2F8iwTq53DZwRaWnjAafFkbYmvis0D3C2MYql+5Hd3zywExVv78MYebp6+2JH6o7ayJ13RQly08ew3LwstUZWstgvFIqqeil8vUyGlzsScX++OhKXAIKf00wMvImZlOU8qIesuQuktGzGSeRq3qP53FEPwmZSBlGDfGqDmk32qNLwSg0mXt4zbZOuB43V+5WNpI0r88wVPyDZ0SiUsKlb8lLLZV9wT3Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(45080400002)(52536014)(4326008)(66476007)(66556008)(64756008)(66946007)(66446008)(38100700002)(38070700005)(76116006)(71200400001)(86362001)(33656002)(83380400001)(508600001)(8936002)(2906002)(55016003)(316002)(8676002)(122000001)(54906003)(9686003)(26005)(6636002)(5660300002)(6506007)(7696005)(7416002)(82960400001)(966005)(53546011)(110136005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jLJDRAwoHRjM+79WQL+pmjuaNy7brbnRj3ztQYegWElXh9Bc4bK/G7wjCdrM?=
 =?us-ascii?Q?eipC29QB9NxExNSAdHIlpdNT09HFxrDMLWxSpEA8+C3oIVu+elB47goYQ3jq?=
 =?us-ascii?Q?T8s7shRdPc62yx5WYnveZLRBQM2BRdgZLNT1xzyc2aoUPAW8T6lcJ3joh0Op?=
 =?us-ascii?Q?kCISV1jR/iG87SIZueNM3QZ5LCwLzIOlt2pcDRWvQH8fRNR/V4cI185Jtv1g?=
 =?us-ascii?Q?ntRozuSs0r9/gq6laMe8E7NIgN8YQWmWADgqiaEirvsMwilz3SvQlXmSTMS6?=
 =?us-ascii?Q?QP8/Dx0Nj4Vk3ZuNLyOJiMPgxCkuYzw3cybW90R6EXb0cU58hMT+qxU6R8rP?=
 =?us-ascii?Q?DI7SCQRWTEr1JLuki4kXsLRUFXSfYTNAPmvIuqxs+ATZhttGvYXHWwWCqP1Q?=
 =?us-ascii?Q?ks8jKh00u+fcU97KQb5rqn3pxzm37UNE2O5D8FayJK/ypZFtWy6PAFIbhRcK?=
 =?us-ascii?Q?S/bXEeWijPfad9824P+cwHY+pnKUzOEPD1efSBTbcmeVBSfOj9gRr8Zwa9Mn?=
 =?us-ascii?Q?+pq8JtgXySMWYYTSfQ2OMZfrsWB7WcljP01TBKsQhuCNjHc8P/Cz+tlk+PRA?=
 =?us-ascii?Q?upV5j8PbTICuDYFe2dRunFNL7KxEASmUxp6r/ZuUWTusesmKyROGUkeXsboY?=
 =?us-ascii?Q?7BNK8H/2yCYcV/WVsH73K+hZw5AKiyokSjMtFMRhNyZGUg4ACyzKE+OjMhJl?=
 =?us-ascii?Q?6qiZx3BK6A2tFu5PxFzpycXisoJ6yLSkrqz4vnD9gwyJ8/+enOVLIsckCAFm?=
 =?us-ascii?Q?V5GPUZ2iB1J3G1vtIg2WpXV0LDcY7WI/M8pqLMXab81YlpmCO0DbODZrlgoq?=
 =?us-ascii?Q?c6LMnxW6aKwVOww8dJ4jRbCyuSNcidbV8cjQ946UqRoH2T7BliWkasVl8QP3?=
 =?us-ascii?Q?+4CMRmG4FLZTkkKdy2AuTA2hP0ruzU3AYVDkt9G2qqYEROd/Ca43+tfnjyVq?=
 =?us-ascii?Q?K5QmJRjZhNjYbAFNB9VasDN4GrF+0EKIfF9615e/jXWmj1bkcaQOtWj/u170?=
 =?us-ascii?Q?o7klL1F5NGJRBRx09/cfN434Obk7K8GMfiVanVWxC+PkS/kk/CuD3V5lhYz+?=
 =?us-ascii?Q?UmwIvFy4BlqBG04PT8aTE3db9GUoGzlX+jJm2uxYK3MhV9SEEe+rnVuT64iQ?=
 =?us-ascii?Q?vLVIYKso+jh/ryqXkeKBDRtLPDRPqcXpIy3x0oKAcoQGIdAXl5LLVqVXdJrC?=
 =?us-ascii?Q?MWHUeAjX333r2FN5lXQDd8PRALOJPczsiDGYOPE1yheS7PDtxWngA9s0zF5z?=
 =?us-ascii?Q?1Rc1105t3Uhyk0cOO7vlEaFyurXr69V4MpUzB7+WVPS3BpDt2GtXrBx2IXPx?=
 =?us-ascii?Q?sszXJMym2KRPTTo4LeD/0eUDOLMHz/Wj0P0S6Yn12SgzMP8G15d1X+5A/+zO?=
 =?us-ascii?Q?0NjgjF8mQ6ZfMOnIU2sg6JamyemTXxy/wFamNnltQCQW1I5XAJxpDQ0qQZuD?=
 =?us-ascii?Q?oRIMEzg6y1/8qjG6JNp6xshy29v96xeOB2TA3iGadJu6PCp1rGshS7dwofHe?=
 =?us-ascii?Q?rcKc16wmZ876ILMhGIt9KYQlifOSOQbseidoWxtMA6PjMtg1z0KM5XEvu8eN?=
 =?us-ascii?Q?s5zd5knxkpAJMCcfGpS16Zi81vLpwaYA95Zj6qMmMD7vVGKa2niPKahPuAqs?=
 =?us-ascii?Q?QUcXM5V9xATok2oLeYMRyhV28NpDA1Z9Sd2knDA2qqdidnGw7APDGMP3ly2T?=
 =?us-ascii?Q?YETGFPysCFaJ+ADmWlt8UShwUI7xHB47OdBVghKtUj2L9MpmFBWlsynEOqa0?=
 =?us-ascii?Q?d0vOsftdHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c3d69c-db6f-4fdb-ff3e-08da3707dcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 06:46:53.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8fM6fLcdH/clpha4lDmZ57pHTUFZmPZwf127skd/1SX69CuX9Zml/zN+3CoAvPnm9p1UIN8fPWgDAc1M1NbDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On May 13, 2022 10:45 PM, Kirill A. Shutemov wrote:
> On Fri, May 13, 2022 at 11:01:43AM +0200, Borislav Petkov wrote:
> > + mroth
> > - brijesh
> >
> > On Thu, May 12, 2022 at 10:34:02PM -0700, Dionna Amalie Glaze wrote:
> > > Kirill, I've been tracking these changes to see if we can handle the
> > > unaccepted memory type for SEV-SNP, but testing has been an issue.
> > > The proposed patch in Ovmf to introduce unaccepted memory seems to
> > > have stalled out last September
> > > (https://www.mail-archive.com/devel@edk2.groups.io/msg35842.html)
> > > and is particularly difficult to adapt to SEV-SNP since it doesn't
> > > follow the TDVF way of initializing all memory. Is there a different
> > > development I might have missed so that we might test these cases?
> > > Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any
> kernel
> > > uses are essentially dead code.
>=20
> + Min, Jiaqi.
>=20
> I don't follow firmware development. Min, Jiaqi, could you comment?
>=20
We have prepared the patch for unaccepted memory and it is now working in o=
ur internal release.
But there is an obstacle to upstream it to edk2 master branch.=20
The patch-set depends on the definition of UEFI_RESOURCE_MEMORY_UNACCEPTED =
in PI spec. This is proposed in https://github.com/microsoft/mu_basecore/pu=
ll/66/files#diff-b20a11152d1ce9249c691be5690b4baf52069efadf2e2546cdd2eb663d=
80c9e4R237, according to UEFI-Code-First. The proposal was approved in 2021=
 in UEFI Mantis, and will be added to the new PI.next specification. (Till =
now it has not been added in the latest PI spec.)
So UEFI_RESOURCE_MEMORY_UNACCEPTED cannot be added in MdePkg which make it =
difficult to submit the patch to edk2 community for review. See this link: =
https://edk2.groups.io/g/devel/message/87558

Please be noted: UEFI_RESOURCE_MEMORY_UNACCEPTED (defined in PI spec) is di=
fferent from EFI_UNACCEPTED_MEMORY (defined in UEFI spec)

I will submit the patch-set once the new definition is added in the new PI.=
next spec.

Thanks
Min
