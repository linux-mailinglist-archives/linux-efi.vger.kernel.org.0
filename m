Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63437579104
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jul 2022 04:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiGSCtC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jul 2022 22:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiGSCtB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Jul 2022 22:49:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708D532ED9;
        Mon, 18 Jul 2022 19:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658198940; x=1689734940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ISpGdFeuyuTAVk/PAWmZTefgBvU+0eYEKb3k+X1ygw=;
  b=Xd5yHhkj+L8y7MVVrqD59rmNXY55BR0h1rwMhLTNfYtPXA09TRxvgIwA
   XXDzw/OEgI107THf4du0qBW6eVGGDlYxTOL0ahJGlLQvBw1N0By75bwuK
   DkHH/4ORlv6WKee6AdtX76lKPhXYGc9WBXUKFV1pVn1sPd7YtZSXFtujc
   kMPCPmC/cp3/mJPtaFlogodMk2Gl88g/dqrVqJ+WnGIU8knomGfiBv/wa
   b6KniLvvpH9HV4eSnB/AVS6LHw07RMNfztZvi4XzpKWsJV+tcgSeC2oeC
   81mouwssqRxHq2HfYPdyCD0OMN7WYXX8J0rm3ebqtqorxtcs8ORW7kTgs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283934259"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="283934259"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 19:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="739692230"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2022 19:48:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 19:48:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Jul 2022 19:48:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 19:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G16kRFc4Ehs1PEwSfRGY/y4AlXNEQnbld53KNt1kjgVXGaszHBfkz4/j656qBePQNsjmSmO7bRf/PbIi8WU8M5Jfgd7UvElK85Y+wyI+D36QwYcV///JWtFbJyYLSPC03nn1hJbtpWnma1p8Pxm0ExgpLERyoGnffdiQ+5/Eixw/3Y4yoXaaNEYSnpxbE8wPdK8M/gmhewsuG4HZZfPTNcjTe/iPiQ+jqA7PZjvb8z2DekXHZBYZHcnuGfHb3FHPUZ41z3pr5hiDrrHkfxYWyVY3i8Ewg2vFsMTS1bf6NS0IceJtOTP2h/txM20le7V0Bma2C2AWlaxF/i/hVfJeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ISpGdFeuyuTAVk/PAWmZTefgBvU+0eYEKb3k+X1ygw=;
 b=gAA4cyXzU8qfndhmI7y9HVbxJ2xLpOpUntm0OGQr+WbNSntOApEgbxqUMdmuiRSlqCql4dIDjNOqy+4icJCbPLK1OfZi8KROA7h5TAVZ5wmDvN+HomuuC4WsrxVHVVqN68/IuaSIJaKB2oWO4S4Gxncg8LerkI/q2aBfwxY9noBhSdpIh5k88JZpPhkMyNdGIO6ar8OP6PCuP0ERprsxoJK50ZNj+Dc5xdTmkXggBMy1q1ceZbPXhUPRC9z2tPwW2W8p2fTwAmJklnH9NgUGZxDBsIprF3WcNFb68+/hzmbZk/8KQ7xK0w8Mb30WBhm2Pp5hCDjJYlaEWxXBhqyM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 02:48:55 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::fd61:b244:d8fb:ab1d]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::fd61:b244:d8fb:ab1d%4]) with mapi id 15.20.5438.021; Tue, 19 Jul 2022
 02:48:54 +0000
From:   "Yao, Jiewen" <jiewen.yao@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
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
        "Marcelo Cerri" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Subject: RE: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Thread-Topic: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Thread-Index: AQHYmv6nBTwuqd2UzUeuaGZiRtp7B62E/d6A
Date:   Tue, 19 Jul 2022 02:48:54 +0000
Message-ID: <MW4PR11MB5872F205FE3F9B11CAFACBA18C8F9@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com>
 <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com>
 <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
 <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
In-Reply-To: <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0776cdd2-1ff5-4719-470a-08da6931387e
x-ms-traffictypediagnostic: DM6PR11MB4754:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLiRbyFGlq4Qln+mxYAqZZpVGNCUmtq6lVl2ugCDSkb0Boxr9OShKDS2SI/AiTYe+5zGPuFr0cUTXxOxh0N9XFyPl0COCnXNcsKc46MxLXm7IMqY4slMADqP3EYl18JTWBJ71yEcpGz2llBdp/l+7GN2lKz1Ym2CYl8gG9foaYmNac4rJ0Jw0nSUOMR37zsJRWcNOVynCTdgRQ241CvC2Q5KWFl3+qVNAZomKv3X9YjOqhw6hu1qN4bZGKHsPyTYDkb/5DyOT/5F2AdVIvwfTTBBbQTAGv6iU5doYtr3ZqL8SR5m+LInBmmhcoNTGnRiS/gnJVGkPde+uxcYgTZm4wOaZ4dTr2u98N0vdRpuGzvMnA0E8O7d79J5Xz0sfXbvFXZpD21v8Jk5MZpqzrWWhfkPh3h7fzbJ30HAnKrTFqrnqlWiFlrDkCNv2HqQHCPuzOJl+sH7ynGZ0lkcxjl6+aXfWqzdf3RwtY00PcaICFnJOWmMJ9s8veplFtYiaezBd16TncKMbu/yId7YmjRC6iGdmm8g3++YJHrQ+LHSq0M0+W/Y+TommVopyuGNKgzCjbc9yrvPSkqdhZC95XIhwjf3Twdg0sJSvQFIoWSOefSNhUN+iEmqleR4DlGFs3WvmKaIhgZAYC/+IYEWBbBZkmbQR/tzFry+RMusWAK52Sz35ZQsJ233uT6eNeir1VUn01XEWpwcjf99hfsI7fqOqAb5CuRWDeqcapwOedqQ5lOAjmIugolDjleQCRH1q4yyiT9pDza7gCJCnuNDHwp7tdVsH20V7XpZZXW2xcr+kTJheymISf7HD9shykeEHGNEt+LqSZO1R3nu5IAbkCvXxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39860400002)(376002)(52536014)(64756008)(8936002)(5660300002)(7406005)(55016003)(76116006)(7416002)(66556008)(33656002)(2906002)(8676002)(86362001)(110136005)(4326008)(66446008)(54906003)(316002)(53546011)(7696005)(122000001)(82960400001)(6506007)(26005)(71200400001)(41300700001)(9686003)(966005)(186003)(478600001)(66476007)(83380400001)(66946007)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDd0clhhTGJSQWlGRExieFg1cFZtT09IeVZqdGVZY1JPR1h2SnBYWEZRcXZt?=
 =?utf-8?B?Sy9FNGV6NWM0RHBYU2dRNU55L014NDV6V3YzV1kvMUt0SjE3Vy9ybUtETGlE?=
 =?utf-8?B?YlZwNUVJNGkxVUVIWW9oTnZvTVZQeHlnU1BLdkk0THpNNWVCeEhHbUo5b2g4?=
 =?utf-8?B?SG0rVmdPZXlMT002bUhZYnZ5cStuNFZyL05QZTRrcTh6UmI2OTNPZEFGU3dU?=
 =?utf-8?B?UmhqMks2U3RHQXNNbE9xbUw2S2RUVXF5NlF0TUhsektRR21seEFic0tCRHBj?=
 =?utf-8?B?ZG9DcldDRGVIV1RzbFRLVG9LYkZpVnVINkIyMTZYZTByUGxsRmpWVVplMEcw?=
 =?utf-8?B?NTdQaWJOUi9CRzJPNFQ0ZGd2RHRYcEtWWVhOby8xZGdQNUNqclo5Q2xFSDg5?=
 =?utf-8?B?M2wxcjl5b2U1cmFoNmxjaG5kN0Nzd0RicUsralRmOSsvK1hXOU9aN3NrOVRG?=
 =?utf-8?B?UFFzWVBYdnB2M3hITUlxVmhiWUpMa1NBKzV3c1o0TEdPTEkyalROUmxHZDlj?=
 =?utf-8?B?WE1Db3ppUjY1REFEeXF5Zy9uTng5VUNBOXhDVVlRb2kveWlZY3c3Y0lTU0FH?=
 =?utf-8?B?dmtJdFNUd0dpNTNxOEIyeWJ6eC9kMEdyQURyWWFvenkzWnlKeVJWQTNZOER1?=
 =?utf-8?B?SzJ6NE13UWVrN1E1Q0c5NkZ1aHlOMThqTk5FajJrOEdWVWlvYnMySlUwZkxu?=
 =?utf-8?B?cUdLNDB3TTYybXYyTUF4K1ZWL1BycDYyZHM3cEQ3MmJrdTE3WTJZRmZqNFFp?=
 =?utf-8?B?clE4RG1XOFRJb1IwRVBCUUZiUHZSeVRBK3lhc056d3F3MnpDbXhqdDkraVBH?=
 =?utf-8?B?aHYrN1FCUG0vT0htV3JqUWttZ01VY1ppanpJYnVocDdzeHdlUlJQclBGVVZx?=
 =?utf-8?B?NnZtUzhmaVZOWUJJLyt5TTdEYXdLS1dvZUNFeE5ZMG5TQ0dHc0Z3aHJVZDJO?=
 =?utf-8?B?UGxqdm1nT1ZKMnV0VWtrRnUyL3B1RzQ3YnBnT0ora250VGUxak4rZkNWbWRY?=
 =?utf-8?B?bDlYUFlld3ZyUm5hSU93UkxZUkNzTEJ4ejNLVDJIaWFwMW9xcXNtaFNSYjNV?=
 =?utf-8?B?cHREeTRCODByK1V2S2lFajVMNHhRZ0crNWFmbVpsSnNDMFp1d2I2eFEzUklW?=
 =?utf-8?B?dTZNNlRsVjNHa01pSzBLZmsyckpuUy8zellSblA2LzM1dVpUYWNjdGRJMlFQ?=
 =?utf-8?B?SHg4bXF1eGFiaU9kMXIzc0NpOXVJc0tZWHJ6N2FKejF6TVRMUitkSG9BSkdy?=
 =?utf-8?B?allKUXJiNnhZWEsvMlJKdnlZWnhPcXlmaDNiQXI4T1gzd2cxUFR1dlFwZzBI?=
 =?utf-8?B?b3NpWUx3Rjl1VGFsb09BNzZhdENBaTB0MDJaRmxpMnlYeUNaamZta2JMMjZx?=
 =?utf-8?B?TDNuYXU0Z1pjZWhoUmY4Mk9IQUdwa251YndhNUlBMSt5a1BqZ2tuZUIzTkNa?=
 =?utf-8?B?bnpwK0NrUU9BcXdHTVNocUhBZjhaNHgzNXFQUFJrbzZNWitpM2pjOHBKdmdX?=
 =?utf-8?B?Y1pxLzdMNi9veVcwWXFDU3RCNVdOb2I2M1BPYnBGYWxTQ28vT3BJYTVrT2Mv?=
 =?utf-8?B?Yno0SFZWblY3c3ZFZEZzQzU4YUVlbEwra2pJSlcveEJudWhpRmVUL0FGVmU4?=
 =?utf-8?B?d3dPc2kyeW5wcTFvSG0vd0hveUdSTmhicTg2eGFoc0V6TXlkckJreWJBbmVk?=
 =?utf-8?B?N0tNa2hlR1gzVUlkMittZ2NSUEZVRXNQdkhrS2g0YlNJVUZNaytQMEZsYXM2?=
 =?utf-8?B?U0JFdnl2Uk5QK2syTXJmRk9NNkIwUjVVSFljcExTY0FUcVd0RTlZVE1oeHk1?=
 =?utf-8?B?MFJZMTFId25LTWJwOU5MczJuelVYaVRlZnRpRE14Rk00Y0Y1YmZSQVZhVmZ2?=
 =?utf-8?B?cTVYMGpqaC9RYlk0SkxGQ1cvd25YWVBJZ3RCZmZtSHBjR2ZLd0kzZndrMVU2?=
 =?utf-8?B?NDdKT04wTXl3TWk5RkQ1SE0zdll3QUFMcS9FaGhDd29YNDVuWmN1UE5VNjBB?=
 =?utf-8?B?dk4zREFObzhYSWR4ZG1tY0t6Wmo0eXZjVU5pR2ZURHhoVkVNZjZMbWpWUTc5?=
 =?utf-8?B?SDVIMmhNdlVHUWpRMDVPaGg0WGhYR0FxNnE1M3VaSXpPV2VOMzFDNkVRR29v?=
 =?utf-8?Q?8HPUxbXvi/3372NojGfmkvS8K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0776cdd2-1ff5-4719-470a-08da6931387e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 02:48:54.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6P2nJ5UodgoGr/f83dop7hZOfZ3ivUQTAWMRHq0shI+ZkAljt6j33HjUJURvQqn9yv0i0ZSNE8wrJDON/b0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGV5DQpJIHBvc3RlZCBteSBjb21tZW50IG9uIEJ1Z3ppbGxhIGh0dHBzOi8vYnVnemlsbGEudGlh
bm9jb3JlLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9Mzk4Nw0KDQpMZXQncyBhY2hpZXZlIEVES0lJL1VF
RkkgcmVsYXRlZCBkaXNjdXNzaW9uIHRoZXJlLg0KDQpUaGFuayB5b3UNCllhbywgSmlld2VuDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlvbm5hIEFtYWxpZSBHbGF6
ZSA8ZGlvbm5hZ2xhemVAZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxOSwgMjAy
MiA3OjMyIEFNDQo+IFRvOiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51
eC5pbnRlbC5jb20+DQo+IENjOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgUGV0
ZXIgR29uZGEgPHBnb25kYUBnb29nbGUuY29tPjsNCj4gQm9yaXNsYXYgUGV0a292IDxicEBhbGll
bjguZGU+OyBMdXRvbWlyc2tpLCBBbmR5IDxsdXRvQGtlcm5lbC5vcmc+Ow0KPiBDaHJpc3RvcGhl
cnNvbiwsIFNlYW4gPHNlYW5qY0Bnb29nbGUuY29tPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51
eC0NCj4gZm91bmRhdGlvbi5vcmc+OyBSb2RlbCwgSm9yZyA8anJvZWRlbEBzdXNlLmRlPjsgQW5k
aSBLbGVlbg0KPiA8YWtAbGludXguaW50ZWwuY29tPjsgS3VwcHVzd2FteSBTYXRoeWFuYXJheWFu
YW4NCj4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT47IERhdmlk
IFJpZW50amVzDQo+IDxyaWVudGplc0Bnb29nbGUuY29tPjsgVmxhc3RpbWlsIEJhYmthIDx2YmFi
a2FAc3VzZS5jej47IFRvbSBMZW5kYWNreQ0KPiA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+OyBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyDQo+IFppamxzdHJhIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+
OyBJbmdvDQo+IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFZhcmFkIEdhdXRhbSA8dmFyYWQu
Z2F1dGFtQHN1c2UuY29tPjsNCj4gRGFyaW8gRmFnZ2lvbGkgPGRmYWdnaW9saUBzdXNlLmNvbT47
IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsNCj4gTWlrZSBSYXBvcG9ydCA8
cnBwdEBrZXJuZWwub3JnPjsgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Ow0K
PiBNYXJjZWxvIENlcnJpIDxtYXJjZWxvLmNlcnJpQGNhbm9uaWNhbC5jb20+OyB0aW0uZ2FyZG5l
ckBjYW5vbmljYWwuY29tOw0KPiBLaGFsaWQgRWxNb3VzbHkgPGtoYWxpZC5lbG1vdXNseUBjYW5v
bmljYWwuY29tPjsgQ294LCBQaGlsaXANCj4gPHBoaWxpcC5jb3hAY2Fub25pY2FsLmNvbT47IHRo
ZSBhcmNoL3g4NiBtYWludGFpbmVycyA8eDg2QGtlcm5lbC5vcmc+Ow0KPiBMaW51eCBNZW1vcnkg
TWFuYWdlbWVudCBMaXN0IDxsaW51eC1tbUBrdmFjay5vcmc+OyBsaW51eC0NCj4gY29jb0BsaXN0
cy5saW51eC5kZXY7IGxpbnV4LWVmaSA8bGludXgtZWZpQHZnZXIua2VybmVsLm9yZz47IExLTUwg
PGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgWWFvLCBKaWV3ZW4gPGppZXdlbi55
YW9AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjcgMDAvMTRdIG1tLCB4ODYvY2M6
IEltcGxlbWVudCBzdXBwb3J0IGZvciB1bmFjY2VwdGVkDQo+IG1lbW9yeQ0KPiANCj4gPiBJJ3Zl
IHRhbGtlZCB3aXRoIG91ciBmaXJtd2FyZSBleHBlcnQgdG9kYXkgYW5kIEkgdGhpbmsgd2UgaGF2
ZSBhIHByb2JsZW0NCj4gPiB3aXRoIHRoZSBhcHByb2FjaCB3aGVuIGtlcm5lbCBkZWNsYXJpZXMg
c3VwcG9ydCBvZiB1bmFjY2VwdGVkIG1lbW9yeS4NCj4gPg0KPiANCj4gSXMgdGhpcyBKaWV3ZW4g
WWFvPyBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIGRlc2lnbiB0aGUgVUVGSSBzcGVjIGNoYW5nZQ0KPiB3
aXRoIGhpbS4gVGhlIGJvb3Rsb2FkZXIgcHJvYmxlbSBoZSBjb21tZW50ZWQgd2l0aCB0aGlzIG1v
cm5pbmcgd2FzDQo+IHNvbWV0aGluZyBJIHdhc24ndCBmdWxseSBjb25zaWRlcmluZy4NCj4gDQo+
ID4gVGhpcyBhcHBvcmFjaCBkb2Vzbid0IHdvcmsgaWYgd2UgaW5jbHVkZSBib290bG9hZGVyIGlu
dG8gdGhlIHBpY3R1cmU6IGlmDQo+ID4gRUJTKCkgY2FsbGVkIGJ5IGJvb3Rsb2FkZXIgd2Ugc3Rp
bGwgY2Fubm90IGtub3cgaWYgdGFyZ2V0IGtlcm5lbCBzdXBwb3J0cw0KPiA+IHVuYWNjZXB0ZWQg
bWVtb3J5IGFuZCB3ZSByZXR1cm4gdG8gdGhlIHNxdWFyZSAxLg0KPiA+DQo+ID4gSSB0aGluayB3
ZSBzaG91bGQgbWFrZSBpdCBvYnZpb3VzIGZyb20gYSBrZXJuZWwgaW1hZ2UgaWYgaXQgc3VwcG9y
dHMNCj4gPiB1bmFjY2VwdGVkIG1lbW9yeSAod2l0aCBVVFNfVkVSU0lPTiBvciBvdGhlciB3YXkp
Lg0KPiA+DQo+ID4gQW55IGNvbW1lbnRzPw0KPiANCj4gSXMgdGhpcyBiaW5hcnkgcGFyc2luZyB0
cmljayBhbHJlYWR5IHVzZWQgaW4gRURLMj8gSWYgbm90LCBJIHdvdWxkbid0DQo+IHdhbnQgdG8g
aW50cm9kdWNlIGFuIEFCSS1zb2xpZGlmeWluZyByZXF1aXJlbWVudCBsaWtlIHRoYXQuDQo+IA0K
PiBBIGJpdCBtb3JlIGN1bWJlcnNvbWUsIGJ1dCBtb3JlIGZsZXhpYmxlIHdheSB0byBlbmFibGUg
dGhlIGZlYXR1cmUgaXMNCj4gYW4gaWRlYSBJIGhhZCBpbiBhIG1lZXRpbmcgdG9kYXk6DQo+IE1h
a2UgdW5hY2NlcHRlZCBtZW1vcnkgc3VwcG9ydCBhIGZlYXR1cmUtZW5hYmxpbmcgRUZJIGRyaXZl
ciBpbnN0YWxsZWQNCj4gdG8gdGhlIEVGSSBzeXN0ZW0gcGFydGl0aW9uLg0KPiANCj4gKiBUaGUg
Zmlyc3QgdGltZSB5b3UgYm9vdCAoc2V0dXAgbW9kZSksIHlvdSBpbnN0YWxsIGFuIEVGSSBkcml2
ZXIgdGhhdA0KPiBqdXN0IHNldHMgYSBmZWF0dXJlIFBjZCB0byB0cnVlICh1c2luZyBhIGN1c3Rv
bSBwcm90b2NvbCBhcyBBcmQgaGFkDQo+IHN1Z2dlc3RlZCBhYm92ZSkuDQo+ICogVGhlIHNlY29u
ZCB0aW1lIHlvdSBib290LCBpZiB0aGUgZmVhdHVyZSBQY2QgaXMgdHJ1ZSwgdGhlbiB0aGUgVUVG
SQ0KPiBpcyBmcmVlIHRvIG5vdCBhY2NlcHQgbWVtb3J5IGFuZCB1c2UgdGhlIHVuYWNjZXB0ZWQg
bWVtb3J5IHR5cGUuIFRoZQ0KPiBib290bG9hZGVyIHdpbGwgcnVuIGFmdGVyIHVuYWNjZXB0ZWQg
bWVtb3J5IGhhcyBiZWVuIGFsbG93ZWQgYWxyZWFkeSwNCj4gc28gdGhlcmUgaXMgbm8gYWNjZXB0
LWFsbCBldmVudC4NCj4gDQo+IFRoZSBkZWZhdWx0IGJlaGF2aW9yIHdpbGwgYmUgdG8gYWNjZXB0
IGFsbCBtZW1vcnkgd2hlbiBHZXRNZW1vcnlNYXAgaXMNCj4gY2FsbGVkIHVubGVzcyB0aGUgZmVh
dHVyZSBwY2QgaXMgc2V0IHRvIHRydWUuDQo+IA0KPiBXZSBjYW4gdGhlbiBzYXkgdGhpcyBkcml2
ZXIgaXNuJ3QgbmVlZGVkIG9uY2Ugc29tZSBuZXcgZ2VuZXJhdGlvbiBvZg0KPiB0aGlzIHRlY2hu
b2xvZ3kgY29tZXMgYWxvbmcgYW5kIHdlIGNhbiByZXF1aXJlIHVuYWNjZXB0ZWQgbWVtb3J5DQo+
IHN1cHBvcnQgYXMgcGFydCBvZiB0aGF0IHRlY2hub2xvZ3kncyBiYXNlbGluZSwgb3Igd2UgbWFu
YWdlIHRvIHVwZGF0ZQ0KPiB0aGUgVUVGSSBzcGVjIHRvIGhhdmUgR2V0TWVtb3J5TWFwRXggd2hp
Y2ggaGFzIHVuYWNjZXB0ZWQgbWVtb3J5DQo+IHN1cHBvcnQgYmFrZWQgaW4gYW5kIHRoZSBib290
bG9hZGVycyBhbGwga25vdyB0byB1c2UgaXQuDQo+IA0KPiBUaGUgY2xvdWQgZXhwZXJpZW5jZSB3
aWxsIGJlLCAiaXMgYm9vdCBzbG93PyBJbnN0YWxsIHRoaXMgRUZJIGRyaXZlcg0KPiBmcm9tIHRo
ZSBjbG91ZCBzZXJ2aWNlIHByb3ZpZGVyIiB0byB0ZWxsIHRoZSBVRUZJIHRvIGVuYWJsZSB1bmFj
Y2VwdGVkDQo+IG1lbW9yeS4NCj4gDQo+IC0tDQo+IC1EaW9ubmEgR2xhemUsIFBoRCAoc2hlL2hl
cikNCg==
