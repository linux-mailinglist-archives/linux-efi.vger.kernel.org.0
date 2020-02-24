Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78AFF16A508
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBXLin (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 06:38:43 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:52694 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLin (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 06:38:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id C89711080215;
        Mon, 24 Feb 2020 13:38:40 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Tk_QqCuKFQR9; Mon, 24 Feb 2020 13:38:40 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id D147B10808D5;
        Mon, 24 Feb 2020 13:38:39 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com D147B10808D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1582544319;
        bh=+tskScq4uIA9/TPrFKSW1RmSTzCHD1HXtfjqxrFsbFE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MhAaKCxKw3wcjYk2jSTLQEqlUfJjL0pDFFhUxpYohYorUAybcha+kbxcRw3jeMCkH
         CJoZ2PVhyqs/Gss/Dqf0nH3u+4Sbs9kog60cuP3O5kSYBLJr/rJBKoGYPWfodQ1/G+
         Km34EfwPHjpqI+52fz4LUVu7qHh2yWG9ejCE6TPTKzM3CzOTwNz3gfze14GgLWWcGW
         /e1+ui1AdXK1rHtMAjPfuwZOSOVDE3T9AtxSFHb9EH88PfM8dgnH2NqdO28srur5hI
         KJaW70RSa9HuivPsaoJyoATUvgN60y/Gscqly6wsbyPPOG/yrgkP1X5ri8IpPmwNtK
         xvp34tyPd6s3Q==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6d9Agr_Au4KF; Mon, 24 Feb 2020 13:38:39 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
        by mail.inango-sw.com (Postfix) with ESMTP id A834F1080215;
        Mon, 24 Feb 2020 13:38:39 +0200 (IST)
Date:   Mon, 24 Feb 2020 13:38:39 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     hch <hch@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <20200218185336.GA14242@infradead.org>
References: <20181124162123.21300-1-n.merinov@inango-systems.com> <20191224092119.4581-1-n.merinov@inango-systems.com> <20200108133926.GC4455@infradead.org> <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com> <20200218185336.GA14242@infradead.org>
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_1324732_122210119.1582544319433"
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - GC80 (Linux)/8.8.15_GA_3890)
Thread-Topic: partitions/efi: Fix partition name parsing in GUID partition entry
Thread-Index: RHN8sBujnu07ZUv014i9wZGHW1Y/bw==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

------=_Part_1324732_122210119.1582544319433
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Christoph, 

> I'd rather use plain __le16 and le16_to_cpu here. Also the be 
> variants seems to be entirely unused. 

Looks like I misunderstood your comment from https://patchwork.kernel.org/patch/11309223/: 

> Please add a an efi_char_from_cpu or similarly named helper 
> to encapsulate this logic. 

The "le16_to_cpu(ptes[i].partition_name[label_count])" call is the 
full implementation of the "efi_char_from_cpu" logic. Do you want 
to encapsulate "utf16_le_to_7bit_string" logic entirely like in
the attached version?

Regards,
Nikolai

------=_Part_1324732_122210119.1582544319433
Content-Type: text/x-patch;
 name=v4-0001-partitions-efi-Fix-partition-name-parsing-in-GUID.patch
Content-Disposition: attachment;
 filename=v4-0001-partitions-efi-Fix-partition-name-parsing-in-GUID.patch
Content-Transfer-Encoding: base64

RnJvbSA4NDJjZjIyZDZmNmY5MTg3MmJjYjA0YWM2YWJlNzc5NGZlZGUyM2ZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGFpIE1lcmlub3YgPG4ubWVyaW5vdkBpbmFuZ28tc3lz
dGVtcy5jb20+CkRhdGU6IFNhdCwgMjQgTm92IDIwMTggMjA6NDI6MjcgKzA1MDAKU3ViamVjdDog
W1BBVENIIHY0XSBwYXJ0aXRpb25zL2VmaTogRml4IHBhcnRpdGlvbiBuYW1lIHBhcnNpbmcgaW4g
R1VJRAogcGFydGl0aW9uIGVudHJ5CgpHVUlEIHBhcnRpdGlvbiBlbnRyeSBkZWZpbmVkIHRvIGhh
dmUgYSBwYXJ0aXRpb24gbmFtZSBhcyAzNiBVVEYtMTZMRQpjb2RlIHVuaXRzLiBUaGlzIG1lYW5z
IHRoYXQgb24gYmlnLWVuZGlhbiBwbGF0Zm9ybXMgQVNDSUkgc3ltYm9scwp3b3VsZCBiZSByZWFk
IHdpdGggMHhYWDAwIGVmaV9jaGFyMTZfdCBjaGFyYWN0ZXIgY29kZS4gSW4gb3JkZXIgdG8KY29y
cmVjdGx5IGV4dHJhY3QgQVNDSUkgY2hhcmFjdGVycyBmcm9tIGEgcGFydGl0aW9uIG5hbWUgZmll
bGQgd2UKc2hvdWxkIGJlIGNvbnZlcnRlZCBmcm9tIDE2TEUgdG8gQ1BVIGFyY2hpdGVjdHVyZS4K
ClRoZSBwcm9ibGVtIGV4aXN0cyBvbiBhbGwgYmlnIGVuZGlhbiBwbGF0Zm9ybXMuCgpTaWduZWQt
b2ZmLWJ5OiBOaWtvbGFpIE1lcmlub3YgPG4ubWVyaW5vdkBpbmFuZ28tc3lzdGVtcy5jb20+CkZp
eGVzOiBlZWM3ZWNmZWRlNzQgKCJnZW5oZCwgZWZpOiBhZGQgZWZpIHBhcnRpdGlvbiBtZXRhZGF0
YSB0byBoZF9zdHJ1Y3RzIikKLS0tCiBibG9jay9wYXJ0aXRpb25zL2VmaS5jIHwgMzUgKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIGJsb2NrL3BhcnRpdGlvbnMvZWZpLmggfCAg
MiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9ibG9jay9wYXJ0aXRpb25zL2VmaS5jIGIvYmxvY2svcGFydGl0aW9ucy9l
ZmkuYwppbmRleCBkYjJmZWY3ZGZjNDcuLmQyNmEwNjU0ZDdjYSAxMDA2NDQKLS0tIGEvYmxvY2sv
cGFydGl0aW9ucy9lZmkuYworKysgYi9ibG9jay9wYXJ0aXRpb25zL2VmaS5jCkBAIC02NTYsNiAr
NjU2LDMwIEBAIHN0YXRpYyBpbnQgZmluZF92YWxpZF9ncHQoc3RydWN0IHBhcnNlZF9wYXJ0aXRp
b25zICpzdGF0ZSwgZ3B0X2hlYWRlciAqKmdwdCwKICAgICAgICAgcmV0dXJuIDA7CiB9CiAKKy8q
KgorICogdXRmMTZfbGVfdG9fN2JpdCgpOiBOYWl2ZWx5IGNvbnZlcnRzIFVURi0xNkxFIHN0cmlu
ZyB0byA3Yml0IGNoYXJhY3RlcnMKKyAqIEBpbjogaW5wdXQgVVRGLTE2TEUgc3RyaW5nCisgKiBA
c2l6ZTogc2l6ZSBvZiB0aGUgaW5wdXQgc3RyaW5nCisgKiBAb3V0OiBvdXRwdXQgc3RyaW5nIHB0
ciwgc2hvdWxkIGJlIGNhcGFibGUgdG8gc3RvcmUgQHNpemUrMSBjaGFyYWN0ZXJzCisgKgorICog
RGVzY3JpcHRpb246IENvbnZlcnRzIEBzaXplIFVURjE2LUxFIHN5bWJvbHMgZnJvbSBAaW4gc3Ry
aW5nIHRvIDdiaXQKKyAqIGNoYXJhY3RlcnMgYW5kIHN0b3JlIHRoZW0gdG8gQG91dC4gQWRkcyB0
cmFpbGluZyB6ZXJvIHRvIEBvdXQgYXJyYXkuCisgKi8KK3N0YXRpYyB2b2lkIHV0ZjE2X2xlX3Rv
XzdiaXQoY29uc3QgX19sZTE2ICppbiwgdW5zaWduZWQgaW50IHNpemUsIHU4ICpvdXQpCit7CisJ
dW5zaWduZWQgaW50IGkgPSAwOworCisJb3V0W3NpemVdID0gMDsKKwl3aGlsZSAoaSA8IHNpemUp
IHsKKwkJdTggYyA9IGxlMTZfdG9fY3B1KGluW2ldKSAmIDB4ZmY7CisKKwkJaWYgKGMgJiYgIWlz
cHJpbnQoYykpCisJCQljID0gJyEnOworCQlvdXRbaV0gPSBjOworCQlpKys7CisJfQorfQorCiAv
KioKICAqIGVmaV9wYXJ0aXRpb24oc3RydWN0IHBhcnNlZF9wYXJ0aXRpb25zICpzdGF0ZSkKICAq
IEBzdGF0ZTogZGlzayBwYXJzZWQgcGFydGl0aW9ucwpAQCAtNjkyLDcgKzcxNiw2IEBAIGludCBl
ZmlfcGFydGl0aW9uKHN0cnVjdCBwYXJzZWRfcGFydGl0aW9ucyAqc3RhdGUpCiAKIAlmb3IgKGkg
PSAwOyBpIDwgbGUzMl90b19jcHUoZ3B0LT5udW1fcGFydGl0aW9uX2VudHJpZXMpICYmIGkgPCBz
dGF0ZS0+bGltaXQtMTsgaSsrKSB7CiAJCXN0cnVjdCBwYXJ0aXRpb25fbWV0YV9pbmZvICppbmZv
OwotCQl1bnNpZ25lZCBsYWJlbF9jb3VudCA9IDA7CiAJCXVuc2lnbmVkIGxhYmVsX21heDsKIAkJ
dTY0IHN0YXJ0ID0gbGU2NF90b19jcHUocHRlc1tpXS5zdGFydGluZ19sYmEpOwogCQl1NjQgc2l6
ZSA9IGxlNjRfdG9fY3B1KHB0ZXNbaV0uZW5kaW5nX2xiYSkgLQpAQCAtNzEzLDE0ICs3MzYsOCBA
QCBpbnQgZWZpX3BhcnRpdGlvbihzdHJ1Y3QgcGFyc2VkX3BhcnRpdGlvbnMgKnN0YXRlKQogCQkv
KiBOYWl2ZWx5IGNvbnZlcnQgVVRGMTYtTEUgdG8gNyBiaXRzLiAqLwogCQlsYWJlbF9tYXggPSBt
aW4oQVJSQVlfU0laRShpbmZvLT52b2xuYW1lKSAtIDEsCiAJCQkJQVJSQVlfU0laRShwdGVzW2ld
LnBhcnRpdGlvbl9uYW1lKSk7Ci0JCWluZm8tPnZvbG5hbWVbbGFiZWxfbWF4XSA9IDA7Ci0JCXdo
aWxlIChsYWJlbF9jb3VudCA8IGxhYmVsX21heCkgewotCQkJdTggYyA9IHB0ZXNbaV0ucGFydGl0
aW9uX25hbWVbbGFiZWxfY291bnRdICYgMHhmZjsKLQkJCWlmIChjICYmICFpc3ByaW50KGMpKQot
CQkJCWMgPSAnISc7Ci0JCQlpbmZvLT52b2xuYW1lW2xhYmVsX2NvdW50XSA9IGM7Ci0JCQlsYWJl
bF9jb3VudCsrOwotCQl9CisJCXV0ZjE2X2xlX3RvXzdiaXQocHRlc1tpXS5wYXJ0aXRpb25fbmFt
ZSwgbGFiZWxfbWF4LAorCQkJCSBpbmZvLT52b2xuYW1lKTsKIAkJc3RhdGUtPnBhcnRzW2kgKyAx
XS5oYXNfaW5mbyA9IHRydWU7CiAJfQogCWtmcmVlKHB0ZXMpOwpkaWZmIC0tZ2l0IGEvYmxvY2sv
cGFydGl0aW9ucy9lZmkuaCBiL2Jsb2NrL3BhcnRpdGlvbnMvZWZpLmgKaW5kZXggM2U4NTc2MTU3
NTc1Li4wYjZkNWI3YmUxMTEgMTAwNjQ0Ci0tLSBhL2Jsb2NrL3BhcnRpdGlvbnMvZWZpLmgKKysr
IGIvYmxvY2svcGFydGl0aW9ucy9lZmkuaApAQCAtODgsNyArODgsNyBAQCB0eXBlZGVmIHN0cnVj
dCBfZ3B0X2VudHJ5IHsKIAlfX2xlNjQgc3RhcnRpbmdfbGJhOwogCV9fbGU2NCBlbmRpbmdfbGJh
OwogCWdwdF9lbnRyeV9hdHRyaWJ1dGVzIGF0dHJpYnV0ZXM7Ci0JZWZpX2NoYXIxNl90IHBhcnRp
dGlvbl9uYW1lWzcyIC8gc2l6ZW9mIChlZmlfY2hhcjE2X3QpXTsKKwlfX2xlMTYgcGFydGl0aW9u
X25hbWVbNzIgLyBzaXplb2YgKF9fbGUxNildOwogfSBfX3BhY2tlZCBncHRfZW50cnk7CiAKIHR5
cGVkZWYgc3RydWN0IF9ncHRfbWJyX3JlY29yZCB7Ci0tIAoyLjE3LjEKCg==
------=_Part_1324732_122210119.1582544319433--
