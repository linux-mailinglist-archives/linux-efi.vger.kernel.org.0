Return-Path: <linux-efi+bounces-816-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD787C6C3
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 01:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6920A2826DA
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 00:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15E19F;
	Fri, 15 Mar 2024 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b="N8MKBEZv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E7635;
	Fri, 15 Mar 2024 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462449; cv=none; b=JOoEx0tFWlb99FyjT9L9T8NcTEhwnsI9uN1TY759E8DigR2ytUYdutQ+lqxGbGjWb4QhIsTw8poSqutfgF+2YhMwJeTiCd5juzP8q/F4LP/SWDDxiYe/CMsxjE8n/6FweE3n2oThO6/ENrnMi2eFcn9n0tVRrCcM5h/m7KpdEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462449; c=relaxed/simple;
	bh=f8E8aUsLYhx+wLVyVfWO0R+ZhEJFEDlP2NW5WWjxZjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZwjF/KopP4tXVk+GC2oPIr5gaGV6vfgSSDc5mfK7KJ3X8wnKDW2fwO1aqFTQq4K34fjMLwgjsMr+PkzKf7bIgR7Fpwb/wKTHtflG7FhUWEqgXorerh3lbaZqi9s31dtlc3FRZiI9t+EDhYrobM5R4RyOAbbdBZmNTSsnvGGd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=timschumi@gmx.de header.b=N8MKBEZv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710462429; x=1711067229; i=timschumi@gmx.de;
	bh=B52cazKgtP+V6ttkF6KV1d6LbmJl83GGXxXlPh901dI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=N8MKBEZvdC4W5nNstoYGkCyuOmxOJdZgM5b1WznJH0flqyCuaDj3ZTg0+o1eLSgf
	 sLlphXSEcjXv49bqP8urm4QaI8t0aYpeEZMDXC7muIQeYIfbPKBeCV0DOswQpDYuN
	 QmQxb2hdle4n00W4zvDaazJBusiD3j7Vs+XPB3tjz+0ht27tL7KK8J5+hPApqBWk0
	 XhgFs8tHLoJn2gteeK5U1/ygc7gwqTuuf8ynALBu0kXcr9DtpmDjod+X0yeTT2zIM
	 wX50ADp1RokSbAYVOggN1E3BZBCOG2SNR76/AVQUNad9x1PHREqI3iC8phPFaFy+p
	 yYEMkbC4bC0ig7Hh8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([93.218.98.241]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MpDJd-1r0t5W0CdT-00qhX4; Fri, 15 Mar 2024 01:27:09 +0100
From: Tim Schumacher <timschumi@gmx.de>
To: linux-efi@vger.kernel.org
Cc: Tim Schumacher <timschumi@gmx.de>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] efi: pstore: Request at most 512 bytes for variable names
Date: Fri, 15 Mar 2024 01:25:58 +0100
Message-ID: <20240315002616.422802-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BdGRQjVfhDgGvU6FYHwpw57XdbVkpjF/zzzddOP3cnpwcRXYO0q
 clEaraNK1RntHRqD8lNxHJlWXyNEu9tTt0fDol+Mk/9Jgi5S9F/iUVVSHnvUhVz53n0dWJg
 l3XW6+Y08xisQMHGbEMPmGD5j6ilbS9VNaZy4Y2VHEYujorXsdA/bmgXNDZOsobewuBsDh3
 k3mdefY7OxBLkyE6MwaAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oj7maLOLCHk=;IYDuQlWqLMVRi5Wi3A8fBgRJ9Ai
 /cYPPkmA3/S74JFkCcTOo1e0cjcshIXXE/2Z4Jd8oTu3vwqXdOw01rExio41yNuZwN98qucvJ
 tnr1Zv7Ghq4gOO6J9xIck7vk6VEcydg7ufQVJfhEx8NrmuUqBU4Qj4y+9ec8vVAJ+qbmKChY6
 K7BFdRPwo7nb3KAcEbulP6Aq23xh6rnzGzSaMPdI6l4Iv7KvHRkrrMTlQD+bk/76j8rBFRIg4
 AZLPt/eeoWA8jSOF0uZQe3l/a5euMm4ncoHkBnZ+xPLwFYsoeSVZ6SIxERrqOIhP+v+qcKYGs
 GONuSd89AXvjy16ZDC6KA0WL7Kgx6mOty5YqUgOrmZx3QnW20kWdsNwkX8NY6JiPKqtswHh6e
 OueC9t8Scdox8g/AQ0SNgnGrDx/pntwcKiJyO4z+WBj1zY8CNGyz1d8K9Xdr6ojupvNeqYrDZ
 G+y7u1QfD1WKaKeKp4VWNLnYGaw7LT9VWGo4AafO58d0QOLcvCni0g3dmMfOoTQaAhfrC893+
 f9uWwYl6Ufv0c69EgH6Sm+IbT7/v13vzt/QRPRHMKHQFgHi9vdWPkwkSbPlOs2zhZA/EzXk91
 EHkXxPf0gQ79KlPIDL3FFsi/KGqefibZSneqN2mNwI8GNl/22OUkdGCv7mqteLCokSFtPZaRL
 K/mLHZ05BpAGvKI8KUAAs20UswcG7NrSPi1pA0/XtzofYrILFXezZ1GlEdkmRj7LCZBw9Ue6/
 zwEiJsaJHVfKfmjYn/KCsUMfN/pQUjq12Yy6Olc6N03xxeT3dIsrEpnuKplsiiJhGUTYgCXbB
 wAoSgA4IeDkadqh1nzWli6rveHHXDnGPuAUocLSCXJvVk=

Work around a quirk in a few old (2011-ish) UEFI implementations, where
a call to `GetNextVariableName` with a buffer size larger than 512 bytes
will always return EFI_INVALID_PARAMETER.

This was already done to efivarfs in f45812cc23fb ("efivarfs: Request at
most 512 bytes for variable names"), but the second copy of the variable
iteration implementation was overlooked.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
I CC'd the pstore people and linux-hardening mailing list because
get_maintainer.pl suggested to do so. Apologies in case this was the
incorrect decision, this is a very non-pstore-specific patch after all.

I have taken the liberty of adding a TODO for the future, the actual
refactor can follow at some point down the line.
=2D--
 drivers/firmware/efi/efi-pstore.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-=
pstore.c
index e7b9ec6f8a86..f0ceb5702d21 100644
=2D-- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -135,7 +135,15 @@ static ssize_t efi_pstore_read(struct pstore_record *=
record)
 	efi_status_t status;

 	for (;;) {
-		varname_size =3D 1024;
+		/*
+		 * A small set of old UEFI implementations reject sizes
+		 * above a certain threshold, the lowest seen in the wild
+		 * is 512.
+		 *
+		 * TODO: Commonize with the iteration implementation in
+		 *       fs/efivarfs to keep all the quirks in one place.
+		 */
+		varname_size =3D 512;

 		/*
 		 * If this is the first read() call in the pstore enumeration,
=2D-
2.44.0


