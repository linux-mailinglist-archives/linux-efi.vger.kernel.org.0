Return-Path: <linux-efi+bounces-2183-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD99D5457
	for <lists+linux-efi@lfdr.de>; Thu, 21 Nov 2024 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE7B283CD7
	for <lists+linux-efi@lfdr.de>; Thu, 21 Nov 2024 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751E1C9EA4;
	Thu, 21 Nov 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="eZcYIJSB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8D1C6F55
	for <linux-efi@vger.kernel.org>; Thu, 21 Nov 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222499; cv=none; b=fCBhs2onqZ9OjWGzU1ZEpKhOyHJ1lM2neV8Et0SxDpxtCoP2LJisAEhOUT7RepmTnKTywhrplIH3uoIuSP4n/aDfg2GM34dGXWzoE4MFrk3FXVEXXF2cmRTApJ3W8mukslGRE9jtNzkDZmgFwLQrpVNsy8W2Ng9V8mjtl/rCYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222499; c=relaxed/simple;
	bh=Biph9Y81tJzpyne82IE5JL3yDDDlbt96oHwe7pZJBKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOZWMhxPb98GEQmYW+3GY5/hK3BY0STi6NmCVPLuNkopbjKzkFPbEXn4vb/jGF9GWL0SXzCVNxXFKMaTMaYy12KPUUC5ncJ6/gfz+s76X0b/3mKOmTO9T4vJC5JVQ4KHShJUWrCGzwJwsgVijBdYFMD5izZu4G4nLT40+Z7MEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=eZcYIJSB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec86a67feso244310966b.1
        for <linux-efi@vger.kernel.org>; Thu, 21 Nov 2024 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1732222496; x=1732827296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxlYJjettiAZ+zfwr/z60w9a0TTUnSB4Ghtw8Ez8qss=;
        b=eZcYIJSBJzbNyIV95VSGlyICxqMVXWjwSXpvTaA1Gm8a+z1DXPgzZL4xx9sQQGpQTB
         00pw0awYeN+lqtORfWf1yxOJTBJSLaNcCr7EXEm7idN8sqruZGwZy5E/v4dz7mgRlZXC
         RbgJ70q5sLZmuKuzcSEbcOdTfoEaPwK760R0ESJjlXjHJ03Fpe9z3FvidZFBJ1piroLq
         iTnaAX2n4caikgul4HOHDnqaAQaUbAz1jjJIRk5d2rwQlsvwtOKJpwl0DbPwtGb922ls
         udtnN2YBNHEohJ6teTzGDXFijlc/y2yEO+4PyReZIQ8OXv14LtIcLR/tRTipz3fo+fM8
         QMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732222496; x=1732827296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxlYJjettiAZ+zfwr/z60w9a0TTUnSB4Ghtw8Ez8qss=;
        b=w4f38XLw5emOwvQ9THrlsUIjzZVZ2Duimikr+EGoYWOI5OSG32XCULMKKfpmdCHAC1
         etnR5lgrqGnBocl3lWXiFmflMZ/OyWkim81TfrOhmORCcw6lxyY+LaSVRXfyXWM/ebtL
         1w/zBPY7IbLecFgd+Fi+soyAabvHnqS/YVj123FOXytBvbZhhXQJyxDVoUhhzL0zSlMM
         HkpGtgFgsKAb8KhF0iVNnrQ9bo8ISP+pkNmtUrYvlgYcdPAZ1mMh+/666WQZlRclHBox
         J0SZHE2m/ChFsYDwA1wtqthYcQVSWP1AtykumwWezFjBO1oHme/oAtJk9dgslFPjpiN7
         OKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCURFk7L3CBFf1N1RuZyzHlU8yTytIoQ5zDki8otx1oPt6enwFJ7jNn8dxUj9WGkYpuXXzAWeC4MARk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZ7p/a4ma8JhMbBokTptuwvigkS2+7dI9Q4tsp0jjY8tF8r6W
	SnKI4Y+i9oZ/IR0dOKgxL8/BUiCmcSXVBD+o8CnfQkkluCp1Vo6AbUZhbf8yRpAWnzczD63cOXH
	u/pBGV2Beg6UtI3G6JSMcRIasif73YDz6kVff
X-Gm-Gg: ASbGnctOsZ8YCB7AFEepWVsNz1acldCdpaymy56gF1EAK4HnvGIMlMlvi66+4Y2/l2X
	lUeJN8baqv4kYxZUyNG5i+h8Jx3uyfw==
X-Google-Smtp-Source: AGHT+IFX8qcopmb73820lJ1EeujV0jQkdCVa2KfAGp/XQ+pR8ULYDdyGXnU+d5xuQGgKClmQdL5XGK0efADwdQnx/XY=
X-Received: by 2002:a17:907:ab5:b0:a9e:b2da:b4a3 with SMTP id
 a640c23a62f3a-aa509bc13ffmr38783066b.42.1732222495578; Thu, 21 Nov 2024
 12:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
 <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
 <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com> <66fabe21-7d0d-4978-806e-9a4af3e9257a@oracle.com>
In-Reply-To: <66fabe21-7d0d-4978-806e-9a4af3e9257a@oracle.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 21 Nov 2024 12:54:44 -0800
Message-ID: <CALCETrXXsta0OdgXb5Ti87psaty7gp5WRr-w8vTuEhOLuoGyXg@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: ross.philipson@oracle.com
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:11=E2=80=AFPM <ross.philipson@oracle.com> wrote:
>
> On 11/18/24 12:02 PM, Andy Lutomirski wrote:

> > If the vendor of an attestation-dependent thing trusts SM3 but *Linux*
> > does not like SM3, then the vendor's software should not become wildly
> > insecure because Linux does not like SM3.  And, as that 2004 CVE
> > shows, even two groups that are nominally associated with Microsoft
> > can disagree on which banks they like, causing a vulnerability.
>
> Thanks everyone for all the feedback and discussions on this. I
> understand it is important and perhaps the Linux TPM code should be
> modified to do the extend operations differently but this seems like it
> is outside the scope of our Secure Launch feature patch set.

It's absolutely not outside the scope.  Look, this is quoted verbatim
from your patchset (v11, but I don't think this has materially
changed):

+       /* Early SL code ensured there was a max count of 2 digests */
+       for (i =3D 0; i < event->count; i++) {
+               dptr =3D (u8 *)alg_id_field + sizeof(u16);
+
+               for (j =3D 0; j < tpm->nr_allocated_banks; j++) {
+                       if (digests[j].alg_id !=3D *alg_id_field)
+                               continue;

^^^^^^^^^^^^^^^^^^^^^ excuse me?

+
+                       switch (digests[j].alg_id) {
+                       case TPM_ALG_SHA256:
+                               memcpy(&digests[j].digest[0], dptr,
+                                      SHA256_DIGEST_SIZE);
+                               alg_id_field =3D (u16 *)((u8 *)alg_id_field=
 +
+                                       SHA256_DIGEST_SIZE + sizeof(u16));
+                               break;
+                       case TPM_ALG_SHA1:
+                               memcpy(&digests[j].digest[0], dptr,
+                                      SHA1_DIGEST_SIZE);
+                               alg_id_field =3D (u16 *)((u8 *)alg_id_field=
 +
+                                       SHA1_DIGEST_SIZE + sizeof(u16));
+                               break;
+                       default:
+                               break;
+                       }
+               }
+       }
+
+       ret =3D tpm_pcr_extend(tpm, event->pcr_idx, digests);
+       if (ret) {
+               pr_err("Error extending TPM20 PCR, result: %d\n", ret);
+               slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
+                                 SL_ERROR_TPM_EXTEND);
+       }

I haven't even tried to see what happens if there are more than two
allocated banks, but regardless, that 'continue' statement is a
vulnerability, and it's introduced in the patchset.  I'm not the
maintainer of this code, but I would NAK this.

I'm sure there's some reason that the TPM spec even makes code like
this possible, but it sure looks like the TPM2_PCR_Event operation
exists more or less to avoid this vulnerability.  I think you should
either use it or you should explain, convincingly, why Linux should
add code that does not use it and thus has a vulnerability in certain,
entirely plausible, firmware configurations.

This is brand new code that is explicitly security code.  I don't
think it's valid to spell "crud, we can't handle this case at all, and
failing to handle it is a security vulnerability" as "continue".  If
*I* were writing this code, I would use TPM2_PCR_Event, which is
entirely immune to this particular failure as far as I can see.


--Andy

