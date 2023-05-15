Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC77023F7
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 07:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbjEOF6y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 01:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjEOF6F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 01:58:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA113C05;
        Sun, 14 May 2023 22:53:23 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F5bskD025328;
        Mon, 15 May 2023 05:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=q3H+xIORkMzcp3691ze5/gMwihbYSeD8yDntiIoVREk=;
 b=EiHAVVXRqXKHNIoTqlSAJfl82aOLMAltuyugjl0rx6vrbPjwXpYSGW0JaCXsE60pT7hm
 YZutgXmLHILf3dmO250dTmmJnVV8iArqtQZ0ac1VMWVpspZVa5AVMaSghVGNoKWm8VjR
 BDJ+qjJe2QNualHHBlm53DUxhuEu646VXxTa3oIuLey+OueLBy+/5cc5ww6v82K1chLd
 cyYvFf+g8juwhephylwn3EE9XWjh8e7RDK4/O/0ToiDHhjWOuruowQV8kHXyZyPNI10C
 fP6me4vTHq2MtwPCzn8SyVjdt7hUIimuTQCGSXjXMr74ZeX/T+yWn009EOnk69T4XwBt wg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qke6214rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 05:53:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34F2aKpS018062;
        Mon, 15 May 2023 05:53:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdrv1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 05:53:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34F5r0eW7078598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 05:53:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59FF220040;
        Mon, 15 May 2023 05:53:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4CC20049;
        Mon, 15 May 2023 05:52:59 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 15 May 2023 05:52:59 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9F231603DA;
        Mon, 15 May 2023 15:52:57 +1000 (AEST)
Message-ID: <aebe6be66ad982dafa072848246255b9a32e8903.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] powerpc/pseries: update SED for PLPKS api changes
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-efi@vger.kernel.org, keyrings@vger.kernel.org,
        me@benboeckel.net, elliott@hpe.com, nayna@linux.ibm.com
Date:   Mon, 15 May 2023 15:52:48 +1000
In-Reply-To: <20230505194402.2079010-5-gjoyce@linux.vnet.ibm.com>
References: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
         <20230505194402.2079010-5-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5gaxDZEal1Fwm6DAc1NS1UMOtQbZ91wL
X-Proofpoint-ORIG-GUID: 5gaxDZEal1Fwm6DAc1NS1UMOtQbZ91wL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTA1IGF0IDE0OjQ0IC0wNTAwLCBnam95Y2VAbGludXgudm5ldC5pYm0u
Y29tIHdyb3RlOgo+IEZyb206IEdyZWcgSm95Y2UgPGdqb3ljZUBsaW51eC52bmV0LmlibS5jb20+
Cj4gCj4gQ2hhbmdlcyB0byB0aGUgUExQS1MgQVBJIHJlcXVpcmUgbWlub3IgdXBkYXRlcyB0byB0
aGUgU0VEIE9wYWwKPiBQTFBLUyBrZXlzdG9yZSBjb2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdy
ZWcgSm95Y2UgPGdqb3ljZUBsaW51eC52bmV0LmlibS5jb20+CgpbKyBOYXluYV0KClRoaXMgcGF0
Y2ggd2lsbCBuZWVkIHRvIGJlIHNxdWFzaGVkIHdpdGggcGF0Y2ggMi4KCj4gLS0tCj4gwqBhcmNo
L3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgIHzCoCA2ICsr
KysrCj4gwqBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvTWFrZWZpbGXCoMKgwqDCoMKg
wqAgfMKgIDIgKy0KPiDCoC4uLi9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzX3NlZF9v
cHMuYyB8IDIyICsrKysrLS0tLS0tLS0tLS0tCj4gLS0KPiDCoGJsb2NrL0tjb25maWfCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsKPiDCoDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9L
Y29uZmlnCj4gYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvS2NvbmZpZwo+IGluZGV4
IDIxYjIyYmYxNmNlNi4uYzJmOGEyOWU3YjliIDEwMDY0NAo+IC0tLSBhL2FyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvcHNlcmllcy9LY29uZmlnCj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9w
c2VyaWVzL0tjb25maWcKPiBAQCAtMTYzLDYgKzE2MywxMiBAQCBjb25maWcgUFNFUklFU19QTFBL
Uwo+IMKgwqDCoMKgwqDCoMKgwqAjIFRoaXMgb3B0aW9uIGlzIHNlbGVjdGVkIGJ5IGluLWtlcm5l
bCBjb25zdW1lcnMgdGhhdCByZXF1aXJlCj4gwqDCoMKgwqDCoMKgwqDCoCMgYWNjZXNzIHRvIHRo
ZSBQS1MuCj4gwqAKPiArY29uZmlnIFBTRVJJRVNfUExQS1NfU0VECj4gK8KgwqDCoMKgwqDCoMKg
ZGVwZW5kcyBvbiBQUENfUFNFUklFUwo+ICvCoMKgwqDCoMKgwqDCoGJvb2wKPiArwqDCoMKgwqDC
oMKgwqAjIFRoaXMgb3B0aW9uIGlzIHNlbGVjdGVkIGJ5IGluLWtlcm5lbCBjb25zdW1lcnMgdGhh
dCByZXF1aXJlCj4gK8KgwqDCoMKgwqDCoMKgIyBhY2Nlc3MgdG8gdGhlIFNFRCBQS1Mga2V5c3Rv
cmUuCj4gKwo+IMKgY29uZmlnIFBBUFJfU0NNCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24g
UFBDX1BTRVJJRVMgJiYgTUVNT1JZX0hPVFBMVUcgJiYgTElCTlZESU1NCj4gwqDCoMKgwqDCoMKg
wqDCoHRyaXN0YXRlICJTdXBwb3J0IGZvciB0aGUgUEFQUiBTdG9yYWdlIENsYXNzIE1lbW9yeQo+
IGludGVyZmFjZSIKPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVz
L01ha2VmaWxlCj4gYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvTWFrZWZpbGUKPiBp
bmRleCA0MjQyYWVkMGQ1ZDMuLjE0NzZjNWU0NDMzYyAxMDA2NDQKPiAtLS0gYS9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3BzZXJpZXMvTWFrZWZpbGUKPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zL3BzZXJpZXMvTWFrZWZpbGUKPiBAQCAtMjksNyArMjksNyBAQCBvYmotJChDT05GSUdfUFBD
X1NWTSnCoMKgwqDCoMKgwqDCoMKgwqArPSBzdm0ubwo+IMKgb2JqLSQoQ09ORklHX0ZBX0RVTVAp
wqDCoMKgwqDCoMKgwqDCoMKgwqArPSBydGFzLWZhZHVtcC5vCj4gwqBvYmotJChDT05GSUdfUFNF
UklFU19QTFBLUynCoMKgwqDCoCs9IHBscGtzLm8KPiDCoG9iai0kKENPTkZJR19QUENfU0VDVVJF
X0JPT1QpwqDCoCs9IHBscGtzLXNlY3Zhci5vCj4gLW9iai0kKENPTkZJR19QU0VSSUVTX1BMUEtT
X1NFRCnCoMKgwqDCoMKgwqDCoMKgKz0gcGxwa3Mtc2VkLm8KPiArb2JqLSQoQ09ORklHX1BTRVJJ
RVNfUExQS1NfU0VEKcKgwqDCoMKgwqDCoMKgwqArPSBwbHBrc19zZWRfb3BzLm8KCkkgdGhpbmsg
eW91IGNvdWxkIGp1c3QgdXNlIG9iai0kKENPTkZJR19CTEtfU0VEX09QQUwpIGFuZCB0aGVuIHRo
ZXJlCndvdWxkbid0IGJlIGEgbmVlZCB0byBpbnRyb2R1Y2UgYSBuZXcgb3B0aW9uPyBVbmxlc3Mg
dGhlcmUncyBnb2luZyB0bwpiZSBhIHNlY29uZCBjb25zdW1lci4KCj4gwqBvYmotJChDT05GSUdf
U1VTUEVORCnCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHN1c3BlbmQubwo+IMKgb2JqLSQoQ09ORklH
X1BQQ19WQVMpwqDCoMKgwqDCoMKgwqDCoMKgwqArPSB2YXMubyB2YXMtc3lzZnMubwo+IMKgCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wbHBrc19zZWRfb3Bz
LmMKPiBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wbHBrc19zZWRfb3BzLmMKPiBp
bmRleCAwODY5MzRiMzE5YTkuLmMxZDA4MDc1ZTg1MCAxMDA2NDQKPiAtLS0gYS9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3BzZXJpZXMvcGxwa3Nfc2VkX29wcy5jCj4gKysrIGIvYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzX3NlZF9vcHMuYwo+IEBAIC0xNCw3ICsxNCw3IEBACj4g
wqAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvaW9jdGwuaD4K
PiDCoCNpbmNsdWRlIDxsaW51eC9zZWQtb3BhbC1rZXkuaD4KPiAtI2luY2x1ZGUgInBscGtzLmgi
Cj4gKyNpbmNsdWRlIDxhc20vcGxwa3MuaD4KPiDCoAo+IMKgLyoKPiDCoCAqIHN0cnVjdHVyZSB0
aGF0IGNvbnRhaW5zIGFsbCBTRUQgZGF0YQo+IEBAIC0yOCw5ICsyOCw2IEBAIHN0cnVjdCBwbHBr
c19zZWRfb2JqZWN0X2RhdGEgewo+IMKgwqDCoMKgwqDCoMKgwqB1X2NoYXIga2V5WzMyXTsKPiDC
oH07Cj4gwqAKPiAtI2RlZmluZSBQTFBLU19QTEFUVkFSX1BPTElDWcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgV09STERSRUFEQUJMRQo+IC0jZGVmaW5lIFBMUEtTX1BMQVRWQVJfT1NfQ09NTU9OwqDC
oMKgwqDCoMKgwqDCoCA0Cj4gLQo+IMKgI2RlZmluZSBQTFBLU19TRURfT0JKRUNUX0RBVEFfVjDC
oMKgwqDCoMKgwqDCoCAwCj4gwqAjZGVmaW5lIFBMUEtTX1NFRF9NQU5HTEVEX0xBQkVMwqDCoMKg
wqDCoMKgwqDCoCAiL2RlZmF1bHQvcHJpIgo+IMKgI2RlZmluZSBQTFBLU19TRURfQ09NUE9ORU5U
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJzZWQtb3BhbCIKPiBAQCAtNTAsOCArNDcsOCBAQCB2
b2lkIHBscGtzX2luaXRfdmFyKHN0cnVjdCBwbHBrc192YXIgKnZhciwgY2hhcgo+ICprZXluYW1l
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmFyLT5uYW1lID0gUExQS1NfU0VE
X01BTkdMRURfTEFCRUw7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2YXItPm5h
bWVsZW4gPSBzdHJsZW4oa2V5bmFtZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiAtwqDCoMKgwqDC
oMKgwqB2YXItPnBvbGljeSA9IFBMUEtTX1BMQVRWQVJfUE9MSUNZOwo+IC3CoMKgwqDCoMKgwqDC
oHZhci0+b3MgPSBQTFBLU19QTEFUVkFSX09TX0NPTU1PTjsKPiArwqDCoMKgwqDCoMKgwqB2YXIt
PnBvbGljeSA9IFBMUEtTX1dPUkxEUkVBREFCTEU7Cj4gK8KgwqDCoMKgwqDCoMKgdmFyLT5vcyA9
IFBMUEtTX1ZBUl9DT01NT047Cj4gwqDCoMKgwqDCoMKgwqDCoHZhci0+ZGF0YSA9IE5VTEw7Cj4g
wqDCoMKgwqDCoMKgwqDCoHZhci0+ZGF0YWxlbiA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoHZhci0+
Y29tcG9uZW50ID0gUExQS1NfU0VEX0NPTVBPTkVOVDsKPiBAQCAtNjQsMjggKzYxLDE5IEBAIGlu
dCBzZWRfcmVhZF9rZXkoY2hhciAqa2V5bmFtZSwgY2hhciAqa2V5LCB1X2ludAo+ICprZXlsZW4p
Cj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwbHBrc192YXIgdmFyOwo+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgcGxwa3Nfc2VkX29iamVjdF9kYXRhIGRhdGE7Cj4gLcKgwqDCoMKgwqDC
oMKgdV9pbnQgb2Zmc2V0Owo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IMKgwqDCoMKgwqDC
oMKgwqB1X2ludCBsZW47Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcGxwa3NfaW5pdF92YXIoJnZh
ciwga2V5bmFtZSk7Cj4gLcKgwqDCoMKgwqDCoMKgdmFyLmRhdGEgPSAmZGF0YTsKPiArwqDCoMKg
wqDCoMKgwqB2YXIuZGF0YSA9ICh1OCAqKSZkYXRhOwo+IMKgwqDCoMKgwqDCoMKgwqB2YXIuZGF0
YWxlbiA9IHNpemVvZihkYXRhKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXQgPSBwbHBrc19y
ZWFkX29zX3ZhcigmdmFyKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCAhPSAwKQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoAo+IC3CoMKgwqDCoMKg
wqDCoG9mZnNldCA9IG9mZnNldG9mKHN0cnVjdCBwbHBrc19zZWRfb2JqZWN0X2RhdGEsIGtleSk7
Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKG9mZnNldCA+IHZhci5kYXRhbGVuKSB7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IC3CoMKgwqDCoMKgwqDCoH0K
PiAtCj4gLcKgwqDCoMKgwqDCoMKgbGVuID0gbWluKGJlMzJfdG9fY3B1KGRhdGEua2V5X2xlbiks
ICprZXlsZW4pOwo+IC0KPiArwqDCoMKgwqDCoMKgwqBsZW4gPSBtaW5fdCh1MTYsIGJlMzJfdG9f
Y3B1KGRhdGEua2V5X2xlbiksIHZhci5kYXRhbGVuKTsKPiDCoMKgwqDCoMKgwqDCoMKgbWVtY3B5
KGtleSwgZGF0YS5rZXksIGxlbik7Cj4gLcKgwqDCoMKgwqDCoMKga2ZyZWUodmFyLmRhdGEpOwo+
IC0KPiDCoMKgwqDCoMKgwqDCoMKga2V5W2xlbl0gPSAnXDAnOwo+IMKgwqDCoMKgwqDCoMKgwqAq
a2V5bGVuID0gbGVuOwo+IMKgCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL0tjb25maWcgYi9ibG9jay9L
Y29uZmlnCj4gaW5kZXggNzZiMjMxMTRmZGViLi43NWQ0ZGIzNGRmNWEgMTAwNjQ0Cj4gLS0tIGEv
YmxvY2svS2NvbmZpZwo+ICsrKyBiL2Jsb2NrL0tjb25maWcKPiBAQCAtMTgyLDYgKzE4Miw3IEBA
IGNvbmZpZyBCTEtfU0VEX09QQUwKPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCAiTG9naWMgZm9yIGlu
dGVyZmFjaW5nIHdpdGggT3BhbCBlbmFibGVkIFNFRHMiCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVu
ZHMgb24gS0VZUwo+IMKgwqDCoMKgwqDCoMKgwqBzZWxlY3QgUFNFUklFU19QTFBLUyBpZiBQUENf
UFNFUklFUwo+ICvCoMKgwqDCoMKgwqDCoHNlbGVjdCBQU0VSSUVTX1BMUEtTX1NFRCBpZiBQUENf
UFNFUklFUwo+IMKgwqDCoMKgwqDCoMKgwqBoZWxwCj4gwqDCoMKgwqDCoMKgwqDCoEJ1aWxkcyBM
b2dpYyBmb3IgaW50ZXJmYWNpbmcgd2l0aCBPcGFsIGVuYWJsZWQgY29udHJvbGxlcnMuCj4gwqDC
oMKgwqDCoMKgwqDCoEVuYWJsaW5nIHRoaXMgb3B0aW9uIGVuYWJsZXMgdXNlcnMgdG8gc2V0dXAv
dW5sb2NrL2xvY2sKCi0tIApBbmRyZXcgRG9ubmVsbGFuICAgIE96TGFicywgQURMIENhbmJlcnJh
CmFqZEBsaW51eC5pYm0uY29tICAgSUJNIEF1c3RyYWxpYSBMaW1pdGVkCg==

