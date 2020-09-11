Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43E2663A8
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIKQWB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 12:22:01 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:13604 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgIKP20 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 11:28:26 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BFQc1F029450;
        Fri, 11 Sep 2020 11:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=mLlvdmW+J/7uIEJL+xaCKTtqVxiQ+QlQVQmA+3zmYlM=;
 b=Zt9qxbT62kt4oOoR7cVOLFBfFIjm5+16V9Ahsp2lT11FVWnLYlHDTabCd/XNebGZXFQX
 yHsEqrlVaY6p/JP2U5/IjcJ7og1nUhgwEApqdiOzMgv31kMK9vxB329gNy5XQsTCg7QR
 3euB232hqQrBnmoBXbsXPbLU/j81UUc+UjOj7bdkXSt7QpoAOCicY84tLnrjG3PUcq4T
 tr/DEG6fMKQR7OvOtE1pVmpsVkLnkO107LaixxPGbGveciQyi/y827G48v4ZuMJg5d4h
 dwz8I/XwPW+blleD7el5MfJ8bXpo+R6DaqgPHLxe2JmFE3k+mYaKn0PZJx2PrAHnyNqo TA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 33c60jxqu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:28:15 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BFMvQT085391;
        Fri, 11 Sep 2020 11:28:15 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00154901.pphosted.com with ESMTP id 33ga4225nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 11:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUX2vO1IanZQl7qqRsVOgD8nVIIEHlpuWCeubnnjbr3EFbgRtR36YcEPe2UouM+ETH9mhzoBrjKxaPPq9fKEREeBO15PT05jzUD4u8jjtrZ6Z8xwP9dwSX0H+I9j1el22WtfElTTgsUThv9zZb3G/bAndhc43vwlF4dey3G0wcCb648GdF2Zt8MPtR19GpR4siRJ9AR/VkW5os0ywgeHRuzKFYLLafdw0hySerDVX6WKEPaePb7W7RWg4BC27wmMcmwyMNHHjVsd9QFMxqBpD7ck4LuhFXGTJGGRG8//wiIa257kFE2qIBjtytw4ZGM0AfUZF29rIwF6t9YBeVRing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLlvdmW+J/7uIEJL+xaCKTtqVxiQ+QlQVQmA+3zmYlM=;
 b=ZxRH+cJ9VVR3ALmy1Zdr5eUD/Akc/rvlMoJYBehjNGy5kK0z6rgRjmr6R3b2AG7d5DNjlgB14lCMyshzAey0FdI+hBpTlIe9omNyx3smvcKRtSbOFoi0/rKhZJWKaOfsU/bk7wxwwl6rkt24PhisYV8g6+TCLdzcGq3gXK/tlbY9mlfqSC+82fdqabNjG7YrptQqwWa2Jor5yTQtppoZjbXYMSL5FsYq/CDAw2MjDR9TkxtGQnuLKuJHl01jn8hxgNSz2XElc7XjuKCLYA8Hr1oVLQ4QkJhfocoFZrMJSWVSAj0FL/RzGO3TAA0iKusC0xmAYWpBvEJVvCKgPvYOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLlvdmW+J/7uIEJL+xaCKTtqVxiQ+QlQVQmA+3zmYlM=;
 b=Kj8yusyIDNqhTMbfOg1gHVy7zl35CSl5PjBFVp9iIJxSOTNtwPGWLZP8VKkIF3BebgYCCMLPUGim0lWNzs801QkRqjMMiSWEDj5aoojQI53OookxiTkixUNzVu1Y7t6+zoFLOdmWze9Ex0f0wAUZAwmG46I3VxB7RWD9sLlKNzk=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB0027.namprd19.prod.outlook.com (2603:10b6:4:6b::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 15:28:13 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 15:28:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Jacobo Pantoja <jacobopantoja@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
CC:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: EFISTUB arguments in Dell BIOS
Thread-Topic: EFISTUB arguments in Dell BIOS
Thread-Index: AQHWh1rakaIV+ox6skSrEBsPAF/koKliOdJQgABVk4CAAGHAgIAAmznw
Date:   Fri, 11 Sep 2020 15:28:13 +0000
Message-ID: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
 <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan>
 <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan>
 <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
 <20200909203830.GA490605@rani.riverdale.lan>
 <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
 <DM6PR19MB2636BAC48CDC12B08BF611D3FA270@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200911000401.GA877093@rani.riverdale.lan>
 <CAO18KQhucsmzxTXqq9jW53PhaSYmvdE3FmO_Og278XeawBeQTQ@mail.gmail.com>
In-Reply-To: <CAO18KQhucsmzxTXqq9jW53PhaSYmvdE3FmO_Og278XeawBeQTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-11T15:26:51.5406015Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a57b0b81-0225-472b-955a-bab12349a0f3;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9f47e9d-1f84-468e-c7ab-08d856674c96
x-ms-traffictypediagnostic: DM5PR19MB0027:
x-microsoft-antispam-prvs: <DM5PR19MB00277CE54A127487E77E6BFEFA240@DM5PR19MB0027.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hqc04bg9Q5A5nI2aYnjimv7ogzSFuQf8agwfCDDYXpIU8KODtr2QBeslUBDkYRUzAuX/UJ54u12fuyNUP3phV5Cpp/5BsNr0/4lreF3LGtXDHtm8Ib3pDHF8dI3hb3t2MLogOYcRod79+V+SqMeuRu2ydW+ci7XrBP1YP/YRAIircLY3DXr1FQrnLY1epg+D8j/cRv2UwPRSErCDMSRxR4jHbvyMTviAQ2+/h0fYGQTJyH0ohbXEYo6jJjzPxxQfEXeB7VZdAHyuU96qTRdndJRKa4fsHPT3Zmhh3jiqiW5NErW+YtI0GG+qfwGcOa6NHBHfVmrUnhYv90pIU5ysxvQaxBkF9v8UI0OQzmsoP+Tt9W8LMB8K8cihXs4PZOhm+O3YQwq0yto0YZM4hjaRLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(66946007)(66476007)(64756008)(66556008)(76116006)(7696005)(66446008)(4326008)(26005)(186003)(6506007)(86362001)(33656002)(16799955002)(966005)(2906002)(55016002)(478600001)(316002)(52536014)(54906003)(8936002)(786003)(110136005)(9686003)(83380400001)(71200400001)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xlpMoAUv6FXpttINcLGZfeFEQ8j+vRebE0kpT0UEL8VYGgMs0vaWpKaZgyVt4Y1bxay/EA5hiyw2rpon1ouYTupOmiZUXCbRYAm2RoLrqJWj/SPV2EoE/OXdapKbR3uLcJaIIcPnw7TtZ3uFUGV/3bYrDnWnYOX5dGM1UdM9/ZkAXLHZA4r85onhTbpXcqbUyBguJ/y57RcryQdUpE4JTOwrE99XxNdOS9H5hCwwFffoc1dWVhZ0g9roxezB4GV/uQTonWenCTWJCMZXgUeTyK1WPkQ1BDZeJheJn2qHwV848uHjZNu1DGMu0OW18LiQPut50w5lMdcLfSq36IWhnLKRnZB7SQMBhtFRyeyxuWntWA89shWlIR/4bYq/BIDCoTDgRvDmQrWpQdGn9rnf4xxLgTAzjw6AUIzDaSrGVPp6Y245hXWtIntJdolhIOs3qW19beYAqzYW9eHQqIbflTYVCzoefMxwzpx6yiQOrOXE6mdbydAuPgP0+jAhzS80+quSApqW3mkL4toJnp8uhy+raaHDFxL1c9ZxPOtyp5FNQgmfVrwYXem7uWV/CH3N7IgPnbKnAd2tkqpVZ1AENrj79ftrgsmg9C8uvsmQ9qhl6/qKzWiWvmiOxU9Taa6Y/jGw7XOHCh8izpNSYNbR8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f47e9d-1f84-468e-c7ab-08d856674c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 15:28:13.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlDjgDQRMgXHG525YVlIWEl4zWASNUUtkjQ+ydtpGBomjUQ4v1mMt3G2vaYmGPiMO4MPcHRURs9X8MyCxa9qZdTgniecmtN2uhccuilObMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0027
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110126
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110127
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PiBIaSBNYXJpbywgdGhhbmtzIGZvciBqb2luaW5nIHRoZSBjb252ZXJzYXRpb24uDQo+IFRoZSBz
eXN0ZW0gaW4gd2hpY2ggSSdtIHRlc3RpbmcgaXMgYSBQcmVjaXNpb24gVDM2MjAgd2l0aCB0aGUg
dmVyeSBsYXN0DQo+IGZpcm13YXJlIDIuMTUuMCAocHVibGlzaGVkIGluIG1pZCAyMDIwKS4gSXQg
c2VlbXMgdGhhdCB0aGlzIGlzIGFmZmVjdGluZyBhIGxvdA0KPiBvZiBEZWxsJ3MgQklPU2VzOg0K
PiBbMV06IGh0dHBzOi8vd3d3LmRlbGwuY29tL2NvbW11bml0eS9MaW51eC1EZXZlbG9wZXItU3lz
dGVtcy9MaW51eC1FRklTVFVCL3RkLQ0KPiBwLzQ1ODYzNzgNCj4gWzJdOiBodHRwczovL3d3dy5k
ZWxsLmNvbS9jb21tdW5pdHkvTGFwdG9wcy1HZW5lcmFsLVJlYWQtT25seS9EZWxsLVVFRkktDQo+
IGltcGxlbWVudGF0aW9uLWRvZXMtbm90LXN1cHBvcnQtTGludXgtS2VybmVsLUVGSVNUVUIvdGQt
cC81MTg1MjcyDQo+IFszXTogaHR0cHM6Ly9iYnMuYXJjaGxpbnV4Lm9yZy92aWV3dG9waWMucGhw
P3BpZD0xNzUzMTY5I3AxNzUzMTY5DQo+IFs0XTogaHR0cHM6Ly9naXRodWIuY29tL3hkZXZlci9h
cmNoLWVmaWJvb3QNCj4gDQoNClRoYW5rcywgSSdsbCBicmluZyB0aGlzIHRvIHNvbWUgZm9sa3Mg
aW50ZXJuYWxseSB0byBkaXNjdXNzLiBJIGNhbid0IG1ha2UgYW55DQpwcm9taXNlcyBmb3IgdGhp
cyB0eXBlIG9mIGNoYW5nZS4NCg0KSSBkbyB3YW50IHRvIG1lbnRpb24gdGhhdCB5b3VyIHN5c3Rl
bSBhcyB3ZWxsIGFzIGFsbCBvZiB0aG9zZSBpbiB0aGUgbGlua2VkIHBvc3RzDQphcmUgb2xkZXIg
c3lzdGVtIHRoYXQgSSB1bmRlcnN0YW5kIGRvbid0IHJ1biB0aGUgc2FtZSBmaXJtd2FyZSBjb2Rl
IGJhc2UgYXMgY3VycmVudA0Kc3lzdGVtcy4gIA0KDQpTbyBpdCdzIGVudGlyZWx5IHBvc3NpYmxl
IHRoYXQgdGhlIGlzc3VlIGRvZXNuJ3QgZXhpc3QgaW4gY3VycmVudCBzeXN0ZW1zLg0KSWYgYW55
b25lIGVsc2Ugb24gdGhlIG1haWxpbmcgbGlzdHMgaXMgYWxzbyBzZWVpbmcgdGhpcyBvbiBzb21l
IG1vcmUgcmVjZW50IHN0dWZmIHJ1bm5pbmcNCnRoZSBuZXdlciBmaXJtd2FyZSBjb2RlIGJhc2Ug
KExpa2UgWFBTIDczOTAgb3IgWFBTIDkzMDApIGl0IHdvdWxkIGJlIHJlYWxseSBoZWxwZnVsLg0K
DQpZb3UgY2FuIHRlbGwgeW91J3JlIHJ1bm5pbmcgYSBzeXN0ZW0gd2l0aCB0aGUgbmV3ZXIgZmly
bXdhcmUgY29kZSBiYXNlIGJ5IHdoYXQgdGhlDQpzZXR1cCBsb29rcyBsaWtlLg0KDQpUaGlzIGlz
IHRoZSBvbGRlciBzdHVmZjoNCmh0dHA6Ly9rYmltZy5kZWxsLmNvbS9saWJyYXJ5L0tCL0RFTExf
T1JHQU5JWkFUSU9OQUxfR1JPVVBTL0RFTExfR0xPQkFML0NvbnRlbnQlMjBUZWFtL1Jlc3RydWN0
dXJpbmclMjBvZiUyMFVTQiUyMGFuZCUyMFRodW5kZXJib2x0JTIwc2V0dGluZ3MlMjBvbiUyMG5l
dyUyMEJJT1MlMjB2ZXJzaW9uJTIwMDIuanBnDQoNClRoaXMgaXMgdGhlIG5ld2VyIHN0dWZmOg0K
aHR0cHM6Ly93d3cuZGVsbC5jb20vc3VwcG9ydC9hcnRpY2xlL2VuLXVrL3NsbjMyMjMyMy94cHMt
MTMtNzM5MC1hbmQtNzM5MC0yaW4xLWV4dGVybmFsLWRpc3BsYXktbGltaXRhdGlvbnMtaW4tcHJl
LWJvb3QtZW52aXJvbm1lbnRzP2xhbmc9ZW4NCg0KPiA+ID4NCj4gPiA+IEkgZ3Vlc3MgdGhlIG90
aGVyIG9wdGlvbiBpZiBBcmQgY2hvb3NlcyBub3QgdG8gYWRvcHQgYSBxdWlyayBmb3IgdGhpcw0K
PiA+ID4gZGVzY3JpYmVkIGJlaGF2aW9yIGlzIHRvIHVzZSBzaGltIHRvIGxvYWQgdGhlIGtlcm5l
bCBlZmlzdHViLCBhbmQgbGV0DQo+ID4gPiBpdCBkbyB0aGUgc3BsaXQgZm9yIHlvdS4NCj4gDQo+
IFdlIGNhbiBjaXJjdW12ZW50IHRoaXMgYnVnIGluIHNldmVyYWwgd2F5cyAodXNpbmcgR1JVQiwg
cGFja2luZw0KPiBrZXJuZWwgcGx1cyBpbml0cmQgaW50byBhIHNpbmdsZSBFRkkgZmlsZSwgZXRj
LikgYnV0IGhvbmVzdGx5LCBJJ2QgbGlrZSB0bw0KPiBoYXZlDQo+IHRoZSBzYW1lIGxvYWRpbmcg
c2NoZW1lIGluIGFsbCBteSBtYWNoaW5lcy4gQXMgQXJ2aW4gc3RhdGVkLCBhbmQgSSBzaGFyZQ0K
PiBoaXMgc3RhdGVtZW50LCBzZWN0aW9uIDMuMS4zIG9mIHRoZSBVRUZJIHN0YW5kYXJkIGlzIGNs
ZWFyOg0KPiAiVGhlIHJlbWFpbmluZyBieXRlcyBpbiB0aGUgbG9hZCBvcHRpb24gZGVzY3JpcHRv
ciBhcmUgYSBiaW5hcnkgZGF0YSBidWZmZXINCj4gdGhhdCBpcyBwYXNzZWQgdG8gdGhlIGxvYWRl
ZCBpbWFnZS4gSWYgdGhlIGZpZWxkIGlzIHplcm8gYnl0ZXMgbG9uZywgYSBOVUxMDQo+IHBvaW50
ZXIgaXMgcGFzc2VkIHRvIHRoZSBsb2FkZWQgaW1hZ2UuIFRoZSBudW1iZXIgb2YgYnl0ZXMgaW4g
T3B0aW9uYWxEYXRhDQo+IGNhbiBiZSBjb21wdXRlZCBieSBzdWJ0cmFjdGluZyB0aGUgc3RhcnRp
bmcgb2Zmc2V0IG9mIE9wdGlvbmFsRGF0YSBmcm9tIHRvdGFsDQo+IHNpemUgaW4gYnl0ZXMgb2Yg
dGhlIEVGSV9MT0FEX09QVElPTiIuDQo=
