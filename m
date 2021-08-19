Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7D3F22A8
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhHSWJf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 18:09:35 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:62436
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229605AbhHSWJe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 18:09:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc0Ehw70lJovJyzQXMP2+T3nwb9TdRrlEiFQRGza4lqNOz+9HGObaKYLYpU9zcbszJJfLNevYGYo/uP4L47djlfy7XN3QZYYTbNuq6NrcvYqxrcNGmkdU2s3KL/a18Q0VybibKQoe6vAbQGzej9khyO3nN4NwB0jsGkd2j4/hNlzzddpO0OsQXGAzwfXvoho3MYW4rxJGuaBZrKEEIR21ExyPZ5VnTbfRYi0nJPiCifxRgwLmUMAPfDBiata1UienjOkDp7MFh2yu09XU/kc2mBQmWCqshRoyAkCikXaD2LZPrXQfFlMEr1Q7ceLbbm4iXNHiARTM5sstJHRiS28mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy5SA3jxdDT3wxI1mk8isqVJ8/ZJq1dVwu6pS8TwQ38=;
 b=ZTufDHutUhcji/A9tD7J+ZcY8r/AmIwkXbrEtjFvwIeORJYONP5RPElJfmmdUE39J1kxnWq+IlsQ7nMYuk4BNgWJmUpHqR6U/za47lGUaWKJONeFHYAFDBXeHGY+3Af4Z6B4yRQZsVYJ+xe5WJ4lha+zhIOisIYKfBZ6WSWxghDO18ZpYFOwvQJvhNjgau5bF8qaIsSGakbaF3Jl6DiQJqkPUHrn0bFDc707ZYFKPjAK8nsQOTWzufU9+HKYLUI8XfaMRLqUxwV7ztSOUD2Cwv0abt+sYzwe9jX9Pd+AYAFFj74MxhHJxo6S34dO8m48BpEs3k0DizI8tqNEpzBqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy5SA3jxdDT3wxI1mk8isqVJ8/ZJq1dVwu6pS8TwQ38=;
 b=p/rAadkvJ9VGwktUVLOcdfGdq8s3UpBZ0ZBdvFup8p+wu+sOEe4WNueVhxEHwsRimDXuxKQ2ZJQKelyC9CroSs/FfAdFxnkzOkaKunqdU1mt7A9omoxa6ZJiJqwAzOTKcjYnLBWd6E+VCo/QV+L3qju+/fi/mZQv1RVCgPABdjo=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 22:08:55 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 22:08:55 +0000
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
Thread-Index: AQHXXJD5CtLkk/RscECEG/eoJd8DKKt7vSaAgAAXUv0=
Date:   Thu, 19 Aug 2021 22:08:55 +0000
Message-ID: <B184FCFE-BDC8-4124-B5B8-B271BA89CE06@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <f45c503fad62c899473b5a6fd0f2085208d6dfaf.1623174621.git.ashish.kalra@amd.com>
 <YR7C56Yc+Qd256P6@google.com>
In-Reply-To: <YR7C56Yc+Qd256P6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4916fa2a-7ad9-47ad-afae-08d9635defc1
x-ms-traffictypediagnostic: SA0PR12MB4432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4432C5BAABE0ABA841C4931C8EC09@SA0PR12MB4432.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7y0nCPEOutg0ZmwCI5ie3YgRP01XY+5Zsxfhdz2PAUqvdd4VSdtEYL78JcZ54nZ2ZCbQhPEqtTLNBidnQdimft3uhPjpwrTTwsB3t99S+4S38LxhysI1QTj2jA0ew94sH2CCXvaq6tk+W+WljDVp33XA31vAvPg5HRGaZT7FlegXlJ99ZgQcH7ue5eacq4DzAu1DAjE5LrGDLKnFm6PKfYCN8pX+AvK7yLGQsYDxwqBGVTn/DyJyfNSpYIT1WuQ0rjruVvqZPpsLlk9MckROG3X6RB+m5Y/3uKKlmZIIDoRUQpM7x1urjTFX08gPFHqkF6MO2+7kusc0y+A9FRDIpIcBjQUrm9V1tiYAXqQbLcs3dsLCkFJECOX9PKFgET+Y7AvKej9DXYd98VeV0HowGu9e28/zTQ+x3fdWVAKCh75dMzRXh2Vmeqo/9XG+13x5Vt+Ttz2lHpa2Q5x4pWcSDMo8lRwGLumKtPMSQ+HJEwLkgi2OH5vlgQHKwVk7QU6C5fTxflE6TXuD5Xon7aPUxLS1R9d/q0uAGTk6vozp6PrWOZmQgXFUg8g1Uj/9X0trpSwFIXRurFbA2b5Rn5xBi+ztbxWLO5PpjCZSG1tH9tBwCt3zLytYwzhS2ssdpXw0ycQFS4/aCGr+rpqGLcUPBncWjUFeUYl82E3VMOh+mw1DR1UHJ+spqgVoojCrYFi7NBWDX6hldyDlFhYjKevgnBUJGrbL1Me7rpxgmWnvH68=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(2616005)(76116006)(5660300002)(38100700002)(6512007)(186003)(478600001)(6506007)(53546011)(26005)(7416002)(91956017)(316002)(4326008)(83380400001)(6486002)(86362001)(66946007)(6916009)(66476007)(64756008)(2906002)(66556008)(66446008)(36756003)(54906003)(8936002)(8676002)(122000001)(38070700005)(33656002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWhOZ2ticlNvTnJBdjBnTHFIN2dXOGZjaElldFhrWWFxZlRpS1hDMTNEc1FY?=
 =?utf-8?B?YTJOK1Y2TWFZK0dheUhDTy9RT0M1MGhha3MzczRtMnNsSWNRL0pDam5CTnJm?=
 =?utf-8?B?a29Ba3R1Smp5Y3JqUjJOYzJNREJhREFuVFo5Tnd3VUdQVE4yTzlSZkVHQWRh?=
 =?utf-8?B?MktXVDBwRnk2SlFRNXZtajY1dEhHU0ZOM0xlZFJFZlp2WWZaZE1PZHA5aTVy?=
 =?utf-8?B?dmt6clBCTHpzWFMxV1hOZ0EzSXlnQlFVUi9Kb3cxcTdlb1F6bXc2Qnp2dk9G?=
 =?utf-8?B?UW5lL29UTi9OYXpobHVsdkFCb2R6N2R3dVdYejV0NW5JOXU5bDgwK2FWTEV0?=
 =?utf-8?B?SGVXOWMxNlp0Z0VaYUhDODNFTVVPWHF6WW94dlZrdmxjeWhPazE1Mkdwa0FS?=
 =?utf-8?B?T0dsS292bVZ2RjcyQkFlSWpENkY1elVCL3l1Qno5UFR6NE1WZThWMXpNU083?=
 =?utf-8?B?ZWRxdEhpSzMxa3VjRjltODdXVG1WWE1iMS9tOUc3TGJUaFYxUWpSOHdRY0F1?=
 =?utf-8?B?S05VS2xCcEdXeG8vZk5PZmdnQmhVeFAwN25RWmhoWXAyU21FbHo0M1lwQS9Z?=
 =?utf-8?B?ZFh2TGc2NEkvWk1RelRwM1FKQndGOFB6QUhrYiswcUFJSGx3VG44NVpKSWR0?=
 =?utf-8?B?ZXZFckJXb1FjRmZvaUwzbXFVNittQkZPbEdGZGNEWjZmSkovWWFHdEU1RU05?=
 =?utf-8?B?ZFBTUlA0LzVscnYwT0V6bUZJWVZtNDZMVUFHZFBaaUNIVzBWT08wVjFSVkI1?=
 =?utf-8?B?VXE0QUQ2WGNxaFNDakc1Q2d2Z3pWNVVyTXZ4SEZ6SmtvaVd0YUJCYXNpRitw?=
 =?utf-8?B?TFk2eGxnYTl2VjFyRlplaFVZNU9UaGRaRnBHSGNOaGF6YThlM3QrTnNlR1Fy?=
 =?utf-8?B?QmlGTW14N0g1M0Z2d3RHL3Q1eHAybHR0cjFIYlhZWDNyN2VnRWhBZnROaG5w?=
 =?utf-8?B?TWN6dUhsampHZFp5L3ZRalVzZ3gvWFRXTHlIUnQ4aC9DR3RWV0ZMTjh2MWtX?=
 =?utf-8?B?aVVaQWpRckUxcmJEVG1RZXZhbTcvdVZ2YTF1Z25aZk1LaE91YXpjOU84cHJl?=
 =?utf-8?B?bkZuZmkvRXhHWG9qR3EyUVFxZjd6ZStVK1gzYmJPWlBrclV6Tm5IaEsyNTg2?=
 =?utf-8?B?S0Vycm0yaHdQMDJYR05ZOGhSVitPWS91d1BDaUNWRHJZdC9VVHE2ZWpJQ0RN?=
 =?utf-8?B?a05zTEpxdjdmSHEzUy9BYzUvYWkxaFhodlEweGJBak1iUnV4NzV1ZUZmd2pX?=
 =?utf-8?B?aG5ZY09od2ZJelZCdWQwQmpvRDdsQk9WdnI4bHNSOGRnNWREZUQwNWdBSmw2?=
 =?utf-8?B?MzUwbmdSRTJpczB1TzNnY3dWT0sxYnJKZUYycVZIUTR3VWdwcU80Z2U5WTdl?=
 =?utf-8?B?Qlo4MEwwVjFkU1R0TUtBdDdwYTY2Z1Z6MmFGdk1NUWx3S2hwYWxtT251K3M0?=
 =?utf-8?B?UTZvS1FTdndqUVhJaFc3aDU4K25SbC9pZ216NytHVTY2MDVFK2EzRVlzVHAw?=
 =?utf-8?B?WjNYMDJ3US9OZE83bmhpbFBrOFhSblhIdjVkRFI0OHNGTElIK3Joc2xGeDBD?=
 =?utf-8?B?YzB5R0RHcnBYMk1zcklDNERVT2FOdytRRzVGM2xxMzFUOXhCRmRaWDJIeHpQ?=
 =?utf-8?B?cDRxWXNrUXFVdGJoYTFaQ2ZIb0JkbS9jYi9vNXpJeUJac1B5Vm9QdjRBZEEz?=
 =?utf-8?B?OUlwY0ljcTJGa3AyR0haYjhwSmU3S09oSDRBUUZZaWZHNjJoNVlsL1REeVdz?=
 =?utf-8?Q?tcDSHSc9H78DlKrks9agiEYDhAbmPS3zSJdp1jJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4916fa2a-7ad9-47ad-afae-08d9635defc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 22:08:55.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDbnvOPymIt1Vq0AkGdA+ZpuriSjZE24olSznVXRFafSY3EDu5J28kasZErb/tXu4rt9VRHsyO+OvaOaBYatMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGVsbG8gU2VhbiwNCg0KPiBPbiBBdWcgMjAsIDIwMjEsIGF0IDI6MTUgQU0sIFNlYW4gQ2hyaXN0
b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+IO+7v1ByZWZlcnJlZCBz
aG9ydGxvZyBwcmVmaXggZm9yIEtWTSBndWVzdCBjaGFuZ2VzIGlzICJ4ODYva3ZtIi4gICJLVk06
IHg4NiIgaXMgZm9yDQo+IGhvc3QgY2hhbmdlcy4NCj4gDQo+PiBPbiBUdWUsIEp1biAwOCwgMjAy
MSwgQXNoaXNoIEthbHJhIHdyb3RlOg0KPj4gRnJvbTogQXNoaXNoIEthbHJhIDxhc2hpc2gua2Fs
cmFAYW1kLmNvbT4NCj4+IA0KPj4gS1ZNIGh5cGVyY2FsbCBmcmFtZXdvcmsgcmVsaWVzIG9uIGFs
dGVybmF0aXZlIGZyYW1ld29yayB0byBwYXRjaCB0aGUNCj4+IFZNQ0FMTCAtPiBWTU1DQUxMIG9u
IEFNRCBwbGF0Zm9ybS4gSWYgYSBoeXBlcmNhbGwgaXMgbWFkZSBiZWZvcmUNCj4+IGFwcGx5X2Fs
dGVybmF0aXZlKCkgaXMgY2FsbGVkIHRoZW4gaXQgZGVmYXVsdHMgdG8gVk1DQUxMLiBUaGUgYXBw
cm9hY2gNCj4+IHdvcmtzIGZpbmUgb24gbm9uIFNFViBndWVzdC4gQSBWTUNBTEwgd291bGQgY2F1
c2VzICNVRCwgYW5kIGh5cGVydmlzb3INCj4+IHdpbGwgYmUgYWJsZSB0byBkZWNvZGUgdGhlIGlu
c3RydWN0aW9uIGFuZCBkbyB0aGUgcmlnaHQgdGhpbmdzLiBCdXQNCj4+IHdoZW4gU0VWIGlzIGFj
dGl2ZSwgZ3Vlc3QgbWVtb3J5IGlzIGVuY3J5cHRlZCB3aXRoIGd1ZXN0IGtleSBhbmQNCj4+IGh5
cGVydmlzb3Igd2lsbCBub3QgYmUgYWJsZSB0byBkZWNvZGUgdGhlIGluc3RydWN0aW9uIGJ5dGVz
Lg0KPj4gDQo+PiBTbyBpbnZlcnQgS1ZNX0hZUEVSQ0FMTCBhbmQgWDg2X0ZFQVRVUkVfVk1NQ0FM
TCB0byBkZWZhdWx0IHRvIFZNTUNBTEwNCj4+IGFuZCBvcHQgaW50byBWTUNBTEwuDQo+IA0KPiBU
aGUgY2hhbmdlbG9nIG5lZWRzIHRvIGV4cGxhaW4gd2h5IFNFViBoeXBlcmNhbGxzIG5lZWQgdG8g
YmUgbWFkZSBiZWZvcmUNCj4gYXBwbHlfYWx0ZXJuYXRpdmUoKSwgd2h5IGl0J3Mgb2sgdG8gbWFr
ZSBJbnRlbCBDUFVzIHRha2UgI1VEcyBvbiB0aGUgdW5rbm93bg0KPiBWTU1DQUxMLCBhbmQgd2h5
IHRoaXMgaXMgbm90IGNyZWF0aW5nIHRoZSBzYW1lIGNvbnVuZHJ1bSBmb3IgVERYLg0KDQpJIHRo
aW5rIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gc3RpY2sgdG8gdGhlIG9yaWdpbmFsIGFwcHJvYWNo
L3BhdGNoLCBpLmUuLCBpbnRyb2R1Y2luZyBhIG5ldyBwcml2YXRlIGh5cGVyY2FsbCBpbnRlcmZh
Y2UgbGlrZSBrdm1fc2V2X2h5cGVyY2FsbDMoKSBhbmQgbGV0IGVhcmx5IHBhcmF2aXJ0dWFsaXpl
ZCBrZXJuZWwgY29kZSBpbnZva2UgdGhpcyBwcml2YXRlIGh5cGVyY2FsbCBpbnRlcmZhY2Ugd2hl
cmV2ZXIgcmVxdWlyZWQuDQoNClRoaXMgaGVscHMgYXZvaWRpbmcgSW50ZWwgQ1BVcyB0YWtpbmcg
dW5uZWNlc3NhcnkgI1VEcyBhbmQgYWxzbyBhdm9pZCB1c2luZyBoYWNrcyBhcyBiZWxvdy4NCg0K
VERYIGNvZGUgY2FuIGludHJvZHVjZSBzaW1pbGFyIHByaXZhdGUgaHlwZXJjYWxsIGludGVyZmFj
ZSBmb3IgdGhlaXIgZWFybHkgcGFyYSB2aXJ0dWFsaXplZCBrZXJuZWwgY29kZSBpZiByZXF1aXJl
ZC4NCg0KPiANCj4gQWN0dWFsbHksIEkgZG9uJ3QgdGhpbmsgbWFraW5nIEludGVsIENQVXMgdGFr
ZSAjVURzIGlzIGFjY2VwdGFibGUuICBUaGlzIHBhdGNoDQo+IGJyZWFrcyBMaW51eCBvbiB1cHN0
cmVhbSBLVk0gb24gSW50ZWwgZHVlIGEgYnVnIGluIHVwc3RyZWFtIEtWTS4gIEtWTSBhdHRlbXB0
cw0KPiB0byBwYXRjaCB0aGUgIndyb25nIiBoeXBlcmNhbGwgdG8gdGhlICJyaWdodCIgaHlwZXJj
YWxsLCBidXQgc3R1cGlkbHkgZG9lcyBzbw0KPiB2aWEgYW4gZW11bGF0ZWQgd3JpdGUuICBJLmUu
IEtWTSBob25vcnMgdGhlIGd1ZXN0IHBhZ2UgdGFibGUgcGVybWlzc2lvbnMgYW5kDQo+IGluamVj
dHMgYSAhV1JJVEFCTEUgI1BGIG9uIHRoZSBWTU1DQUxMIFJJUCBpZiB0aGUga2VybmVsIGNvZGUg
aXMgbWFwcGVkIFJYLg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHRydXN0aW5nIHRoZSBWTU0gdG8g
bm90IHNjcmV3IHVwIHRoZSAjVUQgaXMgYSBiYWQgaWRlYS4gIFRoaXMgYWxzbw0KPiBtYWtlcyBk
b2N1bWVudGluZyB0aGUgIndoeSBkb2VzIFNFViBuZWVkIHN1cGVyIGVhcmx5IGh5cGVyY2FsbHMi
IGV4dHJhIGltcG9ydGFudC4NCj4gDQoNCk1ha2VzIHNlbnNlLg0KDQpUaGFua3MsDQpBc2hpc2gN
Cg0KPiBUaGlzIHBhdGNoIGRvZXNuJ3Qgd29yayBiZWNhdXNlIFg4Nl9GRUFUVVJFX1ZNQ0FMTCBp
cyBhIHN5bnRoZXRpYyBmbGFnIGFuZCBpcw0KPiBvbmx5IHNldCBieSBWTXdhcmUgcGFyYXZpcnQg
Y29kZSwgd2hpY2ggaXMgd2h5IHRoZSBwYXRjaGluZyBkb2Vzbid0IGhhcHBlbiBhcw0KPiB3b3Vs
ZCBiZSBleHBlY3RlZC4gIFRoZSBvYnZpb3VzIHNvbHV0aW9uIHdvdWxkIGJlIHRvIG1hbnVhbGx5
IHNldCBYODZfRkVBVFVSRV9WTUNBTEwNCj4gd2hlcmUgYXBwcm9wcmlhdGUsIGJ1dCBnaXZlbiB0
aGF0IGRlZmF1bHRpbmcgdG8gVk1DQUxMIGhhcyB3b3JrZWQgZm9yIHllYXJzLA0KPiBkZWZhdWx0
aW5nIHRvIFZNTUNBTEwgbWFrZXMgbWUgbmVydm91cywgZS5nLiBldmVuIGlmIHdlIHNwbGF0dGVy
IFg4Nl9GRUFUVVJFX1ZNQ0FMTA0KPiBpbnRvIEludGVsLCBDZW50YXVyLCBhbmQgWmhhb3hpbiwg
dGhlcmUncyBhIHBvc3NpYmlsaXR5IHdlJ2xsIGJyZWFrIGV4aXN0aW5nIFZNcw0KPiB0aGF0IHJ1
biBvbiBoeXBlcnZpc29ycyB0aGF0IGRvIHNvbWV0aGluZyB3ZWlyZCB3aXRoIHRoZSB2ZW5kb3Ig
c3RyaW5nLg0KPiANCj4gUmF0aGVyIHRoYW4gbG9vayBmb3IgWDg2X0ZFQVRVUkVfVk1DQUxMLCBJ
IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGhhdmUgdGhpcyBiZQ0KPiBhICJwdXJlIiBpbnZlcnNp
b24sIGkuZS4gcGF0Y2ggaW4gVk1DQUxMIGlmIFZNTUNBTEwgaXMgbm90IHN1cHBvcnRlZCwgYXMg
b3Bwb3NlZA0KPiB0byBwYXRjaGluZyBpbiBWTUNBTEwgaWYgVk1DQUxMIGlzIHN1cHByb3RlZC4N
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20va3ZtX3BhcmEuaA0KPiBpbmRleCA2OTI5OTg3OGIyMDAuLjYxNjQx
ZTY5Y2ZkYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX3BhcmEuaA0K
PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oDQo+IEBAIC0xNyw3ICsxNyw3
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBrdm1fY2hlY2tfYW5kX2NsZWFyX2d1ZXN0X3BhdXNlZCh2
b2lkKQ0KPiAjZW5kaWYgLyogQ09ORklHX0tWTV9HVUVTVCAqLw0KPiANCj4gI2RlZmluZSBLVk1f
SFlQRVJDQUxMIFwNCj4gLSAgICAgICAgQUxURVJOQVRJVkUoInZtY2FsbCIsICJ2bW1jYWxsIiwg
WDg2X0ZFQVRVUkVfVk1NQ0FMTCkNCj4gKyAgICAgICAgQUxURVJOQVRJVkUoInZtbWNhbGwiLCAi
dm1jYWxsIiwgQUxUX05PVChYODZfRkVBVFVSRV9WTU1DQUxMKSkNCj4gDQo+IC8qIEZvciBLVk0g
aHlwZXJjYWxscywgYSB0aHJlZS1ieXRlIHNlcXVlbmNlIG9mIGVpdGhlciB0aGUgdm1jYWxsIG9y
IHRoZSB2bW1jYWxsDQo+ICAqIGluc3RydWN0aW9uLiAgVGhlIGh5cGVydmlzb3IgbWF5IHJlcGxh
Y2UgaXQgd2l0aCBzb21ldGhpbmcgZWxzZSBidXQgb25seSB0aGUNCj4gDQo+PiBDYzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdv
QHJlZGhhdC5jb20+DQo+PiBDYzogIkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCj4+
IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPj4gQ2M6IEpvZXJnIFJv
ZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KPj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5k
ZT4NCj4+IENjOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KPj4gQ2M6
IHg4NkBrZXJuZWwub3JnDQo+PiBDYzoga3ZtQHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IFN1Z2dlc3RlZC1ieTogU2VhbiBDaHJpc3Rv
cGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogQnJpamVz
aCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KPiANCj4gSXMgQnJpamVzaCB0aGUgYXV0
aG9yPyAgQ28tZGV2ZWxvcGVkLWJ5IGZvciBhIG9uZS1saW5lIGNoYW5nZSB3b3VsZCBiZSBvZGQu
Li4NCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggS2FscmEgPGFzaGlzaC5rYWxyYUBhbWQu
Y29tPg0KPj4gLS0tDQo+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oIHwgMiArLQ0K
Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20va3ZtX3BhcmEuaA0KPj4gaW5kZXggNjkyOTk4NzhiMjAwLi4wMjY3YmViYjBi
MGYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oDQo+PiAr
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oDQo+PiBAQCAtMTcsNyArMTcsNyBA
QCBzdGF0aWMgaW5saW5lIGJvb2wga3ZtX2NoZWNrX2FuZF9jbGVhcl9ndWVzdF9wYXVzZWQodm9p
ZCkNCj4+ICNlbmRpZiAvKiBDT05GSUdfS1ZNX0dVRVNUICovDQo+PiANCj4+ICNkZWZpbmUgS1ZN
X0hZUEVSQ0FMTCBcDQo+PiAtICAgICAgICBBTFRFUk5BVElWRSgidm1jYWxsIiwgInZtbWNhbGwi
LCBYODZfRkVBVFVSRV9WTU1DQUxMKQ0KPj4gKyAgICBBTFRFUk5BVElWRSgidm1tY2FsbCIsICJ2
bWNhbGwiLCBYODZfRkVBVFVSRV9WTUNBTEwpDQo+PiANCj4+IC8qIEZvciBLVk0gaHlwZXJjYWxs
cywgYSB0aHJlZS1ieXRlIHNlcXVlbmNlIG9mIGVpdGhlciB0aGUgdm1jYWxsIG9yIHRoZSB2bW1j
YWxsDQo+PiAgKiBpbnN0cnVjdGlvbi4gIFRoZSBoeXBlcnZpc29yIG1heSByZXBsYWNlIGl0IHdp
dGggc29tZXRoaW5nIGVsc2UgYnV0IG9ubHkgdGhlDQo+PiAtLSANCj4+IDIuMTcuMQ0KPj4gDQo=
