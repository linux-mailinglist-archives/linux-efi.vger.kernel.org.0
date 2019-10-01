Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05679C3570
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbfJANVA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 09:21:00 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:20634 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388212AbfJANVA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 09:21:00 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DJwUa014094;
        Tue, 1 Oct 2019 09:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=k61vTQ4ke+NdcKGdexR0iZ/4exS0UGCMH6YpAyTwZi8=;
 b=q9s1mU+c55g/FlMWDz/7WE8Qv24GhTE6yXatf3DlCqm5wcyciDAKZDdjH8uJfBi66NgY
 texsVvPvv6sLeLAcjvdILJ3iHejRtBSVqEsMkE5QQ7uZ69yJl7mVL+v1KwsSDHbOSO2p
 sEgm3miBOWDru0EE2B4OY3UJzjOo52qLIl9fugGEFAn7Ded5NauELca9qJZcLgtHkSIc
 fft/IqmSyytXhNsWfYlYJ2lCPnPLkGyNdpnXVoi4LjcPBIzw5Az6YzlrEHCcT6gHlO4l
 B/tp0aWoqRvbndgzVQEH+/bjyael79JYJy0oXqN3/LXEa3Q92IGJoEPBKApW8h9W2J8w 3g== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2ujwc82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 09:20:59 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DDYq0034165;
        Tue, 1 Oct 2019 09:20:58 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2vc0wmpyyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:20:58 -0400
X-LoopCount0: from 10.166.136.217
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="863062711"
From:   <Mario.Limonciello@dell.com>
To:     <ard.biesheuvel@linaro.org>, <geert@linux-m68k.org>
CC:     <Narendra.K@dell.com>, <linux-efi@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <tanxiaofei@huawei.com>
Subject: RE: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Topic: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVeDV6YfpW1TUI6U2T+6WFDn4TTadFzx8AgAACgICAAAqbgP//6Fvw
Date:   Tue, 1 Oct 2019 13:20:46 +0000
Message-ID: <8446d19dd197447a88eed580601f3c4c@AUSX13MPC105.AMER.DELL.COM>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org>
 <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
 <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
 <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T13:20:45.4531752Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_07:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010120
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010121
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJk
LmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxLCAyMDE5
IDQ6NDIgQU0NCj4gVG86IEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiBDYzogSywgTmFyZW5kcmE7IGxp
bnV4LWVmaTsgSW5nbyBNb2xuYXI7IFRob21hcyBHbGVpeG5lcjsgTGludXggS2VybmVsIE1haWxp
bmcgTGlzdDsNCj4gSmFtZXMgTW9yc2U7IExpbW9uY2llbGxvLCBNYXJpbzsgWGlhb2ZlaSBUYW4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIGVmaTogRXhwb3J0IFJ1bnRpbWUgQ29uZmlndXJh
dGlvbiBJbnRlcmZhY2UgdGFibGUgdG8gc3lzZnMNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxd
DQo+IA0KPiBPbiBUdWUsIDEgT2N0IDIwMTkgYXQgMTE6MDMsIEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnRAbGludXgtbTY4ay5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSGkgQXJkLA0KPiA+DQo+ID4g
T24gVHVlLCBPY3QgMSwgMjAxOSBhdCAxMDo1NCBBTSBBcmQgQmllc2hldXZlbA0KPiA+IDxhcmQu
Ymllc2hldXZlbEBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMSBPY3QgMjAxOSBh
dCAxMDo1MSwgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gd3Jv
dGU6DQo+ID4gPiA+IE9uIE1vbiwgQXVnIDEyLCAyMDE5IGF0IDU6MDcgUE0gQXJkIEJpZXNoZXV2
ZWwNCj4gPiA+ID4gPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+
IEZyb206IE5hcmVuZHJhIEsgPE5hcmVuZHJhLktAZGVsbC5jb20+DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBTeXN0ZW0gZmlybXdhcmUgYWR2ZXJ0aXNlcyB0aGUgYWRkcmVzcyBvZiB0aGUgJ1J1bnRp
bWUNCj4gPiA+ID4gPiBDb25maWd1cmF0aW9uIEludGVyZmFjZSB0YWJsZSB2ZXJzaW9uIDIgKFJD
STIpJyB2aWENCj4gPiA+ID4gPiBhbiBFRkkgQ29uZmlndXJhdGlvbiBUYWJsZSBlbnRyeS4gVGhp
cyBjb2RlIHJldHJpZXZlcyB0aGUgUkNJMg0KPiA+ID4gPiA+IHRhYmxlIGZyb20gdGhlIGFkZHJl
c3MgYW5kIGV4cG9ydHMgaXQgdG8gc3lzZnMgYXMgYSBiaW5hcnkNCj4gPiA+ID4gPiBhdHRyaWJ1
dGUgJ3JjaTInIHVuZGVyIC9zeXMvZmlybXdhcmUvZWZpL3RhYmxlcyBkaXJlY3RvcnkuDQo+ID4g
PiA+ID4gVGhlIGFwcHJvYWNoIGFkb3B0ZWQgaXMgc2ltaWxhciB0byB0aGUgYXR0cmlidXRlICdE
TUknIHVuZGVyDQo+ID4gPiA+ID4gL3N5cy9maXJtd2FyZS9kbWkvdGFibGVzLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gUkNJMiB0YWJsZSBjb250YWlucyBCSU9TIEhJSSBpbiBYTUwgZm9ybWF0IGFu
ZCBpcyB1c2VkIHRvIHBvcHVsYXRlDQo+ID4gPiA+ID4gQklPUyBzZXR1cCBwYWdlIGluIERlbGwg
RU1DIE9wZW5NYW5hZ2UgU2VydmVyIEFkbWluaXN0cmF0b3IgdG9vbC4NCj4gPiA+ID4gPiBUaGUg
QklPUyBzZXR1cCBwYWdlIGNvbnRhaW5zIEJJT1MgdG9rZW5zIHdoaWNoIGNhbiBiZSBjb25maWd1
cmVkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTmFyZW5kcmEgSyA8TmFy
ZW5kcmEuS0BkZWxsLmNvbT4NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVs
bG8gPG1hcmlvLmxpbW9uY2llbGxvQGRlbGwuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPg0KPiA+ID4gPg0KPiA+
ID4gPiBUaGFua3MsIHRoaXMgaXMgbm93IGNvbW1pdCAxYzVmZWNiNjEyNTVhYTEyICgiZWZpOiBF
eHBvcnQgUnVudGltZQ0KPiA+ID4gPiBDb25maWd1cmF0aW9uIEludGVyZmFjZSB0YWJsZSB0byBz
eXNmcyIpLg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL0tj
b25maWcNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9LY29uZmlnDQo+ID4g
PiA+ID4gQEAgLTE4MCw2ICsxODAsMTkgQEAgY29uZmlnIFJFU0VUX0FUVEFDS19NSVRJR0FUSU9O
DQo+ID4gPiA+ID4gICAgICAgICAgIGhhdmUgYmVlbiBldmljdGVkLCBzaW5jZSBvdGhlcndpc2Ug
aXQgd2lsbCB0cmlnZ2VyIGV2ZW4gb24gY2xlYW4NCj4gPiA+ID4gPiAgICAgICAgICAgcmVib290
cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICtjb25maWcgRUZJX1JDSTJfVEFCTEUNCj4gPiA+ID4g
PiArICAgICAgIGJvb2wgIkVGSSBSdW50aW1lIENvbmZpZ3VyYXRpb24gSW50ZXJmYWNlIFRhYmxl
IFZlcnNpb24gMiBTdXBwb3J0Ig0KPiA+ID4gPiA+ICsgICAgICAgaGVscA0KPiA+ID4gPiA+ICsg
ICAgICAgICBEaXNwbGF5cyB0aGUgY29udGVudCBvZiB0aGUgUnVudGltZSBDb25maWd1cmF0aW9u
IEludGVyZmFjZQ0KPiA+ID4gPiA+ICsgICAgICAgICBUYWJsZSB2ZXJzaW9uIDIgb24gRGVsbCBF
TUMgUG93ZXJFZGdlIHN5c3RlbXMgYXMgYSBiaW5hcnkNCj4gPiA+ID4gPiArICAgICAgICAgYXR0
cmlidXRlICdyY2kyJyB1bmRlciAvc3lzL2Zpcm13YXJlL2VmaS90YWJsZXMgZGlyZWN0b3J5Lg0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgUkNJMiB0YWJsZSBjb250YWlucyBCSU9T
IEhJSSBpbiBYTUwgZm9ybWF0IGFuZCBpcyB1c2VkIHRvIHBvcHVsYXRlDQo+ID4gPiA+ID4gKyAg
ICAgICAgIEJJT1Mgc2V0dXAgcGFnZSBpbiBEZWxsIEVNQyBPcGVuTWFuYWdlIFNlcnZlciBBZG1p
bmlzdHJhdG9yIHRvb2wuDQo+ID4gPiA+ID4gKyAgICAgICAgIFRoZSBCSU9TIHNldHVwIHBhZ2Ug
Y29udGFpbnMgQklPUyB0b2tlbnMgd2hpY2ggY2FuIGJlIGNvbmZpZ3VyZWQuDQo+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ICsgICAgICAgICBTYXkgWSBoZXJlIGZvciBEZWxsIEVNQyBQb3dlckVkZ2Ug
c3lzdGVtcy4NCj4gPiA+ID4NCj4gPiA+ID4gQSBxdWljayBHb29nbGUgc2VhcmNoIHRlbGxzIG1l
IHRoZXNlIGFyZSBJbnRlbCBYZW9uLg0KPiA+ID4gPiBBcmUgYXJtL2FybTY0L2lhNjQgdmFyaWFu
dHMgYXZhaWxhYmxlLCB0b28/DQo+ID4gPiA+IElmIG5vdCwgdGhpcyBzaG91bGQgYmUgcHJvdGVj
dGVkIGJ5ICJkZXBlbmRzIG9uIHg4NiIgKCJ8fCBDT01QSUxFX1RFU1QiPykuDQo+ID4gPg0KPiA+
ID4gVGhlIGNvZGUgaW4gcXVlc3Rpb24gaXMgZW50aXJlbHkgYXJjaGl0ZWN0dXJlIGFnbm9zdGlj
LCBhbmQgZGVmYXVsdHMNCj4gPiA+IHRvICduJywgc28gSSBhbSBub3QgY29udmluY2VkIHRoaXMg
aXMgbmVlZGVkLiAoSXQgY2FtZSB1cCBpbiB0aGUNCj4gPiA+IHJldmlldyBhcyB3ZWxsKQ0KPiA+
DQo+ID4gIm1ha2Ugb2xkY29uZmlnIiBzdGlsbCBhc2tzIG1lIHRoZSBxdWVzdGlvbiBvbiBlLmcu
IGFybTY0LCB3aGVyZSBpdCBpcw0KPiA+IGlycmVsZXZhbnQsIHVudGlsIGFybTY0IHZhcmlhbnRz
IG9mIHRoZSBoYXJkd2FyZSBzaG93IHVwLg0KPiA+DQo+ID4gU28gSU1ITyBpdCBzaG91bGQgaGF2
ZSAiZGVwZW5kcyBvbiBYODYgfHwgQ09NUElMRV9URVNUIi4NCj4gPg0KPiANCj4gRmFpciBlbm91
Z2guIEkgYW0gZ29pbmcgdG8gc2VuZCBvdXQgYSBidW5jaCBvZiBFRkkgZml4ZXMgdGhpcyB3ZWVr
LCBzbw0KPiBJJ2xsIGFjY2VwdCBhIHBhdGNoIHRoYXQgbWFrZXMgdGhlIGNoYW5nZSBhYm92ZS4N
Cg0KSXMgaXQgcmVhbGx5IGEgcHJvYmxlbSB0byBqdXN0IHNheSBuPw0KDQpJIHRoaW5rIHRoaXMg
c2VlbXMgbGlrZSBhIG5lZWRsZXNzIGNoYW5nZSB0aGF0IHdvdWxkIHNsb3cgZG93biBhZG9wdGlv
biBvZg0KIXg4NiBpZiBEZWxsIEVNQyBQb3dlckVkZ2Ugc3lzdGVtcyBkaWQgc3RhcnQgZ29pbmcg
dGhhdCByb3V0ZSwgZXNwZWNpYWxseQ0Kd2hlbiBpdCBjb21lcyB0byBkaXN0cmlidXRpb25zIHRo
YXQgbW92ZSBnbGFjaWFsbHkgc2xvdyB3aXRoIHBpY2tpbmcgdXAgbmV3DQprZXJuZWwgY29kZS4N
Cg0K
