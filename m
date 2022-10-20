Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D31606640
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJTQvO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTQvL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 12:51:11 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38004159A25;
        Thu, 20 Oct 2022 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1666284667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HoclpAS6meJHJIAwilAVKrCp2hWEi0qJWDnwxNjZl+8=;
  b=iJrnreAN4g9ZRjRJkDPe5mRY6RgF2IDhlivQlqAokc1ZA+srYXryAbnM
   uuuExkU9nNICirVzJeHQOaxasP6uv5UBjuS/D1R/DgXgEYZoxZ0e9/wHO
   Fo9fYk5OUjXj7/L+PtkYMm7vyWVdI19rrL2UVLWWrPH6x2BDrNmLVIByq
   Q=;
X-IronPort-RemoteIP: 104.47.70.101
X-IronPort-MID: 85706991
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:J/AtSKLzOWn/z2SvFE+RypUlxSXFcZb7ZxGr2PjKsXjdYENS1mYFx
 jROUGGOaPiLMGejft4kPI6z9R9Tv5HXnIRkSFdlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/vOHtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwRgiAo
 rsemeWGULOe82MyYz98B56r8ks15q2q4mtA5DTSWNgQ1LPgvyhNZH4gDfnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFU47Nfh7TKyXmc5aKVeS8oiM+t5uK23CukhcawKcjXMfwXG8M49m/c3Kd/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTGCFcpqHLWyKE/hlgMK05FdxG+cBwXERRz
 MY3byoPMhC6ltupwpvuH4GAhux7RCXqFKU2nyg4iBv/UrMhS52FRLjW79hF2jt2ntpJAfvVe
 8seb3xocQjEZBpMfFwQDfrSns/x3iW5L2Ie9wrT/PJui4TQ5FUZPLzFGdzZYNGVA+5SmV6Vv
 Dnu9GXlGBAKcteYzFJp91r827CXw3KqAer+EpWJ+sZL20St9FYtIxcMZFC6uaiQgxehDoc3x
 0s8v3BGQbIJ3EaiVdr6QTW5u2aetwVaQcc4O+Qg5AulyafO5QudQG8eQVZpYsQOvcs3SDp6k
 FOE9/vtGCBomL6YU3SQ8vGTtzzaESQcM2JEZSYCVgYDy93ippwjyBPJUttnVqWyi7XdHDD2z
 DeitiUyh7wPy8UM0s2T5V3bjii+jpnPQBQ86gjeUiSi9AwRTJKqY5yA7Vnd8OpaK4CYXh+Ns
 RAsmMiZ9ucVDZCJkzKlQf4VBriyoeyYWBXYn1UqB4Mm9Tmm51anfIZN8C1zP1toNMlCfiXmC
 GfD6V1555JJOnauK6htbOqZD8Us0LilGNrkfu7bY8AIYZVrcgKDuiZ0aia422HrjVhpkqwlP
 5qfWdijAGxcCql9yjeyAeAH3tcDwiE42HOWRZnhwxmh0LyRTGCaRK1DM1aUaO09qqSer23oH
 813MsKLz1BVVrL4ayyOqYoLdwlSdD48GIz8rNFReqibOA16FWo9CvjXh7Q8Z4himKcTneDNl
 p2gZnJlJJPErSWvAW23hrpLMdsDgb4XQaoHABER
IronPort-HdrOrdr: A9a23:80blDqpCSkEgGGr2+N5XjhIaV5uIL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ku90KnpewK+yXbsibNhcItKLzOWwldAS7sSobcKogeQUREWk9Qw6U
 4OSdkYNDSdNzlHZIPBkXGF+rUbsZa6GcKT9IHjJh5WJGkEBZ2IrT0JczpzeXcGJjWucKBJcK
 Z0kfA3wgZIF052Uu2LQl0+G8TTrdzCk5zrJTQcAQQ81QWIhTS0rJbnDhmxxH4lInJy6IZn1V
 KAvx3y562lvf3+4ATbzXXv45Nfn8ak4sdfBfaLltMeJlzX+0aVjcVaKv6/VQIO0aSSAWUR4Z
 3xStAbToNOAkbqDyOISN3Wqk/dOXgVmibfIBSj8AbeSITCNU4H4ox69Mxkm1LimjQdVJsX6t
 M140uJ85VQFh/OhyL7+pzBUAxrjFO9pT44nfcUlGE3a/pWVFZ9l/1pwKpuKuZ3IAvqrIQ8VO
 V+BsDV4/hbNVuccnDCp2FqhNihRG46EBuKSlUL/pX96UkcoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBcG3FmvOSxTRN3/6GyWuKIgXf3bW75Ln6rQ84++nPJQO0ZspgZ
 zEFEhVsGYjEnieffFmHKc7hywlbF/NLggFkPsulqSRkoeMNIbDIGmEVE0kldemrrEWHtDbMs
 zDSq5rPw==
X-IronPort-AV: E=Sophos;i="5.95,199,1661832000"; 
   d="scan'208";a="85706991"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 12:51:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI6Z6Ck4cfUYWGbGK5AArW0wU1lizR17ogaQFBtWCLnU7AJIouUdoChnBPFrM1z4ctcuUp9l9qKqcfUu2aGsVxxY5iaH61pU6DVwDrMAkUui/rZDcOjAV52IzuKG2+2q3MfwhQ/CXTOW2egi9SrHmlvHBaG09C7J3cR4Pnlj3VUL37QEnfYN3W/SacGFxgHIVXpaaBg6WRLSrOKE/gqtAVpByww0KAA3ckccTXCa/NJHdBFgvgXEMF5wezey42b8THzW0wlyQQJVTTk6cBZEz5sI/NZsidG8mrpyX/BnrVHsLRXUWLUM83UktSeBwy3y5phofvsZL5ph0ho/xeI4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoclpAS6meJHJIAwilAVKrCp2hWEi0qJWDnwxNjZl+8=;
 b=PmfvLjgkqSElp5ypFGB4ESayhwiplssMAg/PaKGHG8jGMDWA5IbDoz5f1e+KgIdo0RIdIyIhHgXuqr8pcmGUvUx6J9g+1uU63/UbBUK6TGBMNoM7qvP7bnBxkHbunRGXxAZ/WZj5DFkX6QReXBF/50vvaNVCa9qmxuNTB2fJIQmpYq5B5ezYYZ7VmB5H8oFDKppXHLIDlKoUCx6RnCbhpTVdaQFw6pPghUJoqYo/T0Dwixp4XAsbKZo3fstZ7sGULRsLio1+2eHev0q4HByajtpqr49/46D6LypXIj30mkRSNvuUvubyjyCAEECx6q8pcpgT2XlAWwbEQ4xW2JAXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoclpAS6meJHJIAwilAVKrCp2hWEi0qJWDnwxNjZl+8=;
 b=Ei7bucqqDw4HDvTYyKfHDCAnAIqUpRV9PeL+q7g3LxQsUny+nJ+iJeRE6mNUzdUdzwvwq5CWqxIYrIwE2RK+KhkWAZlvfbg9vFjc6IiPSA6mTi/y45/PRpS+akcYHaqnEbUMeRG9b+DsiyabqvlTS54vT52ftlRquW3MjqpBZKg=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO3PR03MB6759.namprd03.prod.outlook.com (2603:10b6:303:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 16:51:00 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 16:51:00 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
CC:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 06/16] x86/boot: Setup memory protection for bzImage code
Thread-Topic: [PATCH 06/16] x86/boot: Setup memory protection for bzImage code
Thread-Index: AQHY41CKr442H/SWZESOFZ70/2CWgK4VWl0AgAHvOwCAADgJgA==
Date:   Thu, 20 Oct 2022 16:51:00 +0000
Message-ID: <0201e64a-1aa8-3e84-a973-4a572c1df3e4@citrix.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <2fd61a79a1e6885dc47ec826b62a936dd88a0a16.1662459668.git.baskov@ispras.ru>
 <58b9f97c-36d5-6b9e-5336-14ad3a09ad18@citrix.com>
 <ed8c18e42870da96afc9ce1222816189@ispras.ru>
In-Reply-To: <ed8c18e42870da96afc9ce1222816189@ispras.ru>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|CO3PR03MB6759:EE_
x-ms-office365-filtering-correlation-id: 517d583f-5686-4071-cc37-08dab2bb445d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6FYFdLJrl4fcgXE9hoqQtqpNZer7ba6chjQ9bAicdYb6G7uXlB5FSTkRbxt/dDGgRwgk4DeXU8lsUgx4gtn4+TFD8EWCDPrAI6OzXPjoU41VgMSJ+SG6sOgxXHvVVuDJtwphBfU7as2d4n5fCH9UhD1vPBZE00pf5GArVbUYX+rmz1RV4x9AJM1WBVp1JkemANXj62xi1FgnyAINnZ2V7TahONvaifBwtIeGdBi98VwwE8yJ2w5Ripg8O+CKvb5zQIzVRsWYgr1WXmDTEJy4DbGMoQQpEfBenm/rqzEx/wceS5qi8ok6+CAO3ZipYLTOrG9zkR3JPoT+4ex4zMnSLTBH9S7PN+AjDsZcuqRIiS09Saoxpt83blU9uUBr9JNY7o/5U5qnVniKVdwspjH4bmUFr7VAaqPm/OcESUPp7wJjVBX62gns5gIKEwl5LNdWiN95aIq5nXGp3m0qJzfJ6ZeMTITN4TIo6esH8teB76bNMr0cYYQtbbKCnsMycnARI2e+Al8qDTppk2T4oScG1sHrBlu8WTiH40tzRPVjbiNTfqszzIOC0JFYGmD5nawEWhFwxDIcVu2rpT/UgSDHHw6f1bAJHbx5VxV31jivc3xRmy1H7tbRFnw59VFnjHaLLbw/LU82jJLQlKPkQ/6GnqHhRb2c5/5LNJRC3Ol74YGVTPyqJXHHru61PoWJ7mleNLG0kmeNt34iHQDqXQKCuH10od5vCXn0mA+flIcTKJPnmKRHgFoKEhbHgQN5dQ5Kw0ZdNhn7Qx+Dsl1QJevv4YDWiqukQOQu9EQCnW3TNBFo8sBOn5xl9v/4kxDhrex3YboCbGNpGIAOVfmNgW2KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(186003)(82960400001)(2906002)(71200400001)(6486002)(4001150100001)(122000001)(478600001)(38070700005)(2616005)(66476007)(66446008)(66946007)(66556008)(64756008)(8676002)(4326008)(6916009)(38100700002)(54906003)(86362001)(6512007)(76116006)(91956017)(8936002)(31686004)(107886003)(36756003)(26005)(31696002)(41300700001)(6506007)(316002)(5660300002)(53546011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEM0WGFmbWZrSDUvK2tjdVUxTU1pYzNiNHdEOW54blVOYWdKVUQ5ZDFkZ2M1?=
 =?utf-8?B?SGhGWEJTeTZEWFJlTXpaZ1c2Y2oxL0hma3NCTHBXKzVja0piL3lGa3l0K3ha?=
 =?utf-8?B?T0VIWlhrV2VKMmVyY2IyNDFIMCtCWVhlOWVXcm5Wc2xyY040cDQ3MXhSMWR5?=
 =?utf-8?B?RmJYcGZYZGNzclhFSldTUEpjWFlSbnFNVCtncTIwcjZoUVVYT1JkcmNSU2xk?=
 =?utf-8?B?dzM3QWsvdXZKc2VQejRmVDhKTU1XV3RzdEFDcCtnT1VEY1BzR2pWeG1RUjUw?=
 =?utf-8?B?N0VmY1VnTlI1eTFVRTJnZExHOGE0Rk84OHo1eHZQRTYvdURvL3I1RXdIMGpW?=
 =?utf-8?B?NUtvckRidW9icXZqTnhEVWVsZmc3WmJReEltRHBxNXpxcW5ET1VGOVdXMDdO?=
 =?utf-8?B?bWNzajJERUZBMnBJOXpIaE1CS2VmRUtHTUxXT1FyKzFLNWJZOTRaS1VEVHRI?=
 =?utf-8?B?a0ZwMlhHbmZsbld1U3g4QTc0T2FtRklZaHpJOEFkVm5LN2RJaEtsKzJ3aXFW?=
 =?utf-8?B?MVdQRmZFOHpHcjhYSWtnaFkray92eWdGbE9SMEFMWlNwV0pyRm5iUjJtNTRp?=
 =?utf-8?B?T3BYV0VBT1RVVTkvcytWZFh6RGFDUG1JUnNqZzFCdGFqd0xSZ1JrMzBFU3NQ?=
 =?utf-8?B?R1lib3NNSE90c25mZTRaOE01UGlxaVg4UU1HV0l4QnEzdEc3Q2JJbU0rcDI3?=
 =?utf-8?B?LzdVOEpzc1Z3WmZhc0JqaEdzeW9FTWdNTjlMZWl3WEVSZFJpemlMS0dXU0lk?=
 =?utf-8?B?d3dIb2xJeXE4MXlzS0tNc21way9kcG1LVERrU0xPekl0SGo3MjI2bGhYRC9u?=
 =?utf-8?B?djhsZGh2UndhNDh3VnFNakt4NThIMFdzSmtva0RNRUxRZHRPZmJvWmFRVGR0?=
 =?utf-8?B?dUVQZGJwdnFwQTlOckorSGVNdVpEVzA3dVM0Umh1amtKVmFTaDA4QzJ4T0xy?=
 =?utf-8?B?WU56VnkwRnUxalgwNDFFUFNpRFBTYzRCajdKMDBPRFpYdjlURXpNN242MzNP?=
 =?utf-8?B?MGlXYmFpeXR3NGFIZk8vbit4RXNsR0FhU0o1c1hZQW5oUmxyNFo0eFBFR2Iv?=
 =?utf-8?B?ckVSV21aOTRtWGh1Q0U3QXcxUWliNFkvUVc1aTdJaVpORTVtMEc2c0VnUnBL?=
 =?utf-8?B?QXdmaXJ4R21lMkN3QUJqTjhJcGVUeitSd2ZYVDBxQUxJczZGWC93ZGVsM2xL?=
 =?utf-8?B?VXRmbVJrWjNhSi9zZVZiZWhEQzV0WmpkcXhLU28vcWNsWjhLK1FObWRrQUpI?=
 =?utf-8?B?aVNPYkpBckNhYTk1UEZrcEVieWczSXdyZzV1bjQ5ZWVTL25ieTNSd0Y0NlV4?=
 =?utf-8?B?anBxZ1BzZkpnQmNRMUoySGhrUkw2OUhnZ2hBcmx0bFFvZ1ZZRWtJTlFtbnZk?=
 =?utf-8?B?R0ZidzQ1YkNLaTIvTGVGeE1pREZDVzFnMmpGUjRhVTRwT1ExWHYvT2tFSjI3?=
 =?utf-8?B?TllHcDY4U2orUk5NZE5iQmdiTy9mbS9LU2w3WE9UdVJCRzlkaVZPbndyZGZN?=
 =?utf-8?B?U3hUNTJaYkxqRnhibE53V0l3VW43cm1VelJhaXVjaWZqYitDTVhrSmxKTTVy?=
 =?utf-8?B?aDZnaE1TUk9uZk5sWmpnbUxlNW85OVB0K2JiU0YzUnBTYlVoRFBpa2tjVTdi?=
 =?utf-8?B?T0w5T0s3VHdSZ2dQV0diNXBRY0wzL0hCbit4QnoxSlBrUWk1MHNqaGVUQ2xz?=
 =?utf-8?B?YjViYXJtQkFxYkJIa2xMSG1rckdVaVhuY1Z3djNBeFY2V1l3QTJLZzF1RGZR?=
 =?utf-8?B?WDYwS0JvVnAvQ2tPY3FPOC85WElNSW9FS1p4UTkrWVEvVzEyOWFDeTEzTGhG?=
 =?utf-8?B?bm96QUt6WnNabFA3cWxsdlFydUJ1bXBXendUVStlbnZBWndzQk9OWHZtQmp5?=
 =?utf-8?B?Q041OTMxeXloTExKalYyUE0rQkJWSktka3dSSzNNQ1RzcS83OVp4Qko0MEJp?=
 =?utf-8?B?RDRERFFxaWVUS1diazdtN3dPRXBOeXEwS2hnMHhRbGswS2JpVUp4ZXBWdXZu?=
 =?utf-8?B?b3FnSG81bER5d1hHVm1DUVc1MkJ1T25SbnNKRFM1UEtzeFJnYnRWT243dEJt?=
 =?utf-8?B?U3ZIODMydnIvUEpUUDZCaW1HWHhIbjQ5ZkV2cmluRjA5d1UxY1FxRDJpektP?=
 =?utf-8?B?TDZrNnBiTk4xMVczRmNZL3VOOXd4Z1RyWTZZTDBRN0YrNWlRRzhjVWVzSnlC?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13F2525C5D559E4EA7A94C8C631FBA09@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517d583f-5686-4071-cc37-08dab2bb445d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 16:51:00.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heImUpedPIF+3ruWz3gavhQdXc1H472f2e4IS87EVMMCoGYtV5f2tRtpfhobqtHUnZ38gYsBIuD13B3z7rMqiwJPT8PGQEaBXtPXaGoES8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6759
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gMjAvMTAvMjAyMiAxNDozMCwgRXZnZW5peSBCYXNrb3Ygd3JvdGU6DQo+IE9uIDIwMjItMTAt
MTkgMTA6NTcsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAwNi8wOS8yMDIyIDExOjQxLCBF
dmdlbml5IEJhc2tvdiB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvYm9vdC9jb21w
cmVzc2VkL2hlYWRfNjQuUw0KPj4+IGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2hlYWRfNjQu
Uw0KPj4+IGluZGV4IDUyNzMzNjcyODNiNy4uODg5Y2E3MTc2YWE3IDEwMDY0NA0KPj4+IC0tLSBh
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9oZWFkXzY0LlMNCj4+PiArKysgYi9hcmNoL3g4Ni9i
b290L2NvbXByZXNzZWQvaGVhZF82NC5TDQo+Pj4gQEAgLTYwMiw2ICs2MDMsMjggQEAgU1lNX0ZV
TkNfU1RBUlRfTE9DQUxfTk9BTElHTiguTHJlbG9jYXRlZCkNCj4+PiDCoMKgwqDCoCBqbXDCoMKg
wqAgKiVyYXgNCj4+PiDCoFNZTV9GVU5DX0VORCguTHJlbG9jYXRlZCkNCj4+Pg0KPj4+ICtTWU1f
RlVOQ19TVEFSVF9MT0NBTF9OT0FMSUdOKHN0YXJ0dXAzMl9lbmFibGVfbnhfaWZfc3VwcG9ydGVk
KQ0KPj4+ICvCoMKgwqAgcHVzaHHCoMKgwqAgJXJieA0KPj4+ICsNCj4+PiArwqDCoMKgIGxlYXHC
oMKgwqAgaGFzX254KCVyaXApLCAlcmN4DQo+Pj4gKw0KPj4+ICvCoMKgwqAgbW92wqDCoMKgICQw
eDgwMDAwMDAxLCAlZWF4DQo+Pj4gK8KgwqDCoCBjcHVpZA0KPj4+ICvCoMKgwqAgYnRswqDCoMKg
ICQyMCwgJWVkeA0KPj4NCj4+IGJ0bCAkKFg4Nl9GRUFUVVJFX05YICYgMzEpLCAlZWR4DQo+Pg0K
Pj4gQnV0IGFsc28gbmVlZCB0byBjaGVjayBmb3IgdGhlIGF2YWlsYWJpbGl0eSBvZiB0aGUgZXh0
ZW5kZWQgbGVhZiBpbiB0aGUNCj4+IGZpcnN0IHBsYWNlLg0KPg0KPiBZZXMsIHRoYW5rIHlvdSBm
b3Igc3VnZ2VzdGlvbiwgdGhhdCBsb29rcyBtb3JlIHJlYWRhYmxlLiBJIHdpbGwNCj4gYWxzbyBh
ZGQgdGhlIGxlYWYgbm9kZSBjaGVjay4gSXMgdGhlcmUgYW55IHByb2Nlc3NvciB0aG91Z2ggdGhh
dA0KPiBzdXBwb3J0cyBsb25nIG1vZGUgYW5kIGRvZXMgbm90IHN1cHBvcnQgMHg4MDAwMDAwMSBs
ZWFmIG5vZGU/DQoNCk5vLCBnb29kIHBvaW50LsKgIFRoZSBMb25nIE1vZGUgZmVhdHVyZSBiaXQg
aXMgaW4gdGhpcyBsZWFmIHRvby4NCg0KfkFuZHJldw0K
