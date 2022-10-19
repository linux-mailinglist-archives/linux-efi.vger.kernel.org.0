Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78DB603B01
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJSH7G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJSH7E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:59:04 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 00:59:03 PDT
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEF4D806;
        Wed, 19 Oct 2022 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1666166343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I/567++LgG3XKtUzU08sV7JWzCvjjXiIAzXZOw58+Hs=;
  b=I/v65j4FhtY9GC9KgPB6RIcSO8+AbPX8uJlqTcc5DDkdw7+BRIdW8iog
   q3XoE/T9CXye+cMKs4eKY2z+W9ESpXDRQqSot92E3yC87f5fBlxJINS02
   IB/gSRtEtPe+MxzvQ3y8pZsUV0ZjglYJQf0aPsWbq6c752vofTWBqQi9q
   0=;
X-IronPort-RemoteIP: 104.47.74.41
X-IronPort-MID: 83039436
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:8t+UVqjq20zR5eiO8820zM4NX161eBAKZh0ujC45NGQN5FlHY01je
 htvDGzQOf2KNGameIwgbIzgoBkBv5HTy9NlHVA5qihgHyMb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrSCYkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U4HUMja4mtC5AVmPKET5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUJ38
 KQYFTUVUhLdh8uXmLa6UuVDu+12eaEHPKtH0p1h5RfwKK56BLrlE+DN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvDSVkFUZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXOgANlDSObmnhJsqHG4hVYhWF4WbBj4huam0B6iSshcJ
 mVBr0LCqoB3riRHVOLVVRSjo3malh8HQ8BZCKsg9Wmlw7DY6S6aC3ICQzoHb8Yp3Oc8XRQj0
 l6EmYOvCTEHmLmIVXW19bqOqz62fy8PIgcqaSYaQE0F6t/4rYcbihPJU8YlEaipg9mzEjb1q
 xiPrS4xgJ0JgMIL3rn99lfC6xq0q4TEVBwd5wPZRGup4wp1Iom/aOSA9Vff/d5ELYCEUkOGu
 nkU3cSThMgNDZaXkzeNQeEKApmo/O6fOSaam0MHN50//HG14XmhcItMyDV/Ilp5LssfZT7vb
 wnUoww5zI8DYlOpYLVxbob3DN4lpYDkFNL4RrXZYNtmfJd8bkmE8TtoaErW2Hri+GAokKciK
 dKYfNyqAHIyF6tq1ny1Sv0b3LttwToxrUvXRJbm31Gn2KCSaXiUT7gtLlSDdKY64bmCrQGT9
 MxQX/Zm0D1aWez6JyPRoYgaKAhWKWBhXcyv7ctKauSEPwxqXnk7DOPcyq8gfIojmLlJkuDP/
 Te2XUowJEfDuEAr4D6iMhhLAI4Dl74lxZ7nFUTA5WqV5kU=
IronPort-HdrOrdr: A9a23:vmtMnq1UnPMprTclT4xtOAqjBRFyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4uxpOMG7MBDhHQYc2/hdAV7QZnidhILOFvAv0WKC+UyrJ8SazIJgPM
 hbAs9D4bHLbGSSyPyKmDVQcOxQj+VvkprY49s2pk0FJW4FV0gj1XYBNu/xKDwVeOAyP+tcKH
 Pq3Lsjm9PPQxQqR/X+IkNAc/nIptXNmp6jSwUBHQQb5A6Hii7twKLmEjCDty1uEg9n8PMHyy
 zoggb57qKsv7WQ0RnHzVLe6JxQhZ/I1sZDPsqRkcIYQw+cyjpAJb4RGIFqjgpF5d1H22xa1O
 UkZC1QePib3kmhPF1dZyGdnTUIngxeskMKgmXo/EcL6faJOA7STfAxy76xOyGplXbJ9rtHod
 129nPcuJxNARzamiPho9DOShFxj0Kx5WEviOgJkhVkIMIjgZJq3PsiFXluYeE9NTO/7JpiHP
 hlDcna6voTeVSGb2rBtm0qxNC3RHw8EhqPX0BH46WuonNrtWE8y1FdyN0Un38G+p54Q55Y5/
 7cOqAtkL1VVMcZYa90Ge9ES8qqDW7GRw7KLQupUBzaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CES19cvX5aQTObNSRP5uw/zvngehTPYd228LAu23FQgMyNeJP7dSueVVspj8ys5/0CH8yzYY
 fABK5r
X-IronPort-AV: E=Sophos;i="5.95,195,1661832000"; 
   d="scan'208";a="83039436"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2022 03:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0B3JhHlEZkITLlre+d/z67yD4/8e0pQG9HUzkmOgImW3zciukPNripCUT7dGPFu0+STCeZfyn9dhiQ+Yg8Hc8/2aiacECfG/x0Ut00Uhwl3rUlwe3GoaDEq86bF79PHS3sXhgfrJog6miQpKqXKOtwypbnY0/AnYfbhndk7SNb03u82QRZY4JxlK9U3r1UF3jyT0s1wbacRM7t3WqH1kIaS902YcjfoWivVqeh2ssVWYfvPCP91DvGKbuenrx0xlTVrb+/Cx7Iro9T8M4Ayfv9PWvvYhk7gLDubtKQhSCX0HucY9KJTbmoOSx8WoAY08ia1/sqPhqG5t8yOR4UU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/567++LgG3XKtUzU08sV7JWzCvjjXiIAzXZOw58+Hs=;
 b=axCP4vIO6ahqXqfSZJehXCdQVijGVoryP1OaGOQrejETXmMcGGLxRZGaImMcXWTGZpKPqq8Od97ZEvR3rTkt4TBigvq4HSJEY+E0i5jxOkJtAGnbK4yz4yG6HvEq1GFRDNMukw+EGBv5RISNlbyEiNVt+reCSA1BNJ+1tnnGYlelxqWUb6UAjHAWmz1DKdMHl14jeHHEZJbvhEPmh8xNkA11XSw9SrQHSEpdK5HV7htIQLbpnxFb+b3gadaJtkKnrkYUGU0BC0v/VZCEgRr2nk5mQXhtAyTpxep+j0FI3ndQlsHyehMQv9FZOaggu/OMXhQr1gjfTKk2Hw6877i7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/567++LgG3XKtUzU08sV7JWzCvjjXiIAzXZOw58+Hs=;
 b=DoQ2I160Jv/imKgg/7BtYcQB0pEuDJZivsp1Pxi4FofjkTGSxXJ70QO9XiFitdHvKsjiZsirC4UNobUmsZpfzusN9O0b9MmZA3J5ENid0RWU+lTyc096J8CZgP1jiKpHY85LQIrX9CQXPtpVA7a30JUq1yATx9GTWr30L38IfQo=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB6621.namprd03.prod.outlook.com (2603:10b6:510:b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 07:57:57 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 07:57:57 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Evgeniy Baskov <baskov@ispras.ru>, Ard Biesheuvel <ardb@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
Thread-Index: AQHY41CKr442H/SWZESOFZ70/2CWgK4VWl0A
Date:   Wed, 19 Oct 2022 07:57:57 +0000
Message-ID: <58b9f97c-36d5-6b9e-5336-14ad3a09ad18@citrix.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <2fd61a79a1e6885dc47ec826b62a936dd88a0a16.1662459668.git.baskov@ispras.ru>
In-Reply-To: <2fd61a79a1e6885dc47ec826b62a936dd88a0a16.1662459668.git.baskov@ispras.ru>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|PH0PR03MB6621:EE_
x-ms-office365-filtering-correlation-id: dcb449d2-1fb2-4175-accc-08dab1a7a2be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMbUrzkXF/f04VrjL50rri3rZJpoLyErXyM+iSIStVq2O+5IvijWOFZZQyscLr6tCG7zDw1foV0TueXLUNLxpu1tb0ayMyYnc3kLPx4ED/ziHGuHJbEWApuCykTKy8B2iRwg9wBpk94gLJ1skdmLt0tlxzUS3Bp2mUlWXHj+FkCsgbfaMfn3Ca5TOmSm1FOLtrBbpNgEueJTvb9Cixay/S6XxDfrv0o1tobEbaegEF6c3bipGD+WljzuJAAYpMjsrQ8BtjG7vVFRef1dMYWJ1X+T9scEz14V4nxsHfIWO0FbYNtZGRRpMjgV/aZrNvVhs3KJsJVD4uVyIVhCW9MnzvW2KlQE9Vrp17bUjC5ixdhf6GWQezp6olgTvCLXpbp1Qnjd8CmPvlEeDMEubqozZY4n7G710bHf/1lDam4Xze5OI1ww5jLoJ5hmX46DihjEOOt+RRo+7NmCR1s5IeRAsnmRCaAAqS3vhTaZQfWUH5N69/H7cIfubplPqd8mxjQDWpByspKZUFzixSPUx57sip+yhdCQF1/2n0EaW9QbNq1GHS50s6U8qquS1OxU5X8x98fGkUJp+95CQ/ma8w99RNHu3wkq2q1AwS/NZHs5aSd39/me6QC3LuAyZc/z+H2yj97ojvftmQYIi+zZ8AXc+KQ4D1uQUP1tNqqPrOynbNQF4Dz0zyk0kZS4m6ChOX/3DX0fjN3tMXYQNGALALYPrOaObk3iwZXsbdV1nHfhQFoYS3laH92fqnJFAh9s/reV1f4jWDqUV5Njet492fpVjNbSAu1GU5PN/6Kg/QXGtuLKyKoBbKoed06+w38mESkpT2YUUEvf0W/hg6W1Jj6dHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(82960400001)(478600001)(6486002)(71200400001)(38100700002)(110136005)(54906003)(8936002)(6512007)(316002)(31696002)(91956017)(53546011)(41300700001)(26005)(186003)(122000001)(6506007)(36756003)(4326008)(38070700005)(4744005)(2616005)(2906002)(5660300002)(64756008)(107886003)(66476007)(66556008)(66946007)(66446008)(8676002)(86362001)(7416002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VURaV1A5REUxREoxYllZc0gzZTJXOFplaURFV1lkbE5Da3lzT0hKMTQ0KzlE?=
 =?utf-8?B?MUx1bk02bVZ4RHlWbFNpQnhOV3JyckpVL1dpMm5CQUdOcmhKRlBXaklDUXNG?=
 =?utf-8?B?R0VUbXZ4UGc1UnF4dHR0c3phNGhtNjlPaHBtQzB3dHlYYlVCM0J2YlVUK05H?=
 =?utf-8?B?MWNYNDV6TzJ3VDJsK3VIMGYxcUNaeUpoclVOMHlVSDZuazJOK2ZKRkwxdHEw?=
 =?utf-8?B?TXpmUU5lN2lRRUxicmpaZ3Qva0d6dVliUWZRNnpJQ2ljSFNVQlRWc29yMTVL?=
 =?utf-8?B?akF5Ty9yUWgzUWR6YUVGemo3UEdDOG5rbWhRSzdrYnhzMGttSWp1UkdtWXRS?=
 =?utf-8?B?VmNJU0N2WktKVzZKeXlwZU16Yk5QYy9wNkxuRm5mQkZMTkh4SG8xYkhMblBn?=
 =?utf-8?B?TTByNU1nS3ZtQmM3YnlqQVFjblFjSnNNcmMrd0tMMERvOHd3SE9wZ2hDUHkv?=
 =?utf-8?B?aDdRamw5RGVzUklTY0lGay8vc2QxYUdTa3Z0bFZkbGpXamV5T1hIc1RlZWpY?=
 =?utf-8?B?WFgxSDdEMGpRbEhxOUdWOXNWcVN5TEE4Rkg3a1J1OGs3Q2xIeXVzM1NkZVBU?=
 =?utf-8?B?b2dPbW0ybms2V3lraU1rd240b25hcytnK295VzhvY3FudmgrZG9lVVNsUjFI?=
 =?utf-8?B?T3BheU11OTJtREx1bFVIVmJEVkgwTkJ3MGJEL2pWN2lxTlUyRWpyWFVwVkVY?=
 =?utf-8?B?YUIvRFMxd2oyNG9lMmtLOW1vTVZNTEwvcThZTDZDN2tjSXl4ZHNMT1I5U3Rr?=
 =?utf-8?B?VjY1Um8yNUErUW1Rd3p0dnpxQ3JFRzhlTGZiSW5YcURuTXZJdkI3SFFLd2h5?=
 =?utf-8?B?dVZMT3RNeUxPS2I3OXc3Q1pxUEEzYjNIVFNwczdDMkpWb1VHNzFhVTNod1pj?=
 =?utf-8?B?R25qbVZwWThiV245Sko5ZjBlMHZiTFc0cC80dFNpVzBTOGpmbmJRT0loVUh5?=
 =?utf-8?B?NVRFaWcxVXA5N2hLOXowaGxNYWpsdWFtOWlKNlFWWUVKU2FPTTYwS0VVblNN?=
 =?utf-8?B?M0ZnSlVETG5ZbUM1TlpMZ0kxSHJUbkFOVkw1Vmovbjh5T28yVzIwK2VjeUhO?=
 =?utf-8?B?SlNVOEh2bHdSQjNBZXN1a2tUdXFOMTVFb1pZYkdyNXMvNzJhYXN2TlRjVnUy?=
 =?utf-8?B?V21LWkd1NUFOUVBtM0Z6clZvVW5hcHovekorQ3VTTGJqZ3VEcExKU0RTVVJn?=
 =?utf-8?B?enY3K25jaHNkTkI1L3NGWTdrYWNHeC9qbGFrWGVGS2FwSE1RcEtrcTZUbWt1?=
 =?utf-8?B?K21ETE5EaVBnYURtNW5GZ1E0ckxqb29nN0p1ZDlETDFtZWQrM1BCeEJCcUgy?=
 =?utf-8?B?aWFoQUJiNkRLVXZpZ1ZpR1pjejI5R0RKVERtbkQyZHM2TmhJaVNOSFZPY0Yr?=
 =?utf-8?B?QnJrUmc0NmJlWUUrc3JocHJJWmtkUDJ3OGF5eUtFSEVJUzg5SGE2a1NONTEy?=
 =?utf-8?B?aSttcGIwSzJQd1U1N3o1ZGtqeGIwRkVBQ3FIQVc5UG5xZjRhRWFnWHg4aDhT?=
 =?utf-8?B?OXRUd1pwVHJlNzVPL2t1bnRieWNETFN2QVZNdktKOUlraGdQWEtLVVg5TWVG?=
 =?utf-8?B?bERLUkFjRVVoR2tvNk1SVi9VTHFSR3JvNFJGeXZ1amhJaXk4T1lOUlRpWHJw?=
 =?utf-8?B?cGNCV05GNTVpTjhnTFpDdlpINUJXV3BwNG4xRjdPMHRDSjMxSmY2MzBTZ2Z3?=
 =?utf-8?B?UkEvWFNwUXhjVXpXV2tKbUdjb3lpbDJZZVFUQVFyRFRqdmFRMklIQ2Erakxt?=
 =?utf-8?B?QWRUbStYc2dzVk9NWE5OSFZaQU9PV2RVdjVXY0thSnlxRjZveGd4ckVoZFEy?=
 =?utf-8?B?NzFvTDBIRFpJS2syRUpoaEtOWVJ3MFB1UUl0SlppVExrS3dqaDVtNU8vK0ZN?=
 =?utf-8?B?cHhEVENBWHFHWFBTeS8zMFoxVWsxOVlZNFZKVk9wRGMwbFM2TTVXSXBobHN3?=
 =?utf-8?B?MjlBckRQVmpvYm9qZEt3Vm5Ca0FIWlF4UzRuY2EzYnJqcXNpVnVXeDE1bk8r?=
 =?utf-8?B?aEZiZGh5Q2VsSG1BS2gwQ1J4N3JUazR2bi9LS3d4TW41Y09oNFhZa0NLd0tS?=
 =?utf-8?B?eHVKUWVFbzhTRWJpS2RFa3duMktRaUZXY2kvalhoRE83ekJPb3NQc0dnVXR6?=
 =?utf-8?Q?L2b4be+MG70EB2r93ki3UnBg+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5111D063CAEB54C8FC992F771CFC78A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb449d2-1fb2-4175-accc-08dab1a7a2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 07:57:57.3937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIX/edMNOQKz6B/c4E0xzNO2QGKAyYCBHSXaGD22/GvQUdeEH1Y77M1WwzFR4kMgD2/OEkQIClJUM0itD8OObSteWUNvamVh5yvR71eBMow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6621
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gMDYvMDkvMjAyMiAxMTo0MSwgRXZnZW5peSBCYXNrb3Ygd3JvdGU6DQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5TIGIvYXJjaC94ODYvYm9vdC9jb21w
cmVzc2VkL2hlYWRfNjQuUw0KPiBpbmRleCA1MjczMzY3MjgzYjcuLjg4OWNhNzE3NmFhNyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2hlYWRfNjQuUw0KPiArKysgYi9h
cmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5TDQo+IEBAIC02MDIsNiArNjAzLDI4IEBA
IFNZTV9GVU5DX1NUQVJUX0xPQ0FMX05PQUxJR04oLkxyZWxvY2F0ZWQpDQo+ICAJam1wCSolcmF4
DQo+ICBTWU1fRlVOQ19FTkQoLkxyZWxvY2F0ZWQpDQo+ICANCj4gK1NZTV9GVU5DX1NUQVJUX0xP
Q0FMX05PQUxJR04oc3RhcnR1cDMyX2VuYWJsZV9ueF9pZl9zdXBwb3J0ZWQpDQo+ICsJcHVzaHEJ
JXJieA0KPiArDQo+ICsJbGVhcQloYXNfbngoJXJpcCksICVyY3gNCj4gKw0KPiArCW1vdgkkMHg4
MDAwMDAwMSwgJWVheA0KPiArCWNwdWlkDQo+ICsJYnRsCSQyMCwgJWVkeA0KDQpidGwgJChYODZf
RkVBVFVSRV9OWCAmIDMxKSwgJWVkeA0KDQpCdXQgYWxzbyBuZWVkIHRvIGNoZWNrIGZvciB0aGUg
YXZhaWxhYmlsaXR5IG9mIHRoZSBleHRlbmRlZCBsZWFmIGluIHRoZQ0KZmlyc3QgcGxhY2UuDQoN
Cj4gKwlqbmMJLkxub254DQo+ICsNCj4gKwltb3ZsCSQxLCAoJXJjeCkNCg0KWW91ciBwb2ludGVy
IGhhcyBiZWVuIGNsb2JiZXJlZCB3aXRoIHNvbWUgZmVhdHVyZSBmbGFncy4NCg0KbW92bCAkMSwg
aGFzX254KCVyaXApDQoNCndpbGwgd29yayBmaW5lIHdpdGhvdXQgbmVlZGluZyB0aGUgaW50ZXJt
ZWRpYXJ5IGxlYS4NCg0KfkFuZHJldw0K
