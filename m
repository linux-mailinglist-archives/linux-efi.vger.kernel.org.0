Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F9126510C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Sep 2020 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIJUkv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Sep 2020 16:40:51 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:9150 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbgIJUke (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Sep 2020 16:40:34 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKZA3b017623;
        Thu, 10 Sep 2020 16:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=iV3gaE4qnWy/rXXm/neg0iZkM5NZbbB/VBpacpuI8q8=;
 b=v5GWtINSdy5Js/PGkPIRHBzLXP9beIJ252LOvi8UB5w+1d47K0Ttb9Rd8fO7Xj1Ysm8/
 vimcBsBiccCildM3WHz3j9kskJxlzekRDVKVI+AW7Q7+MWJ0WraiZlnOZ138wBXFJRTt
 0b45KFWw4s0TlaaRa6prG9xXT+JApfXLGEo2RqDmaIa/0cXW5lr4QDI3vNHO2uI2KzWo
 XRegheOCFSiO2kdvGt2n1Eqh3laMP36Fbu+NasULCLabApri4QOOs6q1rH9/8mVrUwtC
 Qjdh7nTHgG5Rvou9hvChZRryjZ7v6NcZ7Y452ngiS2gw5BZFCrXgLDpUZPXYksyS6aGC +Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33fqdj0x9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 16:40:09 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKV73A140178;
        Thu, 10 Sep 2020 16:40:08 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0a-00154901.pphosted.com with ESMTP id 33fhvp1rbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 16:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck6hAhQ6S2FnjezwAL4T1vC7mwfFQidxL1C6DI1FpHsSgXU0Wc0Pcsnhq5ntCYhIftyK1FsP+5XPGRs/Tw06uM0QtGQqJpinivsnYCwG8BJXZG0LblKMhFjsmDpG7V/xnZ2xQClovBajS5coetPZDauNOqU3xGw7WPk4W6Xgd/2ucsOGt+7d34Ok4XbuWmW2O9ESGtRLxqowY8grJq1CO1qjPrnABicVUe5OonQT//ZCM7PrPS5mIhonnX3V5tltWwqaYKHlHp4K27Uz+TUPlnBMhg+D/2oUkbCqJesFAhT+Vqxe3Ldb9sdUCG7/ewi1P9GDa2aSLGIZY/zOx5/gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV3gaE4qnWy/rXXm/neg0iZkM5NZbbB/VBpacpuI8q8=;
 b=C4xUjW5jp5SxJjIaFtE9s3gfiJ5ZED5B9u9cFe7JsVDDhue4NPGy057FVMG1dRu8E6f1bAWbN8PHaRmg3bkVMIjGo1RVI3aGPAlKwdEzpzEMSDqTWy8TmVhVdB/MdaUBzi8JnrVodIf+yR56x6Tzgb4bocCTDP587Z5vFzjTkB7xxaW2F+k71KiV6bogbVvqitvx6bzfWszm61/h+APDG6V20DvneKVIJRVWWYEB8fmZOAsmeHAWI+8AbehEJOvAvGGzHbz36L1mfp/KR3svBYE8fTykxiFXlbBEQCQqjIEiL8OQ629qYA5Z0uBxax5MGYouNApqVsxZbnrSD979yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV3gaE4qnWy/rXXm/neg0iZkM5NZbbB/VBpacpuI8q8=;
 b=W98kTj2wjEqd5nwi90AvWpeKc1vN8VT3cYhMEyWKaGksSPJXv6ojgyNagy/3xC73scKZifF3jj69WvRchvatBpJ13vpHhre+7wu2IgVrYBlwbkmHcac3RkG8fSaSZprKkvo8N6Cwd9vAVrQaVEae2Z4wlxBHblKSdA1x8SXrn48=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1034.namprd19.prod.outlook.com (2603:10b6:3:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Thu, 10 Sep
 2020 20:40:06 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 20:40:06 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Jones <pjones@redhat.com>
CC:     Jacobo Pantoja <jacobopantoja@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: EFISTUB arguments in Dell BIOS
Thread-Topic: EFISTUB arguments in Dell BIOS
Thread-Index: AQHWh1rakaIV+ox6skSrEBsPAF/koKliOdJQ
Date:   Thu, 10 Sep 2020 20:40:06 +0000
Message-ID: <DM6PR19MB2636BAC48CDC12B08BF611D3FA270@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
 <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan>
 <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan>
 <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
 <20200909203830.GA490605@rani.riverdale.lan>
 <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
In-Reply-To: <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-10T19:15:00.6663464Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=401ee68d-d2f0-4727-8399-06b346e6f17c;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce1b729-f48f-4d05-b37b-08d855c9b3e7
x-ms-traffictypediagnostic: DM5PR19MB1034:
x-microsoft-antispam-prvs: <DM5PR19MB1034C5CFB1651E104926654FFA270@DM5PR19MB1034.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSjMzFWC6spSy977xaraY//IwTfQ43tcnimz1PAE6SCoSgd/V+lRkBfehm85LuoJcYLsV2gxVYUigbB2pwzgUIKIV+NWY8f62O0xciSFPire6aoerG/n5pSAeAr/+uFEBS5jqYiIKXLU0189wj0NE1tmvenumCCdW9JOBIPvG0OlyRcFik0lpuvjf7064v0B5txtKfuXPS4msK/Kw8c67KR0C1/68mukgR6y7cHQrWjeaAO+GlBdSI2Je0pGjkfmxJ5E+o/X9lLQu9x32FpLriBP05398P4e/kA7MmQu1jmfS9iZU3YXezPJ9LQs7VetHRGWvp7U7bQ07VyeeXc4WLWmgE/xUTFpeZf0wnAr4G+78WLiqUp558/ebSRDdflvjj5bvLmsjhrLuYmyTfm2NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(186003)(478600001)(55016002)(76116006)(66946007)(71200400001)(66476007)(26005)(64756008)(5660300002)(6506007)(7696005)(66446008)(66556008)(9686003)(86362001)(316002)(52536014)(110136005)(4326008)(33656002)(8676002)(54906003)(2906002)(8936002)(786003)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tG8wTazyrFS2NhyvnBOalUw0csSfvvtZRc/FqjP3zdljQQ+gpi7oCJgzquZGas9F+1gXrkl2CaHkVF8bskFlYLAKNtft7XMdsbeOnZxxlU+p/sz4H8asxrO8n9x1GWikbjuwCml4SuMVx+hXyNcWq7LNFHxYOah1mqbM3Ku2ulzXoKcTtRbQlhUcrtp6J3aXa+rnyHoguO4rPlWyX3IBBeOmCd741Z7GStcZZMEYhqCazmvyaPX7jGvGF8+NeeeuARw5cQo2NdI/q5Vcm+5oJT1tZ9w1rcOXTe57O2+GoSv8QuaLSJmM0JmOBPChwb3oankX5j4KBxCq7H0oZU10N919/iBf1NENOQg82zJW0p1cZMF2zTBmhDKp/dnnKE3pHgamK+xQYKOPuPfEJzR5Cix+/Xt8YP31Wv543IxbwlsFFemojx7VSxptgIk/34DBrE60paVdQW0Dcf94hsJzzQzFcTdmC43kQkhiPDfU346rDuT99vDzVAHysC+5BtEPPJiqbPxIq7SE7i0vf/u2IMtXVNuku/oYc4fHgyEwCE9tgtA3v7jqEQH0Cy9fvFyGBoyBFqcF95dX2wRggNhkT1+SPj8kVTnsgzrcP0gWVzl0JHDvtdWZqG4YCYsjmdEq14vsQ0ylSyPG9nVe674NLg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce1b729-f48f-4d05-b37b-08d855c9b3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 20:40:06.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMCsl85xX5g4uWObN9vy5S04g2XrOuvyuYE+woJaGSzmOU+k/bjvrAmjn013nTRDwswN9iqyP/lrZ7sDxdOC2RuH5/4mEnE2BiH+eWMBhIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1034
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100184
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100184
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PiA+DQo+ID4gT2ssIHRoaXMgaXMgbGFpZCBvdXQgaW4gc2VjdGlvbiAzLjEgb2YgdGhlIHNwZWMg
d2hpY2ggZGVmaW5lcyB0aGUgZm9ybWF0DQo+ID4gb2YgdGhlIEVGSV9MT0FEX09QVElPTiBkZXNj
cmlwdG9yLiBEZWxsJ3MgQklPUyBpcyBwYXNzaW5nIHRoZSBlbnRpcmUNCj4gPiBkZXNjcmlwdG9y
IGluc3RlYWQgb2YganVzdCB0aGUgT3B0aW9uYWxEYXRhIHBhcnQuDQo+ID4NCj4gPiBPcHRpb25h
bERhdGEgICAgVGhlIHJlbWFpbmluZyBieXRlcyBpbiB0aGUgbG9hZCBvcHRpb24gZGVzY3JpcHRv
ciBhcmUgYQ0KPiA+ICAgICAgICAgICAgICAgICBiaW5hcnkgZGF0YSBidWZmZXIgdGhhdCBpcyBw
YXNzZWQgdG8gdGhlIGxvYWRlZCBpbWFnZS4NCj4gPiAgICAgICAgICAgICAgICAgSWYgdGhlIGZp
ZWxkIGlzIHplcm8gYnl0ZXMgbG9uZywgYSBOdWxsIHBvaW50ZXIgaXMNCj4gPiAgICAgICAgICAg
ICAgICAgcGFzc2VkIHRvIHRoZSBsb2FkZWQgaW1hZ2UuIFRoZSBudW1iZXIgb2YgYnl0ZXMgaW4N
Cj4gPiAgICAgICAgICAgICAgICAgT3B0aW9uYWxEYXRhIGNhbiBiZSBjb21wdXRlZCBieSBzdWJ0
cmFjdGluZyB0aGUgc3RhcnRpbmcNCj4gPiAgICAgICAgICAgICAgICAgb2Zmc2V0IG9mIE9wdGlv
bmFsRGF0YSBmcm9tIHRvdGFsIHNpemUgaW4gYnl0ZXMgb2YgdGhlDQo+ID4gICAgICAgICAgICAg
ICAgIEVGSV9MT0FEX09QVElPTi4NCj4gPg0KPiA+IGh0dHBzOi8vdWVmaS5vcmcvc2l0ZXMvZGVm
YXVsdC9maWxlcy9yZXNvdXJjZXMvVUVGSV9TcGVjXzJfOF9maW5hbC5wZGYNCj4gPg0KPiANCj4g
VGhpcyB2YWd1ZWx5IHJpbmdzIGEgYmVsbCBzbyBJIGhhdmUgY2MnZWQgc29tZSBmb2xrcyB3aG8g
bWF5IGhhdmUgcnVuDQo+IGludG8gdGhpcyBpbiB0aGUgcGFzdC4gQ29tcGxldGUgdGhyZWFkIGNh
biBiZSBmb3VuZCBhdCBbMF0NCj4gDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0aGUgY29udGV4dC4g
IFRoaXMgcmluZ3MgYSBiZWxsIGZvciBtZSB3aXRoIHRoZSBsYXN0IHRpbWUNCkkgcmVjYWxsIHdv
cnJ5aW5nIGFib3V0IHRoZSBMb2FkIE9wdGlvbnMgYW5kIHRoaXMgY29tbWl0IGluIHNoaW0gY29t
ZXMgdG8NCm1pbmQ6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9yaGJvb3Qvc2hpbS9jb21taXQvMzMy
MjI1N2U2MTFlMjAwMGY3OTcyNmQyOTViYjQ4NDViYmU0NDllNw0KDQpJdCBzZWVtcyB0byBtZSB0
aGUgc2hpbSBhcHByb2FjaCB0byB0aGUgcHJvYmxlbSBpc24ndCB0b28gYmlnIG9mIGEgZGVhbDoN
CmNvdW50IHRoZSBudW1iZXIgb2Ygc3RyaW5ncyBhbmQgaWYgaXQncyBncmVhdGVyIG9yIGVxdWFs
IHRvIDIsIHRoZW4gdGhyb3cNCm91dCB0aGUgZmlyc3Qgb25lLiAgSXQncyBhbHNvIGFscmVhZHkg
YmVlbiB1c2VkIGluIHByb2R1Y3Rpb24gY29kZSBhY3Jvc3MgYSANCnRvbiBvZiBwbGF0Zm9ybXMg
Zm9yIHNldmVyYWwgeWVhcnMsIHNvIGlmIHRoZXJlIHdhcyBtYWpvciBicmVha2FnZXMgSSB3b3Vs
ZA0KZXhwZWN0IHRoZXkncmUgY292ZXJlZCBpbiB0aGF0IGNvZGUgdG9vIGJ5IG5vdy4NCg0KPiBU
aGUgZmlybXdhcmUgaXMgb2J2aW91c2x5IHBhc3NpbmcgdGhlIHdyb25nIGRhdGEsIGFuZCBJIGFt
IHJlbHVjdGFudA0KPiB0byBxdWlyayB0aGlzIG91dCwgc2luY2Ugd2UnZCBoYXZlIHRvIGludGVy
cHJldCB0aGUgY29udGVudHMgb2YgdGhlc2UNCj4gVUVGSSB2YXJpYWJsZXMsIGFuZCBnaXZlbiB0
aGUgYW1vdW50IG9mICd2YWx1ZSBhZGQnIGJ5IHRoZSBCSU9TDQo+IHZlbmRvcnMgaW4gdGhpcyBh
cmVhLCB3ZSBtYXkgZW5kIHVwIGJyZWFraW5nIHRoaW5ncyBvbiBvdGhlcg0KPiBwbGF0Zm9ybXMu
DQo+IA0KPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+IGVmaS8yMDIwMDkw
OTIwMzgzMC5HQTQ5MDYwNUByYW5pLnJpdmVyZGFsZS5sYW4vDQoNCkluIHRoZSBkZWZlbnNlIG9m
IG90aGVycyB3aG8gaGF2ZSBpbnRlcnByZXRlZCB0aGUgc3BlYywgYXMgSSdtIHJlYWRpbmcgaXQg
SSdtDQpub3QgY29udmluY2VkIHRoYXQgaXQgZXhwbGljaXRseSBjYWxscyBvdXQgd2hhdCBkYXRh
IHNob3VsZCBiZSBwYXNzZWQuIEluDQpzZWN0aW9uIDcuNCB3aGljaCBleHBsYWlucyBob3cgTG9h
ZEltYWdlKCkgYmVoYXZlcy4NCg0KYGBgDQpPbmNlIHRoZSBpbWFnZSBpcyBsb2FkZWQsIGZpcm13
YXJlIGNyZWF0ZXMgYW5kIHJldHVybnMgYW4gRUZJX0hBTkRMRSB0aGF0IGlkZW50aWZpZXMgdGhl
IGltYWdlIGFuZA0Kc3VwcG9ydHMgRUZJX0xPQURFRF9JTUFHRV9QUk9UT0NPTCBhbmQgdGhlIEVG
SV9MT0FERURfSU1BR0VfREVWSUNFX1BBVEhfUFJPVE9DT0wuDQpUaGUgY2FsbGVyIG1heSBmaWxs
IGluIHRoZSBpbWFnZeKAmXMg4oCcbG9hZCBvcHRpb25z4oCdIGRhdGENCmBgYA0KDQpJbiB0aGlz
IGNvbnRleHQgdGhlIGNhbGxlciBpcyBtb3N0IGxpa2VseSBCRFMsIGFuZCBpdCdzICJvcHRpb25h
bCIgdG8gbG9hZA0KY29udGVudCBpbi4gIFdpdGhpbiBzZWN0aW9uIDkuMSB3aGljaCBkZXNjcmli
ZXMgdGhlIGxvYWRlZCBpbWFnZSBwcm90b2NvbCB0aGUgZXhhY3QNCmZvcm1hdCBvZiB0aGUgY29u
dGVudCBvZiAiTG9hZE9wdGlvbnMiIGlzIG5vdCBkZXNjcmliZWQuICBJIGNhbiBzZWUgYW4gaW50
ZXJwcmV0YXRpb24NCml0IHNob3VsZCBiZSB0aGUgZnVsbCBkZXNjcmlwdG9yIG9yIHRoYXQgaXQg
Y2FuIGJlIHRoZSBPcHRpb25hbERhdGEuDQoNCkFuZCBhY3R1YWxseSBpZiB5b3UgbG9va3MgaW4g
aGlzdG9yeSBmcm9tIEVESyBjb2RlLCB5b3UgY2FuIHNlZSB0aGF0IGl0J3MgYmVlbiBkb25lIHRo
YXQgd2F5IHRoZXJlIHRvbyBhdCBsZWFzdCBhdCBvbmUgdGltZToNCmh0dHBzOi8vZ2l0aHViLmNv
bS90aWFub2NvcmUvZWRrMi9ibG9iL2I4ZDA2MjkzY2FhMTIyZjljM2JkMmFlMzJhNmMzZjc5MGEw
NTRlMDMvSW50ZWxGcmFtZXdvcmtNb2R1bGVQa2cvTGlicmFyeS9HZW5lcmljQmRzTGliL0Jkc0Jv
b3QuYyNMMjQzMw0KDQoNCkphY29ibywNCg0KQ2FuIHlvdSBwcm92aWRlIHNvbWUgbW9yZSBkZXRh
aWxzIG9uIHlvdXIgc3lzdGVtIHRoYXQgaXMgcmVwcm9kdWNpbmcNCnRoaXM/ICBNb2RlbCBudW1i
ZXIsIEZXIHZlcnNpb24gd291bGQgYmUgdXNlZnVsLg0KVGhlIGxpbmtzIHByb3ZpZGVkIGVhcmxp
ZXIgb24gYXJlIG9uIHByZXR0eSBvbGQgc3R1ZmYsIHNvIGtub3dpbmcgdGhhdCB0aGlzDQppcyBh
IHByb2JsZW0gb24gc29tZXRoaW5nIG1vcmUgY3VycmVudCB3b3VsZCBiZSBnb29kLg0KDQpJIGd1
ZXNzIHRoZSBvdGhlciBvcHRpb24gaWYgQXJkIGNob29zZXMgbm90IHRvIGFkb3B0IGEgcXVpcmsg
Zm9yIHRoaXMNCmRlc2NyaWJlZCBiZWhhdmlvciBpcyB0byB1c2Ugc2hpbSB0byBsb2FkIHRoZSBr
ZXJuZWwgZWZpc3R1YiwgYW5kIGxldA0KaXQgZG8gdGhlIHNwbGl0IGZvciB5b3UuDQo=
