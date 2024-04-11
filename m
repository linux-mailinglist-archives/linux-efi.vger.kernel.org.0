Return-Path: <linux-efi+bounces-938-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6958A13DD
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4E7289EF5
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC214B061;
	Thu, 11 Apr 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iam.tj header.i=@iam.tj header.b="TVtoJ9bj"
X-Original-To: linux-efi@vger.kernel.org
Received: from iam.tj (yes.iam.tj [109.74.197.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F814B09C
	for <linux-efi@vger.kernel.org>; Thu, 11 Apr 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.197.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836958; cv=none; b=qo8QKGbbl/Gqwuv/0X3VHJc7bBL56FskDesP1spDtBXgkUvwUSb4ikfw3BpDpNaxh6PZ3dA8t1EQ+VCQ6Ws8Hl5Z79BRpM4XoEfDXJOsW2NMsLO3AqjEeNAs/XZF8l+1h6+bKxdlXubW0ERNKsblLk8uUqfdL23E9E9C7TrfpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836958; c=relaxed/simple;
	bh=OS0CbYOvbW6s2Xi8WPDzUXh8p2n4qOxDjBxZaUKrcF8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject:Cc; b=rWFV7YRUIZkr1qRMS79vLuY6xz3oU+ncBP2x+AiCDSuvX9dqDwmt0970Z9d+F4n0Ndd/VUOrTCJ7Ih1mLsk33ajpIOvg5yedv7Qh3IJwuErGVB+h72siQbfOxuRYUnGecIaSGMISPQ/Y7YCzxoR/QXdkoJmCy1NFB1jVI+IfmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iam.tj; spf=pass smtp.mailfrom=iam.tj; dkim=pass (2048-bit key) header.d=iam.tj header.i=@iam.tj header.b=TVtoJ9bj; arc=none smtp.client-ip=109.74.197.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iam.tj
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iam.tj
Received: from [IPV6:2a0d:3344:11e:1ff0::ff] (unknown [IPv6:2a0d:3344:11e:1ff0::ff])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 9AA57347BC;
	Thu, 11 Apr 2024 13:02:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
	t=1712836951; bh=OS0CbYOvbW6s2Xi8WPDzUXh8p2n4qOxDjBxZaUKrcF8=;
	h=Date:To:From:Subject:Cc:From;
	b=TVtoJ9bjtjCufFvH/b5HI38GtZthLiu14XleZ8cX46ER3QWh1raQp/qfjAV2HsFBk
	 pwiqHipVMRsKyCDoSbw4kyPcWDUIcnXcnLO3QVY0rhlmqN6GoHvwFuRGWpq6RDZSfe
	 L345Lmpx9ysgc/ciPXDJRZoO903E04lhgGGBKWaVYUCBW96E6iGPxUWmtbUGthbX9w
	 fm/1W1i4rMGrl/qF/sDSxmlF40AYy/ZD/rMuy884l2avH3X5B3MRO6D0qCYDRoNkFX
	 PVbLBdJR8pQBCGm1NRuZaLtG0izvT6BmOdUr/LM9FaQ+bSCiYrrgFnVzY0l8Mp0ofH
	 KGq8RnuHza4DA==
Content-Type: multipart/mixed; boundary="------------0FukH855E0HzJy0Qr0y4CvXz"
Message-ID: <c3796ac1-521f-4cba-9c74-3eb92072bb85@iam.tj>
Date: Thu, 11 Apr 2024 13:02:28 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-efi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
From: Tj <linux@iam.tj>
Subject: Regression: ef/x86: Remove EfiMemoryMappedIO from E820 map
Cc: Mateus Kaduk <mateusz.kaduk@gmail.com>

This is a multi-part message in MIME format.
--------------0FukH855E0HzJy0Qr0y4CvXz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Lenovo Legion 9i fails to set up e820 EFI MMIO regions since v6.2 due to
commit 07eab0901ede8b75 "efi/x86: Remove EfiMemoryMappedIO from E820 map"

Mateusz Kaduk bisected v6.1..v6.2 and pinpointed this on his Legion 9i and confirms this patch fixes all the reported issues.

https://bugzilla.kernel.org/show_bug.cgi?id=218444

This patch is more of a proof of cause since it is quite coarse; it simply disables the effects of 07eab0901ede8b75 with "keep_efi_e820" on command-line; maybe there is a better way than arbitrarily
removing mappings larger than 256KiB? I wonder if the removal should be done later once the regions
have been read, or if there is some inherent metadata in the regions to describe what range(s) need
to be retained.




--------------0FukH855E0HzJy0Qr0y4CvXz
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-efi-x86-add-param-keep_efi_e820.patch"
Content-Disposition: attachment;
 filename="0001-efi-x86-add-param-keep_efi_e820.patch"
Content-Transfer-Encoding: base64

RnJvbSA4MTU2YTc1NjBiZTkzY2U1NjNmNDViM2NlMWY2NDNmNjNmOWUyMTI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaiA8bGludXhAaWFtLnRqPgpEYXRlOiBUaHUsIDEx
IEFwciAyMDI0IDEyOjM3OjQ2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZWZpL3g4NjogYWRk
IHBhcmFtIGtlZXBfZWZpX2U4MjAKCkFkZCBhIGNvbW1hbmQtbGluZSBvcHRpb24gdG8gcmV0
YWluIGFsbCBlODIwIG1hcHBpbmdzLgoKQ29tbWl0IDA3ZWFiMDkwMWVkZThiIGluIHY2LjIg
YWRkZWQgbG9naWMgdG8gcmVtb3ZlIGU4MjAgRUZJIE1NSU8KcmVnaW9ucyBsYXJnZXIgdGhh
biAyNTZLaUIuIFRoaXMgY2F1c2VkIGEgcmVncmVzc2lvbiB0aGF0IGFmZmVjdHMKTGVub3Zv
IExlZ2lvbiA5aSBhbmQgcG9zc2libHkgb3RoZXJzLgoKRml4ZXM6IDA3ZWFiMDkwMWVkZThi
ICgiZWZpL3g4NjogUmVtb3ZlIEVmaU1lbW9yeU1hcHBlZElPIGZyb20gRTgyMAptYXAiKQpD
bG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4
NDQ0ClNpZ25lZC1vZmYtYnk6IFRqIDxsaW51eEBpYW0udGo+ClRlc3RlZC1ieTogTWF0ZXVz
eiBLYWR1ayA8bWF0ZXVzei5rYWR1a0BnbWFpbC5jb20+Ci0tLQogYXJjaC94ODYvcGxhdGZv
cm0vZWZpL2VmaS5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jIGIv
YXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jCmluZGV4IGYwOTBlYzk3MmQ3Yi4uOTQxMDE4
Mjk0MmJkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvZWZpLmMKKysrIGIv
YXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jCkBAIC0xMDMsNiArMTAzLDE0IEBAIHN0YXRp
YyBjb25zdCB1bnNpZ25lZCBsb25nICogY29uc3QgZWZpX3RhYmxlc1tdID0gewogCiB1NjQg
ZWZpX3NldHVwOwkJLyogZWZpIHNldHVwX2RhdGEgcGh5c2ljYWwgYWRkcmVzcyAqLwogCitz
dGF0aWMgaW50IGtlZXBfZWZpX2U4MjAgX19pbml0ZGF0YTsKK3N0YXRpYyBpbnQgX19pbml0
IHNldHVwX2tlZXBfZWZpX2U4MjAoY2hhciAqYXJnKQoreworCWtlZXBfZWZpX2U4MjAgPSAx
OworCXJldHVybiAwOworfQorZWFybHlfcGFyYW0oImtlZXBfZWZpX2U4MjAiLCBzZXR1cF9r
ZWVwX2VmaV9lODIwKTsKKwogc3RhdGljIGludCBhZGRfZWZpX21lbW1hcCBfX2luaXRkYXRh
Owogc3RhdGljIGludCBfX2luaXQgc2V0dXBfYWRkX2VmaV9tZW1tYXAoY2hhciAqYXJnKQog
ewpAQCAtMzMzLDYgKzM0MSw5IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBlZmlfcmVtb3ZlX2U4
MjBfbW1pbyh2b2lkKQogCXU2NCBzaXplLCBzdGFydCwgZW5kOwogCWludCBpID0gMDsKIAor
CWlmIChrZWVwX2VmaV9lODIwKQorCQlyZXR1cm47CisKIAlmb3JfZWFjaF9lZmlfbWVtb3J5
X2Rlc2MobWQpIHsKIAkJaWYgKG1kLT50eXBlID09IEVGSV9NRU1PUllfTUFQUEVEX0lPKSB7
CiAJCQlzaXplID0gbWQtPm51bV9wYWdlcyA8PCBFRklfUEFHRV9TSElGVDsKLS0gCjIuMzku
MgoK

--------------0FukH855E0HzJy0Qr0y4CvXz--

