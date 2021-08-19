Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0B3F237B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 01:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhHSXCk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 19:02:40 -0400
Received: from mail-bn1nam07on2078.outbound.protection.outlook.com ([40.107.212.78]:8166
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230340AbhHSXCk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 19:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu+rDjWASFplfJol/+TLI5NuV3zpMpiMLetfBzBXBSi3GHwb2tj4FLkZF6KzAYL2T2tWuJj1/rybU6S4z/bpqjFOplUf5ym1Zgh/4v2YffnRXgMkBZyGTOmFvCgLJFjV9dq4Pd/5NI30TuepeTkFgEl83zwfvkaIYWOVIkyTsKOqbgD/a47Sv+ulBStkAv5UlApUCFe2d2BBAcW6we6OnWZLkDf4oi1vXlVcm1UsAhuoQyNh74A6aosIUyzSrwylzyQk97vgF/eyBrtiGZxKq30g5GIZSsR6nKqrf/MnfjOcpq9ZJLmqWACe8rsS5kGpv5UclvV1yAq/tqNODqN9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7pzafQJYd6UO4xYiP+jS8VNc1T5EZZDhzasnu/Uac0=;
 b=LWTsNU/dejWteYnBFIk4PzwakzczGACjVAEqjtIwiyp5Ifn9hw8ekDm8UzVEYu2go2zm63iSMbww3O1E4OjAHUrP2MBC/+rHOP4lwI4JeqbjA1329YV2VDgpr9zLlnPZob8oZIa0sdA15xE7df4VAu25bXQ64+G5IzloYxnyOS7yVgyk21VKh5ukcRgXG3gyID0LLn68+a6VHGqkZ0gTfXIfB7Mz7b9G50TVeuAZeWLN35eGasMxBCvlocGPpSyYS8AmsB09Y1XtCw6fMQIoZFY3NovfA3nl6EJOTpDr0vUqylPKb9LwoEIsWVtcHrjWBCBrL2+0gFVRDuRA1EFPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7pzafQJYd6UO4xYiP+jS8VNc1T5EZZDhzasnu/Uac0=;
 b=LT0HQ7AZQodMz4pq9TP6V4zq01Dy6olExD+PVkqZ02eTBzl2A/SMB11NDJgHUfP9gjg/WDvxlShcE40x63csBg+JTJJ2xeJtUNmoOUhQH7otGfsjwQNJWLPA8QeFgg2yHgnjwBy71zA7XqDoXTbCfAgsbRpIi74ApzcEv59jja4=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 23:02:00 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 23:02:00 +0000
From:   "Kalra, Ashish" <Ashish.Kalra@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srutherford@google.com" <srutherford@google.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] KVM: x86: invert KVM_HYPERCALL to default to
 VMMCALL
Thread-Topic: [PATCH v3 2/5] KVM: x86: invert KVM_HYPERCALL to default to
 VMMCALL
Thread-Index: AQHXXJD5CtLkk/RscECEG/eoJd8DKKt7vSaAgAAXUv2AAA7U4g==
Date:   Thu, 19 Aug 2021 23:02:00 +0000
Message-ID: <ED74106C-ECBB-4FA1-83F9-49ED9FB35019@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <f45c503fad62c899473b5a6fd0f2085208d6dfaf.1623174621.git.ashish.kalra@amd.com>
 <YR7C56Yc+Qd256P6@google.com> <B184FCFE-BDC8-4124-B5B8-B271BA89CE06@amd.com>
In-Reply-To: <B184FCFE-BDC8-4124-B5B8-B271BA89CE06@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e52360-5ef7-476a-9164-08d963655a33
x-ms-traffictypediagnostic: SA0PR12MB4415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB441584AB58C36AAA792C0D3A8EC09@SA0PR12MB4415.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6BrwMKZoM3l772EF6ieOHqFckMeADmsPjXQKeYS+lAKYOkNNJTcHQ6TiX7R/7pYjSLAwaKk6qfIsYPmC666xAcTknjyW8W3ffnPPiG3KY+nFnD2PWaxlPUdYrJYrFhogHXDyMjAK03mRcHU5oIgYWzoqxSeicCoQsJ6+bOFIPLGZCV0H0gLxqpTl7iJ/jfIcuE1xId13P12RIq9VKFFOj7DAthyS0IjoaNBm8UB8IGbShY3mlQmDzGwbJ0d2d4+kNy+EqSlJcJs4KiHm/JVfbHAuvfxKQn83Pwbj5QfurHnSGRzfWNMYlICddZStHdcjM50hdaTIhY+M5ECldQL2B+9dpXSRjtXRPciV2acBhI+iW5k3UO4bcChjboEFr4+n7DEnpdQ1C3kQ2UBaNY59kKUdZrzskwroaPdOpT249kGZnG4UcLPCapOpTQOYDZsWPReD+rCHYNvsJDcMPNzfGM1mquUfK+jymx9gYfH5eAzNXvv2U32AG+sDyCB3plYcwStOziWrKQiJEubilGBPHLR0zwr7BiG1pF2OzpSIc1NqW6tuCJzX2D2LBUPo82MoDBccF5xqjqJpWr01NfxP9dseVyCSwmXALvJi9mvgzK6XPelA1879/iCh8bPzwM9d8OdTetIXJWO9AgloRkZvGCrD6N4LK7OTXAqOckG4Hse8DPgiiQmMpzhQ+gWG4pMjssQtmCEWgU3ZH/taIGyrwU49X7iZQTqPCwOfYqpi40kDqYqPTFwLP526mDVSFgm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(2906002)(54906003)(71200400001)(33656002)(64756008)(38070700005)(66446008)(91956017)(53546011)(66556008)(86362001)(186003)(316002)(6916009)(76116006)(5660300002)(6486002)(38100700002)(66476007)(36756003)(8936002)(122000001)(26005)(6512007)(8676002)(66946007)(7416002)(478600001)(2616005)(6506007)(83380400001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUx4bklObEpvVHlWdVFySXhabk9IVDZYNks0L05KSndKTlpkckpZd3pFWFRu?=
 =?utf-8?B?QmcwUUo1eDFOSlRNNGVhVFJhMlhOeUxtVTI4a24veXZJcFk4TFJPUWZrZ1Vx?=
 =?utf-8?B?ejVoVWRhOVZlblAzYU1GdXNZUk9qQXUvY2RoRnlUSVBTTzdHWGhiSk82K0cw?=
 =?utf-8?B?eDBIV3lEcStPOG1Qc3ZHUWd6R2FaNStEOWtRelJ0TXpXR3Y3eCtPNytMMFNC?=
 =?utf-8?B?YURiTVM3RGRYcFRBeWhkU3FGc3FzQkdJMjJJMlFqd0gvbUNSeTYrdHY3bTRK?=
 =?utf-8?B?SXFPWWRSSTlwTE1FRTM0bWxiSVpiaHhCSEsyNEMxaTRRSlFabldpQy92THVp?=
 =?utf-8?B?R0cxTVYzclNYc1FVT3ZHSysxUDlaK2R2UXFmT2pFME9WRnQyZWF6M0lrUVNh?=
 =?utf-8?B?a081clIwcjFyYTRlNGVWUXRjaVp0eVNsamZhWjlKRVFJRGpteXNSaTkwallk?=
 =?utf-8?B?WXBJVmJiMFpVM3Z0L0dReE50Q1hEeitMdWowMGJ6MmNXSnNrUUsxM25mK08z?=
 =?utf-8?B?b050Y3ZTUGwyVms3RTRtemxkRWo1em8zZk9Fd01vN0pTT01qRlNtck1FQ0U4?=
 =?utf-8?B?ZWx0OHExdXFTeHFSRzNXV2c1YThtUDhHbEhOOFpSMkZYRFp5SE5YekpjbjNX?=
 =?utf-8?B?ZGpwMDMxbjI0Y3pVZFNlK1AzRzRaWFdMQWJQc0NlSlZhTmdHZE5Gcnk4VUMy?=
 =?utf-8?B?UUI2bVhtWWZpc0ZGVlRnZzllSU9sdnBJdHJINEU5RFVVeVJXejh0RDkrQWR2?=
 =?utf-8?B?bit0ZHZ6aEJLNlN2MHhmZ2xSMkRNS0UvTUM4em5MZ3phL2tLdjQyQ00xOVF5?=
 =?utf-8?B?QkFvZFhaUDRKTnZXMlBCL25rKzRqV2x6Q0FrYkNzYjQvV0t4bkFUVTBjVlhK?=
 =?utf-8?B?N1ZPU2YyVzhNZHo0ZzJ0T0ZkemhtTTdvNTFoL1BSUDZPa0xyZFk0bml1STRT?=
 =?utf-8?B?U3Y4SlN6UnduWTYzVGd3MVFhSUxYZnB5SDZnOEFBSlRnKzB5SmVqM3k5Rk1w?=
 =?utf-8?B?dm9yRXI2QkpxSnUvQWhlTE96eFd6Z0hPUEo3MDQzamZ1VFNRVkthWExDelhr?=
 =?utf-8?B?NTMwVFJhQWI0dmFVOTFhMWMycFFRVjViLzM3Vlg5M3FveDlRMDF6TzFEQ1lF?=
 =?utf-8?B?WjBCaXZsSTlVU0pGL3I1NW9kKy94dExNRnJ5dTNTWmxsaTlsRHhlR05OZC95?=
 =?utf-8?B?UnQ1M3RYbW11K250T2k3QVVvelRKM1ByTVgwbTFjcVhoYmZwQXd3MDB5c1o1?=
 =?utf-8?B?K3l3ak8xNWd6R2pkM1BwSnJ1Tmk4K0xiaUJySjlXQ3BSYTNQUXp0UURUamh1?=
 =?utf-8?B?Vi9tWk0rYy9xWHhaUVk4NmVBNUxoQjZ6MFNQL1FkRTB1U1FYRTZ6UjZMT1V4?=
 =?utf-8?B?enJaM0MyUjc0cWNURm9GVk5Dc3d6cGlycy9KdkZMaVJFMVEvOCtmaFBxbmFS?=
 =?utf-8?B?RVRZVnNLeFlVQkl5K1dTQ3NBcEcyRVJOOWpEU0VwL3VrVzhUelVVNTZwMGJz?=
 =?utf-8?B?aE90KzF4bnYwTDRURHdWTWU5ZnVVNHpUcHhKMm5xbVlWWkQ1d0JTMXMzZzkx?=
 =?utf-8?B?L2IyYW44eUs3UnlNVVpLeEc2NnpvN3JlakhUeUplOHZLK0QzOEw3WWQ0T1VQ?=
 =?utf-8?B?dzBmWUV0VFpPWGJkb09kN3loWkhVd3YyeHl6bEJhMk1GUzhEUzBTaU96bFB3?=
 =?utf-8?B?UCt2NFNVbG1QQ3ZGZDBSZmh3ZnNSRGMrTnBmTXJCblpaVGFubXhZZjFCUW5U?=
 =?utf-8?Q?ImDDNEfhza7Vuzba1IKlwwIq8m0A5kczB3j5scr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e52360-5ef7-476a-9164-08d963655a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 23:02:00.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wbkmne9YWhPCvmfBjyTX670dMS+jg1opB49gIiHmuCV2jUkwFcWuzT4Z3AFKgt5WI84vCTDFcvhDMeQhhsXOvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gQXVnIDIwLCAyMDIxLCBhdCAzOjM4IEFNLCBLYWxyYSwgQXNoaXNoIDxBc2hpc2gu
S2FscmFAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IZWxsbyBTZWFuLA0KPiANCj4+IE9uIEF1
ZyAyMCwgMjAyMSwgYXQgMjoxNSBBTSwgU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2ds
ZS5jb20+IHdyb3RlOg0KPj4gDQo+PiDvu79QcmVmZXJyZWQgc2hvcnRsb2cgcHJlZml4IGZvciBL
Vk0gZ3Vlc3QgY2hhbmdlcyBpcyAieDg2L2t2bSIuICAiS1ZNOiB4ODYiIGlzIGZvcg0KPj4gaG9z
dCBjaGFuZ2VzLg0KPj4gDQo+Pj4+IE9uIFR1ZSwgSnVuIDA4LCAyMDIxLCBBc2hpc2ggS2FscmEg
d3JvdGU6DQo+Pj4gRnJvbTogQXNoaXNoIEthbHJhIDxhc2hpc2gua2FscmFAYW1kLmNvbT4NCj4+
PiANCj4+PiBLVk0gaHlwZXJjYWxsIGZyYW1ld29yayByZWxpZXMgb24gYWx0ZXJuYXRpdmUgZnJh
bWV3b3JrIHRvIHBhdGNoIHRoZQ0KPj4+IFZNQ0FMTCAtPiBWTU1DQUxMIG9uIEFNRCBwbGF0Zm9y
bS4gSWYgYSBoeXBlcmNhbGwgaXMgbWFkZSBiZWZvcmUNCj4+PiBhcHBseV9hbHRlcm5hdGl2ZSgp
IGlzIGNhbGxlZCB0aGVuIGl0IGRlZmF1bHRzIHRvIFZNQ0FMTC4gVGhlIGFwcHJvYWNoDQo+Pj4g
d29ya3MgZmluZSBvbiBub24gU0VWIGd1ZXN0LiBBIFZNQ0FMTCB3b3VsZCBjYXVzZXMgI1VELCBh
bmQgaHlwZXJ2aXNvcg0KPj4+IHdpbGwgYmUgYWJsZSB0byBkZWNvZGUgdGhlIGluc3RydWN0aW9u
IGFuZCBkbyB0aGUgcmlnaHQgdGhpbmdzLiBCdXQNCj4+PiB3aGVuIFNFViBpcyBhY3RpdmUsIGd1
ZXN0IG1lbW9yeSBpcyBlbmNyeXB0ZWQgd2l0aCBndWVzdCBrZXkgYW5kDQo+Pj4gaHlwZXJ2aXNv
ciB3aWxsIG5vdCBiZSBhYmxlIHRvIGRlY29kZSB0aGUgaW5zdHJ1Y3Rpb24gYnl0ZXMuDQo+Pj4g
DQo+Pj4gU28gaW52ZXJ0IEtWTV9IWVBFUkNBTEwgYW5kIFg4Nl9GRUFUVVJFX1ZNTUNBTEwgdG8g
ZGVmYXVsdCB0byBWTU1DQUxMDQo+Pj4gYW5kIG9wdCBpbnRvIFZNQ0FMTC4NCj4+IA0KPj4gVGhl
IGNoYW5nZWxvZyBuZWVkcyB0byBleHBsYWluIHdoeSBTRVYgaHlwZXJjYWxscyBuZWVkIHRvIGJl
IG1hZGUgYmVmb3JlDQo+PiBhcHBseV9hbHRlcm5hdGl2ZSgpLCB3aHkgaXQncyBvayB0byBtYWtl
IEludGVsIENQVXMgdGFrZSAjVURzIG9uIHRoZSB1bmtub3duDQo+PiBWTU1DQUxMLCBhbmQgd2h5
IHRoaXMgaXMgbm90IGNyZWF0aW5nIHRoZSBzYW1lIGNvbnVuZHJ1bSBmb3IgVERYLg0KPiANCj4g
SSB0aGluayBpdCBtYWtlcyBtb3JlIHNlbnNlIHRvIHN0aWNrIHRvIHRoZSBvcmlnaW5hbCBhcHBy
b2FjaC9wYXRjaCwgaS5lLiwgaW50cm9kdWNpbmcgYSBuZXcgcHJpdmF0ZSBoeXBlcmNhbGwgaW50
ZXJmYWNlIGxpa2Uga3ZtX3Nldl9oeXBlcmNhbGwzKCkgYW5kIGxldCBlYXJseSBwYXJhdmlydHVh
bGl6ZWQga2VybmVsIGNvZGUgaW52b2tlIHRoaXMgcHJpdmF0ZSBoeXBlcmNhbGwgaW50ZXJmYWNl
IHdoZXJldmVyIHJlcXVpcmVkLg0KPiANCj4gVGhpcyBoZWxwcyBhdm9pZGluZyBJbnRlbCBDUFVz
IHRha2luZyB1bm5lY2Vzc2FyeSAjVURzIGFuZCBhbHNvIGF2b2lkIHVzaW5nIGhhY2tzIGFzIGJl
bG93Lg0KPiANCj4gVERYIGNvZGUgY2FuIGludHJvZHVjZSBzaW1pbGFyIHByaXZhdGUgaHlwZXJj
YWxsIGludGVyZmFjZSBmb3IgdGhlaXIgZWFybHkgcGFyYSB2aXJ0dWFsaXplZCBrZXJuZWwgY29k
ZSBpZiByZXF1aXJlZC4NCg0KQWN0dWFsbHksIGlmIHdlIGFyZSB1c2luZyB0aGlzIGt2bV9zZXZf
aHlwZXJjYWxsMygpIGFuZCBub3QgbW9kaWZ5aW5nIEtWTV9IWVBFUkNBTEwoKSB0aGVuIEludGVs
IENQVXMgYXZvaWQgdW5uZWNlc3NhcnkgI1VEcyBhbmQgVERYIGNvZGUgZG9lcyBub3QgbmVlZCBh
bnkgbmV3IGludGVyZmFjZS4gT25seSBlYXJseSBBTUQvU0VWIHNwZWNpZmljIGNvZGUgd2lsbCB1
c2UgdGhpcyBrdm1fc2V2X2h5cGVyY2FsbDMoKSBpbnRlcmZhY2UuIFREWCBjb2RlIHdpbGwgYWx3
YXlzIHdvcmsgd2l0aCBLVk1fSFlQRVJDQUxMKCkuDQoNClRoYW5rcywNCkFzaGlzaA0KDQo+IA0K
Pj4gDQo+PiBBY3R1YWxseSwgSSBkb24ndCB0aGluayBtYWtpbmcgSW50ZWwgQ1BVcyB0YWtlICNV
RHMgaXMgYWNjZXB0YWJsZS4gIFRoaXMgcGF0Y2gNCj4+IGJyZWFrcyBMaW51eCBvbiB1cHN0cmVh
bSBLVk0gb24gSW50ZWwgZHVlIGEgYnVnIGluIHVwc3RyZWFtIEtWTS4gIEtWTSBhdHRlbXB0cw0K
Pj4gdG8gcGF0Y2ggdGhlICJ3cm9uZyIgaHlwZXJjYWxsIHRvIHRoZSAicmlnaHQiIGh5cGVyY2Fs
bCwgYnV0IHN0dXBpZGx5IGRvZXMgc28NCj4+IHZpYSBhbiBlbXVsYXRlZCB3cml0ZS4gIEkuZS4g
S1ZNIGhvbm9ycyB0aGUgZ3Vlc3QgcGFnZSB0YWJsZSBwZXJtaXNzaW9ucyBhbmQNCj4+IGluamVj
dHMgYSAhV1JJVEFCTEUgI1BGIG9uIHRoZSBWTU1DQUxMIFJJUCBpZiB0aGUga2VybmVsIGNvZGUg
aXMgbWFwcGVkIFJYLg0KPj4gDQo+PiBJbiBvdGhlciB3b3JkcywgdHJ1c3RpbmcgdGhlIFZNTSB0
byBub3Qgc2NyZXcgdXAgdGhlICNVRCBpcyBhIGJhZCBpZGVhLiAgVGhpcyBhbHNvDQo+PiBtYWtl
cyBkb2N1bWVudGluZyB0aGUgIndoeSBkb2VzIFNFViBuZWVkIHN1cGVyIGVhcmx5IGh5cGVyY2Fs
bHMiIGV4dHJhIGltcG9ydGFudC4NCj4+IA0KPiANCj4gTWFrZXMgc2Vuc2UuDQo+IA0KPiBUaGFu
a3MsDQo+IEFzaGlzaA0KPiANCj4+IFRoaXMgcGF0Y2ggZG9lc24ndCB3b3JrIGJlY2F1c2UgWDg2
X0ZFQVRVUkVfVk1DQUxMIGlzIGEgc3ludGhldGljIGZsYWcgYW5kIGlzDQo+PiBvbmx5IHNldCBi
eSBWTXdhcmUgcGFyYXZpcnQgY29kZSwgd2hpY2ggaXMgd2h5IHRoZSBwYXRjaGluZyBkb2Vzbid0
IGhhcHBlbiBhcw0KPj4gd291bGQgYmUgZXhwZWN0ZWQuICBUaGUgb2J2aW91cyBzb2x1dGlvbiB3
b3VsZCBiZSB0byBtYW51YWxseSBzZXQgWDg2X0ZFQVRVUkVfVk1DQUxMDQo+PiB3aGVyZSBhcHBy
b3ByaWF0ZSwgYnV0IGdpdmVuIHRoYXQgZGVmYXVsdGluZyB0byBWTUNBTEwgaGFzIHdvcmtlZCBm
b3IgeWVhcnMsDQo+PiBkZWZhdWx0aW5nIHRvIFZNTUNBTEwgbWFrZXMgbWUgbmVydm91cywgZS5n
LiBldmVuIGlmIHdlIHNwbGF0dGVyIFg4Nl9GRUFUVVJFX1ZNQ0FMTA0KPj4gaW50byBJbnRlbCwg
Q2VudGF1ciwgYW5kIFpoYW94aW4sIHRoZXJlJ3MgYSBwb3NzaWJpbGl0eSB3ZSdsbCBicmVhayBl
eGlzdGluZyBWTXMNCj4+IHRoYXQgcnVuIG9uIGh5cGVydmlzb3JzIHRoYXQgZG8gc29tZXRoaW5n
IHdlaXJkIHdpdGggdGhlIHZlbmRvciBzdHJpbmcuDQo+PiANCj4+IFJhdGhlciB0aGFuIGxvb2sg
Zm9yIFg4Nl9GRUFUVVJFX1ZNQ0FMTCwgSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBoYXZlIHRo
aXMgYmUNCj4+IGEgInB1cmUiIGludmVyc2lvbiwgaS5lLiBwYXRjaCBpbiBWTUNBTEwgaWYgVk1N
Q0FMTCBpcyBub3Qgc3VwcG9ydGVkLCBhcyBvcHBvc2VkDQo+PiB0byBwYXRjaGluZyBpbiBWTUNB
TEwgaWYgVk1DQUxMIGlzIHN1cHByb3RlZC4NCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5o
DQo+PiBpbmRleCA2OTI5OTg3OGIyMDAuLjYxNjQxZTY5Y2ZkYSAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2t2bV9wYXJhLmgNCj4+IEBAIC0xNyw3ICsxNyw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBr
dm1fY2hlY2tfYW5kX2NsZWFyX2d1ZXN0X3BhdXNlZCh2b2lkKQ0KPj4gI2VuZGlmIC8qIENPTkZJ
R19LVk1fR1VFU1QgKi8NCj4+IA0KPj4gI2RlZmluZSBLVk1fSFlQRVJDQUxMIFwNCj4+IC0gICAg
ICAgIEFMVEVSTkFUSVZFKCJ2bWNhbGwiLCAidm1tY2FsbCIsIFg4Nl9GRUFUVVJFX1ZNTUNBTEwp
DQo+PiArICAgICAgICBBTFRFUk5BVElWRSgidm1tY2FsbCIsICJ2bWNhbGwiLCBBTFRfTk9UKFg4
Nl9GRUFUVVJFX1ZNTUNBTEwpKQ0KPj4gDQo+PiAvKiBGb3IgS1ZNIGh5cGVyY2FsbHMsIGEgdGhy
ZWUtYnl0ZSBzZXF1ZW5jZSBvZiBlaXRoZXIgdGhlIHZtY2FsbCBvciB0aGUgdm1tY2FsbA0KPj4g
KiBpbnN0cnVjdGlvbi4gIFRoZSBoeXBlcnZpc29yIG1heSByZXBsYWNlIGl0IHdpdGggc29tZXRo
aW5nIGVsc2UgYnV0IG9ubHkgdGhlDQo+PiANCj4+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+DQo+Pj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0K
Pj4+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPj4+IENjOiBQYW9sbyBC
b256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPj4+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9A
OGJ5dGVzLm9yZz4NCj4+PiBDYzogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KPj4+IENj
OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KPj4+IENjOiB4ODZAa2Vy
bmVsLm9yZw0KPj4+IENjOiBrdm1Admdlci5rZXJuZWwub3JnDQo+Pj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4+IA0KPj4gU3VnZ2VzdGVkLWJ5OiBTZWFuIENocmlzdG9waGVy
c29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEJyaWplc2gg
U2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCj4+IA0KPj4gSXMgQnJpamVzaCB0aGUgYXV0
aG9yPyAgQ28tZGV2ZWxvcGVkLWJ5IGZvciBhIG9uZS1saW5lIGNoYW5nZSB3b3VsZCBiZSBvZGQu
Li4NCj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEFzaGlzaCBLYWxyYSA8YXNoaXNoLmthbHJhQGFt
ZC5jb20+DQo+Pj4gLS0tDQo+Pj4gYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX3BhcmEuaCB8IDIg
Ky0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+
PiANCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX3BhcmEuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmgNCj4+PiBpbmRleCA2OTI5OTg3OGIyMDAuLjAy
NjdiZWJiMGIwZiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFy
YS5oDQo+Pj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX3BhcmEuaA0KPj4+IEBAIC0x
Nyw3ICsxNyw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBrdm1fY2hlY2tfYW5kX2NsZWFyX2d1ZXN0
X3BhdXNlZCh2b2lkKQ0KPj4+ICNlbmRpZiAvKiBDT05GSUdfS1ZNX0dVRVNUICovDQo+Pj4gDQo+
Pj4gI2RlZmluZSBLVk1fSFlQRVJDQUxMIFwNCj4+PiAtICAgICAgICBBTFRFUk5BVElWRSgidm1j
YWxsIiwgInZtbWNhbGwiLCBYODZfRkVBVFVSRV9WTU1DQUxMKQ0KPj4+ICsgICAgQUxURVJOQVRJ
VkUoInZtbWNhbGwiLCAidm1jYWxsIiwgWDg2X0ZFQVRVUkVfVk1DQUxMKQ0KPj4+IA0KPj4+IC8q
IEZvciBLVk0gaHlwZXJjYWxscywgYSB0aHJlZS1ieXRlIHNlcXVlbmNlIG9mIGVpdGhlciB0aGUg
dm1jYWxsIG9yIHRoZSB2bW1jYWxsDQo+Pj4gKiBpbnN0cnVjdGlvbi4gIFRoZSBoeXBlcnZpc29y
IG1heSByZXBsYWNlIGl0IHdpdGggc29tZXRoaW5nIGVsc2UgYnV0IG9ubHkgdGhlDQo+Pj4gLS0g
DQo+Pj4gMi4xNy4xDQo+Pj4gDQo=
