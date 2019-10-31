Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA28EB3F5
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfJaPar (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 11:30:47 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:36074 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbfJaPaq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 11:30:46 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VFPoSS012229
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 11:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=w/r5Y92eE5y+VsBvA1ietgqOtjX3pNWXxPxYOx4QAmE=;
 b=I36dub4ZIH0vC2UUnX6ZzomjQUEbxhM5X5wU/4aks9SB++szTHHfQ/oma4OdmvdgXWX/
 86Zcb0qsx+WUmRl/BaLuuPESazamMk/zyrR7FvLa7btNwKwhhEba958vb4yR+/6ZL5bF
 AybY6OETZmpHOziwRkQ50DojHdXWndXHIuKhlMDWZ7YkY2GvM7NiJu9vMrdP65qOuOtH
 hQfywe2WSq4VxvgHzCBwklqq17gJUVU4U2ZR/lfF1qWHS4STjqLWcWY9HeYfw69ZGAeQ
 qfo2F3KLsLGkQIYWLq8StuXOZfxflqqMoaBkIjW3utQnUrEMlHGQoe3GiHPCKHI5nPTt EQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2vxwp1hgde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 11:30:45 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VFSApT141116
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 11:30:44 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2vxwmmtsu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 11:30:44 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1319733845"
From:   <Mario.Limonciello@dell.com>
To:     <ard.biesheuvel@linaro.org>, <linux@dominikbrodowski.net>
CC:     <linux-efi@vger.kernel.org>
Subject: RE: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
Thread-Topic: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
Thread-Index: AQHVjWGTpr9I+X/6bEKG+5hDBd8FjqdwAKsAgAAPC4CAAASnAIAE0NgQ
Date:   Thu, 31 Oct 2019 15:30:42 +0000
Message-ID: <e4336d7a25be47dcb4520097ff0fc801@AUSX13MPC105.AMER.DELL.COM>
References: <20191005113753.GA77634@light.dominikbrodowski.net>
 <20191028072036.GA113601@owl.dominikbrodowski.net>
 <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
 <20191028084019.GA2392@owl.dominikbrodowski.net>
 <CAKv+Gu9gp+BUhf3KJMCTFuon9o1mUGv9UxWQ=A==-gLiAjRNNQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9gp+BUhf3KJMCTFuon9o1mUGv9UxWQ=A==-gLiAjRNNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-31T15:30:41.3888673Z;
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
 definitions=2019-10-31_06:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310156
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310156
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJk
LmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI4LCAyMDE5
IDM6NTcgQU0NCj4gVG86IERvbWluaWsgQnJvZG93c2tpDQo+IENjOiBMaW1vbmNpZWxsbywgTWFy
aW87IGxpbnV4LWVmaQ0KPiBTdWJqZWN0OiBSZTogZWZpc3R1YjogRUZJX1JOR19QUk9UT0NPTCBv
biBEZWxsIEluYy4gTGF0aXR1ZGUgNzM5MA0KPiANCj4gDQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4g
DQo+IE9uIE1vbiwgMjggT2N0IDIwMTkgYXQgMDk6NDIsIERvbWluaWsgQnJvZG93c2tpDQo+IDxs
aW51eEBkb21pbmlrYnJvZG93c2tpLm5ldD4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbyBBcmQsDQo+
ID4NCj4gPiBPbiBNb24sIE9jdCAyOCwgMjAxOSBhdCAwODo0NjoyOEFNICswMTAwLCBBcmQgQmll
c2hldXZlbCB3cm90ZToNCj4gPiA+IEhlbGxvIERvbWluaWssDQo+ID4gPg0KPiA+ID4gT24gTW9u
LCAyOCBPY3QgMjAxOSBhdCAwODozMCwgRG9taW5payBCcm9kb3dza2kNCj4gPiA+IDxsaW51eEBk
b21pbmlrYnJvZG93c2tpLm5ldD4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEFyZCwgTWFyaW8s
DQo+ID4gPiA+DQo+ID4gPiA+IGluIHRoZW9yeSwgaW52b2tpbmcgRUZJX1JOR19QUk9UT0NPTCBv
biBhIERlbGwgSW5jLiBMYXRpdHVkZSA3MzkwLzA5Mzg2ViwNCj4gPiA+ID4gQklPUyAxLjkuMiAw
NC8wMy8yMDE5LCBzaG91bGQgd29yayBmaW5lIGFzIHRoZSBzeXN0ZW0gcHJvdmlkZXMgRUZJIHYy
LjYwLg0KPiA+ID4gPiBVc2luZyBteSBwYXRjaCBmcm9tIGEgZmV3IHdlZWtzIGFnb1sxXSwgZWZp
X3JhbmRvbV9nZXRfc2VlZCgpIGlzIGNhbGxlZA0KPiBmcm9tDQo+ID4gPiA+IGFyY2gveDg2L2Jv
b3QvY29tcHJlc3NlZC9lYm9vdC5jOjplZmlfbWFpbigpLiBJbg0KPiBlZmlfcmFuZG9tX2dldF9z
ZWVkKCksIHRoZQ0KPiA+ID4gPiBjYWxscyB0bw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHN0
YXR1cyA9IGVmaV9jYWxsX2Vhcmx5KGxvY2F0ZV9wcm90b2NvbCwgJnJuZ19wcm90bywgTlVMTCwN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodm9pZCAqKikmcm5nKTsN
Cj4gPiA+ID4NCj4gPiA+ID4gYW5kDQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgc3RhdHVzID0g
ZWZpX2NhbGxfZWFybHkoYWxsb2NhdGVfcG9vbCwgRUZJX1JVTlRJTUVfU0VSVklDRVNfREFUQSwN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoKnNlZWQpICsg
RUZJX1JBTkRPTV9TRUVEX1NJWkUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHZvaWQgKiopJnNlZWQpOw0KPiA+ID4gPg0KPiA+ID4gPiBzdWNjZWVkLiBIb3dldmVy
LA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHN0YXR1cyA9IHJuZy0+Z2V0X3JuZyhybmcsICZy
bmdfYWxnb19yYXcsIEVGSV9SQU5ET01fU0VFRF9TSVpFLA0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzZWVkLT5iaXRzKTsNCj4gPiA+ID4NCj4gPiA+ID4gcmV0dXJucyBF
RklfSU5WQUxJRF9QQVJBTUVURVIsIHRob3VnaCBJIGNhbid0IHNlZSB3aHkgb25lIG9mIHRoZXNl
DQo+ID4gPiA+IHBhcmFtZXRlcnMgaXMgaW52YWxpZC4NCj4gPiA+DQo+ID4gPiBUaGUgVUVGSSBz
cGVjIGRlZmluZXMgdGhlIGNvbmRpdGlvbnMgdW5kZXIgd2hpY2ggdGhpcyBmdW5jdGlvbiBtYXkN
Cj4gPiA+IHJldHVybiBFRklfSU5WQUxJRF9QQVJBTUVURVIgYXMNCj4gPiA+DQo+ID4gPiAiIiIN
Cj4gPiA+IFJOR1ZhbHVlIGlzIG51bGwgb3IgUk5HVmFsdWVMZW5ndGggaXMgemVyby4NCj4gPiA+
DQo+ID4gPiAiIiINCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiBXaGVuIHRyeWluZyB0byB1c2UgdGhl
IGRlZmF1bHQgcm5nIGFsZ29yaXRobSAoYnkNCj4gPiA+ID4gbW9kaWZ5aW5nIHRoZSB0ZXN0IHRv
ICIoc3RhdHVzICE9IEVGSV9TVUNDRVNTKSIpLA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gcm5nLT5nZXRfcm5nKHJuZywgTlVMTCwgRUZJX1JBTkRPTV9TRUVEX1NJ
WkUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VlZC0+
Yml0cyk7DQo+ID4gPiA+DQo+ID4gPiA+IHRoZSBjYWxsIGRvZXNuJ3Qgc2VlbSB0byByZXR1cm4u
DQo+ID4gPiA+DQo+ID4gPiA+IEFueSBpZGVhcz8NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBUcnkg
cnVubmluZyB0aGlzIGZyb20gdGhlIFVFRkkgc2hlbGw6DQo+ID4gPg0KPiA+ID4gaHR0cDovL3Bl
b3BsZS5saW5hcm8ub3JnL35hcmQuYmllc2hldXZlbC9SbmdUZXN0LVg2NC5lZmkNCj4gPg0KPiA+
IEludGVyZXN0aW5nbHksIHRoaXMgc3VjY2VlZHMgLS0gd2l0aCB0aGUgZGVmYXVsdCBhbGdvcml0
aG0sIFNQODAwLTkwLUNUUi0yNTYNCj4gPiBhbmQgUkFXLiBTbyBJIGFtIG1vcmUgY29uZnVzZWQg
dGhhbiBiZWZvcmUgb24gd2h5IHRoZSBjYWxsIHRvIC0+Z2V0X3JuZygpDQo+ID4gZmFpbHMgaW4g
ZWZpX3JhbmRvbV9nZXRfc2VlZCgpLg0KPiA+DQo+IA0KPiBJdCBtaWdodCBiZSBhbiBpc3N1ZSB3
aXRoIHRoZSBzaXplIG9mIHRoZSBvdXRwdXQuDQo+IA0KPiBUaGUgb3JpZ2luYWwgUkRSQU5EIGJh
c2VkIGRyaXZlciBpbiBFREsyIGNvbnRhaW5zIGFuIGFwcGFyZW50DQo+IG1pc2NvbmNlcHRpb24g
dGhhdCwgZHVlIHRvIHRoZSBmYWN0IHRoYXQgY2VydGFpbiBTUDgwMC05MC1DVFItMjU2DQo+IERS
QkdzIHJlcXVpcmUgMzIgYnl0ZXMgb2YgcmF3IGVudHJvcHkgYXMgYSBzZWVkLCBpdCBpcyBvbmx5
IHZhbGlkIGZvcg0KPiB0aGUgUkFXIGFsZ29yaXRobSB0byBiZSBjYWxsZWQgd2l0aCBhbiBvdXRw
dXQgc2l6ZSBvZiAzMi4NCj4gDQo+IFNvIGluIHRoaXMgY2FzZSwgaXQgbWlnaHQgYmUgdGhhdCAz
MiBpcyB0cmVhdGVkIGFzIGEgbWFnaWMgbnVtYmVyIHRvbywNCj4gYW5kIGFueSBvdGhlciBzaXpl
IGlzIHJlamVjdGVkIGJ5IHRoZSBSQVcgYWxnb3JpdGhtLg0KPiANCj4gTm90IHN1cmUgd2h5IHRo
ZSBvdGhlciBvbmUgZmFpbHMsIHRob3VnaCwgYnV0IHRoZSBmYWN0IHRoYXQgUkFXIGFuZA0KPiBT
UDgwMC05MC1DVFItMjU2IGFyZSB0aGUgb25seSBzdXBwb3J0ZWQgYWxnb3JpdGhtcyBzdWdnZXN0
cyB0aGF0IHlvdXINCj4gaW1wbGVtZW50YXRpb24gaXMgYXQgbGVhc3Qgc2ltaWxhciB0byB0aGUg
UkRSQU5EIGJhc2VkIFJuZ0R4ZQ0KPiBpbXBsZW1lbnRhdGlvbiBpbiBFREsyLg0KDQpJIGNvbmZp
cm1lZCB3aXRoIG91ciBCSU9TIHRlYW0gZm9yIHRoaXMgcGxhdGZvcm0gdGhhdCB0aGUgaW1wbGVt
ZW50YXRpb24gb2YNCmh0dHBzOi8vZ2l0aHViLmNvbS90aWFub2NvcmUvZWRrMi9ibG9iL21hc3Rl
ci9TZWN1cml0eVBrZy9SYW5kb21OdW1iZXJHZW5lcmF0b3IvUm5nRHhlL1JuZ0R4ZS5jDQptYXRj
aGVzIEVESzIgaW1wbGVtZW50YXRpb24gYXMgb2YgY29tbWl0IGh0dHBzOi8vZ2l0aHViLmNvbS90
aWFub2NvcmUvZWRrMi9jb21taXQvMjg5YjcxNGI3NzAwOGFhNDIwMGMwYmUyNWM0YjRlMjVkZjA0
OTU1YQ0KDQpUaGFua3MsDQoNCg==
