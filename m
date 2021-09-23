Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4323415EAA
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 14:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhIWMqE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 08:46:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42402 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240787AbhIWMqD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Sep 2021 08:46:03 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 885924151D;
        Thu, 23 Sep 2021 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1632401072; bh=p8yypIUjB8D1QtzMPOfUh/V1qIMQJPRo2PqJWZ5SYsY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Gvq9P4b8YntKHRuxkqZ3tF0YGuSDOH+oVCDf+VSwXXjmaGxF2cK8X33R7WTWMZdxB
         GEf7t9gTDEWUF/5zMlhaPic0Gw9SioFA146VuyVbXAQDD0BMWeYiU9orEq2KpGk5hQ
         i5sYd3qIUy1129LF03W2RQe+YxmxznJiJIdmrk3SdS3mqJQGmbc2z3+ie826v+rXmf
         y2mWag8+iQ0DLDwtixGft2C9TjYEL1Y/KL5EtNn3IHbRSVbKs1VbfEHZw/WNdd8Ppi
         MF1tAfYhy87PyuwzOIovDHwB4mk2cbJzuZ3GcC+8Od9h1/aYntxCPPc7gvFZv9ewLf
         2ywh1lMEodcdA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DAA1AA005C;
        Thu, 23 Sep 2021 12:44:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5410280151;
        Thu, 23 Sep 2021 12:44:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XjlMBsSZ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql0OQazr/pNI1ie5lP8Ht8iY8eOUSaANgcsKDZeanbY5JGm2DYN7ViWFq0GSn7YuEdL/lqgPOUwfp6yIwIN7w682q4qOhfVMJJ030VSQuyLahcjVTcTLbj1waahXj9HMRlxKs4Vgg7OqUkLGVtxBHm8v4qbfy5zOmVpGOEgRFzdV+WPfmxr/w2EuS62IYorK7D6PicnCLwUU80cPNmSxzQBIwvJv9I4RLgCW7/OIo59UBGn6ngK54KflPmdMqyk3NB/if51/2tt090fXxKBAVjzRQMpUc9bdssSpKr5TVg7jvM9I1dvnobtwPMo1Rf+9jG2KB1ZQOFtNAl2+M4q1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p8yypIUjB8D1QtzMPOfUh/V1qIMQJPRo2PqJWZ5SYsY=;
 b=lB/dfGY6qGnlPCzk6jrqPkumxuD6Zle3JmpqYxFguRB+KFcNp6CEFP4jl5p0h3ScILyRfGJGJ6iKV9p6EUIXLi3OjLbHITHcmB3i9qnwN5UvUJ+iHOJpN9M6l6uzRQOqvLaLkjNjU0E+Phxy2TgG8aeY9o8aw+1/5wA0gAX08oYdQXqbqMe4QzUPO3Eju5H0KcnbEjLg54k/UTSE87WlvYxpA0bDlhO5ZZxMYqTaMkGZjoBOqwIIH33tyS1+bGTyH3MjjzIeRu+PbYAUtyPAxkMPpz55xCAno4NSztx5WB43EDkbi0NVyhaRoI8RaQ+rK40gjT3/SxJpzhaG68Z+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8yypIUjB8D1QtzMPOfUh/V1qIMQJPRo2PqJWZ5SYsY=;
 b=XjlMBsSZIIeMIcn3BV4fq6QTuHKmTlq2wcWFtDSMYpHRIbCRUXHI1j/6Nvc788nfl1iWUG0VjTTkqniwaPBMQvx+hnxM47SXxJ8BHG5lMxGTgpN1OoKMXR+iJA+dKngwgvBc0glcR5Dz2K32DkEYfbZDkaHe+kbDS5mZMs/JArQ=
Received: from CY4PR12MB1160.namprd12.prod.outlook.com (2603:10b6:903:38::12)
 by CY4PR1201MB0200.namprd12.prod.outlook.com (2603:10b6:910:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 12:44:19 +0000
Received: from CY4PR12MB1160.namprd12.prod.outlook.com
 ([fe80::2d3a:44fe:fd31:11e2]) by CY4PR12MB1160.namprd12.prod.outlook.com
 ([fe80::2d3a:44fe:fd31:11e2%7]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 12:44:19 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
Thread-Topic: [PATCH 3/3] memblock: cleanup memblock_free interface
Thread-Index: AQHXsE7r2Z9Q1x5PbkCRzXvVc2eiLKuxkQqA
Date:   Thu, 23 Sep 2021 12:44:18 +0000
Message-ID: <70364d6d-7569-3cd8-acce-559878ce4596@synopsys.com>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
In-Reply-To: <20210923074335.12583-4-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1e5f238-9c40-4f49-2da5-08d97e8fdc67
x-ms-traffictypediagnostic: CY4PR1201MB0200:
x-microsoft-antispam-prvs: <CY4PR1201MB02008C7112226A9E691D827CA6A39@CY4PR1201MB0200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OamkW3UO1/WqFADz4A194HFP4oBQk8gtqnKNjVuDksrLnfE6l+GVJQhwsaegPUSH7gx9t8lMJ1FdmgYJCgJ4OZ3EhKf8RZTD3Ts0zaaHTLojOQ5TBH4ZPl6xEabh2XoGqBvwUOEEFr9uSp9MQZp9dSBW+UcQqhYiFNaSTPWozfT9nTMipLej1e9xdNsDzJwkWvc4Nqfx9vJUpUl1b2y3wVZ1oitLTB5EUrRSlKgJTGqIekv1SR1YFUhPDs3nw9WEL9bXMu/EvTL8nA8XhyS8T5AggLricxDpUq9wYUHjECvPt7tEppOAD3ENQzfE8EgYlSeEkDpjU97d+AXoZrfhgqvMnmxfIN2HYaS9mEsbHWU/v+kC/37zYn4F+xyL7BZ7yyVP3OXhFEbyRjeA1fu5yW3MacAsdznAi8uIZTlBVJnpBYFOXwFAXJRBkzH6xa4sV/7hMat8LxK4cZD3yPIhI0AN4eK6rNxYmtVdMz7h6nIy+EuGpBn1s07XirzbDNP3itQCWqt0TOrchOPjGN3ZLRqsKltq5PAMjMXOxRZdN2dqnUFCweBuWWfCwgrV5044fj0vvvSEUUfHpFWJLJRnyg4c3Eh2g6Ee+cAC9QDPHcsmAgajEJma1cFC1eRoIfuvfIe6apmOy46ssLpPZuMbub2YhBZ5/KLzyz/ik0j7m6nXwWbxN1QdS/7wnLeRcvfuaqggkqHcyct/8HQb0MRs9FG7LhwusDW07wtmQYsIsLg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1160.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(71200400001)(86362001)(2906002)(83380400001)(54906003)(31686004)(110136005)(38070700005)(91956017)(66946007)(508600001)(66446008)(64756008)(66556008)(66476007)(76116006)(7416002)(5660300002)(8676002)(186003)(8936002)(31696002)(122000001)(6512007)(4744005)(36756003)(53546011)(6506007)(6486002)(2616005)(4326008)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3E1Q1p2dDJNR052VkZ1TG1nK2ZKSGJNWWxCdkIxdlgvemFlRHNZdG55SnAz?=
 =?utf-8?B?NFZnVDlEWVZHN3c5dTc1U2pCY2lTdkhTeXB3QU0xV1pocFhjTHZlUFkzSkhl?=
 =?utf-8?B?UDlnbWhORjBYYXFRUUFnNDM5ZFdHbFlZSVFEa3lIUUxnREc5d2ducFNGY0pt?=
 =?utf-8?B?V2NTVGdxdVFMNlRLemlvQ1M2VUJHMVVYL0ZkaXZ2dEVBQnc3Y0EvQVQzQmo5?=
 =?utf-8?B?dzZDbWtxejJRZnFkN210bmIwczlpMGprc0JqY3Rza01pV2JLU29CWkw0SFRJ?=
 =?utf-8?B?bnNoQVBFbzZIRnBndm5VR2tHWWo5ejdEWURZTktZbGthMkdKbU1rcFNTcWxQ?=
 =?utf-8?B?K0tyNG9pRTNuZEY5NXIxUEF6U1k3Nlg5RVlTT0hTTzlQUWYzNVdiRVlpY1ND?=
 =?utf-8?B?eHRxRmg1aHEvVE9mcTVmZU1kalNoR1NBZmwzSUZmSEFwa2xPL1ZuUWd6ZHll?=
 =?utf-8?B?TS9vNDMzNVY4SUxOVTA3S0hQVjRsODRLWC9abmp1MGg4R1c5YmhlM25sK1Jq?=
 =?utf-8?B?WE1BOEM2bWE3RDN6YWs1TUdCOUdZZm5LaW4wYUVuWVR1SFg3RVRoeXZOSTFY?=
 =?utf-8?B?MjNROHlxdHlWejJzN05uZlBQUGZPVXRSOHl5ZnRlTUFkVndJTHNyTS9CZWtn?=
 =?utf-8?B?ckYycndlMSt4bTk5TlEvZE1HOWFXZlRDRmJtOHY3MTdPZ3NhblhLVFZMYWx1?=
 =?utf-8?B?RFd1NXNBcjZCcjVYZWFyWDZGQzBTSmhzV09qZmZEUkdyOENUdFpteXNqQmFF?=
 =?utf-8?B?ejVtUldNT0swSzllQkNnc251RHhQZVJlN3JpdWlWVksyb3ZHMGZRcE0vOVJJ?=
 =?utf-8?B?U0xCQ0hnN294VDBXT1lOZXdKZEM4ZjZoOHdmVStLVnVSUElvNVZFRm1LWDBP?=
 =?utf-8?B?SVBaUjhXUHhHcEdId2hjRXorVkxiNTNISzFjTzkzb0dMMHBIRUtxZmF1aHRk?=
 =?utf-8?B?NEI0a3lZN0prRlNQTGtGTmNWT3VJSjYvVWltOWswWVAreU9BUkxaOHFhOFdq?=
 =?utf-8?B?TkZBZGdXVE9Icnlyd0YraDFNZHR5TDdrVGZmbVVJRXZDRXFtclFFc21TNEk0?=
 =?utf-8?B?WVdjOUJoRHdPdEpMY1pKMDFiK1RuMFZsbFRJMGRLVklCNTQ2bS9CanI4VENx?=
 =?utf-8?B?RkloOG1BZmU2ZnlRTmJCZjJXdDlYaFJnSzhkTFFTbFJSWFBFOGQrcS80NXVU?=
 =?utf-8?B?YjNqOHVwWVM0TkY1NktBVEVmMnVVV1ZYNWp4Z0xySVJFTC9BSm9qNkNzdmZM?=
 =?utf-8?B?MXFFOEIxWDdieU5BQ1pGZlFWWTFaZjhFbi9XUSs1Y0JHemtQUXhrNElVTzU2?=
 =?utf-8?B?K1JtOG1aQUN4UUVyR1ArNmpvbWdscWFPdlJWTi9mKytoSTN5ZUkvc2dvMDEw?=
 =?utf-8?B?c0lmWWFvcWxLRkNiUFU1VTF1QnRoMDJrVkpNK0FtN2FFUVhqKzV3ZHVVTzh4?=
 =?utf-8?B?RkxWQS9YcnZwcklycTcrZy8rWDhxSEdJalZaMllBQ0FHZEhHL1YzTTJsWUpT?=
 =?utf-8?B?MmNvbnFxYmk4ZllDcnJ5U2UycExRUHRmVEJLTEI4UHFOeDJUWjN3UjdkcU9T?=
 =?utf-8?B?RjBtOTJ0M3VPeTdNVVpSbHQxeXVsVDU3LzBMM2RnNkNCd1BuZlZEalZLbTNG?=
 =?utf-8?B?cHQwc3luVmpwc2ZJWVZEY3IzVENiRTdrRHp5NzM3b2xvRnA5LzlCcWpuTE43?=
 =?utf-8?B?ZkFzTUNlWkxVdlFGQ1NtdDBvZS95aGRTUkNaSlBIQ1NNY2FabGNSWFp5dVpr?=
 =?utf-8?Q?zxZX1W1RS474i7oyqAN1Twr11o31hFkPD6o09yZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEE0BCB4DA8E9D4FA42EB8E75B22E457@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1160.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e5f238-9c40-4f49-2da5-08d97e8fdc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 12:44:19.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXVpj8MQIzNFMgREFPcSyNOhb48DBCQjuuwYd+4/FTIRz+7n+fNOo/94DmdqxSrRhwhnoAWwsgrHeewqRJ+nSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0200
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gOS8yMy8yMSA5OjQzIEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBGcm9tOiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBGb3IgYWdlcyBtZW1ibG9ja19mcmVl
KCkgaW50ZXJmYWNlIGRlYWx0IHdpdGggcGh5c2ljYWwgYWRkcmVzc2VzIGV2ZW4NCj4gZGVzcGl0
ZSB0aGUgZXhpc3RlbmNlIG9mIG1lbWJsb2NrX2FsbG9jX3h4KCkgZnVuY3Rpb25zIHRoYXQgcmV0
dXJuIGENCj4gdmlydHVhbCBwb2ludGVyLg0KPiANCj4gSW50cm9kdWNlIG1lbWJsb2NrX3BoeXNf
ZnJlZSgpIGZvciBmcmVlaW5nIHBoeXNpY2FsIHJhbmdlcyBhbmQgcmVwdXJwb3NlDQo+IG1lbWJs
b2NrX2ZyZWUoKSB0byBmcmVlIHZpcnR1YWwgcG9pbnRlcnMgdG8gbWFrZSB0aGUgZm9sbG93aW5n
IHBhaXJpbmcNCj4gYWJ1bmRhbnRseSBjbGVhcjoNCj4gDQo+IAlpbnQgbWVtYmxvY2tfcGh5c19m
cmVlKHBoeXNfYWRkcl90IGJhc2UsIHBoeXNfYWRkcl90IHNpemUpOw0KPiAJcGh5c19hZGRyX3Qg
bWVtYmxvY2tfcGh5c19hbGxvYyhwaHlzX2FkZHJfdCBiYXNlLCBwaHlzX2FkZHJfdCBzaXplKTsN
Cj4gDQo+IAl2b2lkICptZW1ibG9ja19hbGxvYyhwaHlzX2FkZHJfdCBzaXplLCBwaHlzX2FkZHJf
dCBhbGlnbik7DQo+IAl2b2lkIG1lbWJsb2NrX2ZyZWUodm9pZCAqcHRyLCBzaXplX3Qgc2l6ZSk7
DQo+IA0KPiBSZXBsYWNlIGludGVybWVkaWF0ZSBtZW1ibG9ja19mcmVlX3B0cigpIHdpdGggbWVt
YmxvY2tfZnJlZSgpIGFuZCBkcm9wDQo+IHVubmVjZXNzYXJ5IGFsaWFzZXMgbWVtYmxvY2tfZnJl
ZV9lYXJseSgpIGFuZCBtZW1ibG9ja19mcmVlX2Vhcmx5X25pZCgpLg0KPiANCj4gU3VnZ2VzdGVk
LWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNp
Z25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCg0KYXJjaC9h
cmMgcGFydDogUmV2aWV3ZWQtYnk6IFNoYWhhYiBWYWhlZGkgPHNoYWhhYkBzeW5vcHN5cy5jb20+
DQoNCg0KVGhhbmtzLA0KU2hhaGFiDQo=
