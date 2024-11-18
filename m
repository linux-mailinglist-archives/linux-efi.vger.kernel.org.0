Return-Path: <linux-efi+bounces-2171-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D69D1965
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2024 21:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710C6B21302
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614101E47CE;
	Mon, 18 Nov 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="M5Vg+RuI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B61BD9C1
	for <linux-efi@vger.kernel.org>; Mon, 18 Nov 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960149; cv=none; b=Q/wxgwz9Gh6QAUqXgey79t7xK4X3bGJATuA0AwVezwhQr6m8v3y3zo5LVjol2iGJdzyaF3UKm3Ln1YMCtADnIxrZcg9X5jZ1wQlV2/K/wCnSylGGzHPc3dFDHvFEJa1a2XEm9hnK+l1dJcwuvILScp6RjHIcU1fuqMWbC/ZyGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960149; c=relaxed/simple;
	bh=E+LBwBRF8DHoVawLtfgdfdbwEfo68/6NPCRK+oRI+No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2uPedJ29pvDZlwAnQeZ8N01woMSFMiHF3Jqw4luxf+Yp5VpVviYo6t/5Yae7cOcJyG+SoSoVHFCGepSW2nNOq1mEVvzV3LtSBLod+b5LeEohApPTC4P/I6qs6HCNNUpSJW3RXi6KfDjsdBwKv+y6XD+g7OplDUVOr5rhquBuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=M5Vg+RuI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a4031f69fso29516866b.0
        for <linux-efi@vger.kernel.org>; Mon, 18 Nov 2024 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1731960144; x=1732564944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F56XnCiPK1ucbtbbIcuwS+1n5yBs1+kTrZwft20AGGo=;
        b=M5Vg+RuIEJo5nRlwRuJBceZfl7J/tp7FoRljht/aHjwm80g8gaL4PAKFGneLmac5UA
         huSPyBi/fanJIwXS8dXkMJtp5Dcx3N2CmMWu53Bymxf5xKqPzMmeKxXpYP3E3puqyzpu
         J/fmz+9M9Lb8KyShD9HYNb5A3p3pXfkLMkT8blTdBWRJh+YFA8PXqWFG521vWbmES848
         tBRvstqL/iJJmmUzW7WrS2wLG1qlQpCf3f0Y5Kf1h9bG/eG2KTis3yxBjjtyrGqchec0
         T0jjenqN5ThrFV3h6Exs7LALNdLFKzDyh/vSdyUauzmqodePjGToGNrMUUTo4FUvxQwg
         4wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960144; x=1732564944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F56XnCiPK1ucbtbbIcuwS+1n5yBs1+kTrZwft20AGGo=;
        b=Ot6XGjc3x2WwDq2lSdb3wBJxrBYYHln7N15R15ZG9AZdixNjVCSxtYrD1Xlj1uXADe
         k/UXyOGyOFw/RwDev0hN3m3G0roru4W6p59sTcUqfdxjg/P0h8vSe3KlZt4zvOBGfXdI
         h2WRv1Uvh8ld24r0090EBTvDjvkwOmp2+vVrHnjewtppAa+rBXPDb8F7NFgW1djSWV2q
         SEIN+DfJrQ1ABh22cAMyUzMaBUkHMMRb20cGmOmc7jtzGfOrmcmEc/a60krHV3p9IrAG
         QjgBBqRCV5seCc+YZejbjKPVRfdTStr6pk3tPtYoneTiiJbYIE7wdCpaThIzfMAoWQ6+
         KYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdLu1OOkaIPcZLWHWzAovEScQeThIaRBlkB1Qf2u1aEfO+ZkIWpW+6TeubmAmat96L0ujYmCwnMko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZWh3fZIRmn3EL3NRS3i8STe4gRaSoTNiglHu8p5fzRrX84G+
	/TLAnuhV78fKCXiopi7efFD+Y2LDSoBmCW5bUKuCNECXVvmzYPX1F+ZTuEi9vTPRU3le2PWw736
	QmuGWKxil1xxR869Tnz3nfUDFl7VT/vPbtDQ1
X-Google-Smtp-Source: AGHT+IFoQ/M1Rp3ASKc7+vFPOEp+9oiYAQ8ueOL2fLtrqLS19jm7uOri1Atv932nS8Gcqo/IWYlS3CoMIuiDqjl4zlU=
X-Received: by 2002:a17:907:9412:b0:a9e:d7e3:ccae with SMTP id
 a640c23a62f3a-aa483427760mr1375196366b.16.1731960144547; Mon, 18 Nov 2024
 12:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
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
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com> <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
In-Reply-To: <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 Nov 2024 12:02:13 -0800
Message-ID: <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:12=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
> > Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
> > exclusively use TPM2_PCR_Event.  I would expect that passing, say,
> > the entire kernel image to TPM2_PCR_Event would be a big mistake, so
> > instead Linux should hash the relevant data with a reasonable
> > suggestion of hashes (which includes, mandatorily, SHA-384 and *does
> > not* include SHA-1, and may or may not be configurable at build time
> > to include things like SM3), concatenate them, and pass that to
> > TPM2_PCR_Event.  And Linux should make the value that it passed to
> > TPM2_PCR_Event readily accessible to software using it, and should
> > also include some straightforward tooling to calculate it from a
> > given input so that software that wants to figure out what value to
> > expect in a PCR can easily do so.
>
> Just for clarity, this is about how the agile log format works.  Each
> event entry in the log contains a list of bank hashes and the extends
> occur in log event order, so replaying a log should get you to exactly
> the head PCR value of each bank.  If a log doesn't understand a format,
> like SM3, then an entry for it doesn't appear in the log and a replay
> says nothing about the PCR value.

I have no idea what the "agile log format" is or what all the formats
in existence are.  I found section 4.2.4 here:

https://trustedcomputinggroup.org/wp-content/uploads/TCG_IWG_CEL_v1_r0p41_p=
ub.pdf

It says:

This field contains the list of the digest values Extended. The Extend
method varies with TPM command, so there is
no uniform meaning of TPM Extend in this instance, and separate
descriptions are unavoidable. If using the
TPM2_PCR_Extend command, this field is the data sent to the TPM (i.e.,
not the resulting value of the PCR after the
TPM2_PCR_Extend command completes). If using the TPM2_PCR_Event
command, this field contains the digest
structure returned by the TPM2_PCR_Event command (that contains the
digest(s) submitted to each PCR bank as
the internal Extend operation). This field SHALL contain the
information from the TPML_DIGEST_VALUES used in
the Extend operation.

So we're logging the values with which we extend the PCRs.  Once upon
a time, someone decided it was okay to skip extending a PCR bank:

https://google.github.io/security-research/pocs/bios/tpm-carte-blanche/writ=
eup.html

and it was not a great idea.

There seem to be six (!) currently defined hashes: SHA1, SHA256,
SHA384, SHA512, SM2 and SM3.  I haven't spotted anything promising not
to add more.  It seems to be that Linux really really ought to:

(a) extend all banks.  Not all banks that the maintainers like, and
not all banks that the maintainers knew about when having this
discussion.  *All* banks.  That means TPM2_PCR_Event().  (Or we refuse
to boot if there's a bank we don't like.)

(b) Make a best effort to notice if something is wrong with the TPM
and/or someone is MITMing us and messing with us.  That means
computing the hash algorithms we actually support and checking whether
TPM2_PCR_Event() returns the right thing.  I'm not seeing a specific
attack that seems likely that this prevents, but it does seem like
decent defense in depth, and if someone chooses to provision a machine
by reading its event log and then subsequently getting an attestation
that a future event log matches what was read, then avoiding letting
an attacker who temporarily controls the TPM connection from
corrupting the results seems wise.  And I don't see anything at all
that we gain by removing a check that (TPM's reported SHA1 =3D=3D what we
calculated) in the name of "not supporting SHA1") other than a few
hundred bytes of object code.  (And yes, SHA1 is much more likely to
be supported than SM3, so it's not absurd to implement SHA1 and not
implement SM3.)

>
> For some events, the hash is actually the hash of the event entry
> itself and for others, the entry is just a hint and the hash is of
> something else.
>
> I think part of the confusion stems from the twofold issues of PCRs: at
> their simplest they were expected to provide the end policy values
> (this turns out to be problematic because there are quite a few ways,
> that will produce different end PCR values, that a system could get to
> the same state).  If you don't trust a bank (or don't know about it),
> you don't code it into a required policy statement and its value
> becomes irrelevant.

I think that "you" refers to multiple entities, and this is a problem.

If the vendor of an attestation-dependent thing trusts SM3 but *Linux*
does not like SM3, then the vendor's software should not become wildly
insecure because Linux does not like SM3.  And, as that 2004 CVE
shows, even two groups that are nominally associated with Microsoft
can disagree on which banks they like, causing a vulnerability.

