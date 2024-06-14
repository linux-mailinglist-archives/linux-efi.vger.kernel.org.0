Return-Path: <linux-efi+bounces-1220-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AE9092D8
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2024 21:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA83A285595
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2024 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF1147C80;
	Fri, 14 Jun 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0YCTFXK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80317C72
	for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2024 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392586; cv=none; b=BNSfThVXDWR98RoIi4bwKOfaC87gpSQFChZnUnl1SHKEHBz6JyIui49vwZWF39tSH43IqVfk+THE0aNJ5iW1VYHb1remBSrD/oNnrM0dbf0tSHsjMVabUIyd1AK8GyVWEZQuy+R8RA7feA4f/njiVFHPZowLfYsjhi7Y+RdomVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392586; c=relaxed/simple;
	bh=ayPHJAY2wspvtPw7ns9AVB5a2lftxjI2TErmKJzekiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0+dRwPKvuvfKHMLswR950U7aQEqGQbIq9Dio6UV6CGQvNXMICX6xy8i54ueBt083dinHWRjd6CEBQbGkGwYnHjHVCq7DYXt3ZMejAA2tDZJ0Zdn1j1o1zZgPWyb5WHzPBTyIW5QW50Vqd+5A4AzvnH8rY5VIUx7mSBzgXLY7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0YCTFXK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ca342d6f4so498e87.1
        for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2024 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392583; x=1718997383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayPHJAY2wspvtPw7ns9AVB5a2lftxjI2TErmKJzekiY=;
        b=L0YCTFXKZDATx9W4MCE1rMDmCz4rBHrurPnS8euATH7ByWiLnGScae5dT028aTfwJz
         I/p7a7aQ2IW4ANnTUUhyISTtVHOSbu1o71cXsWxQgxofrUpaceCcsMJ4UNXJhgfHIPtz
         OsJYM4UKaOiOCS4DuyD8rC5PqW7e+4pzbDqiNvU2e7RTkDKONvj+yz1Hy1MN64lGh1OL
         4ZuoEODz3kYJRiFBRK8Qf0lFs+C7mG+64XHbyksM2iJ51cPXlJXut16zYFi52ZlZ8IBc
         pCNuTmNiDuwiG8C34YRoYt+SRH8ZwATksNN5igHvr+05D5/mTnOFhZcEjrZepZ3+C5aW
         M3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392583; x=1718997383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayPHJAY2wspvtPw7ns9AVB5a2lftxjI2TErmKJzekiY=;
        b=vb4ujocNfPJPh9WVFBEfDFDqOYpr1pgx4Xz/bRqrnXnZDenL0ogBQMHDsl0PmmEGyn
         jGR+yZBNLLu0Qj93TkkEJn97R8m9KEDV6BW1Y9cFMiWruevNzTBo/6i+olwowIs4ogUh
         SZok9HEUGM+v1AzpzSszQB25KfBBtusSCYyOod7nuoyzOPzGWuFOuQHbPbHifZNI2iuW
         z+ZpikXIOEoSEAA20MRvuYqdgHYeARoFmlYVh0mOaRJPvmh/35Sx0WK9eF47MErdBuMo
         HWeCt/NNxhn/anWoSq/NtMQxFh7zKpC3hc0KnsjeyN+UhooLQt7a8UcANqjOZ2dFLkXz
         0iRw==
X-Gm-Message-State: AOJu0YxGUl8CccaAJki87nEPwOvuKNPkCMoMHE+roYIN3/rArmMOzCfY
	p80eSRrF6959q9gKEd9K4kEH+XAsfl3TpJw0+MCDTpjeADGloovt4Tn/EROqe6mTKGH//eUXRC0
	R8s5YDgR+JCCFCcSlErYqLQYElS6B2Iv5kWMpI+El4dbi+zunJZca
X-Google-Smtp-Source: AGHT+IFJwaEyKd4GUPL6KG4s5mAsmzryn1LKdhNP784a03ArAiXfqnzoWsOk8fQD1rPrvEoBD+F7oeXsvK20TulWvcs=
X-Received: by 2002:a05:6512:e84:b0:52c:a2dc:a35c with SMTP id
 2adb3069b0e04-52cb14ab526mr14247e87.4.1718392582769; Fri, 14 Jun 2024
 12:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
 <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
 <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com>
 <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com>
 <CAAzv753ZHR46sgncZr4p3dXzxQAZpVgLAzGBhJ2nOPNHo1jttA@mail.gmail.com> <CAMj1kXFL0F4H=vj9Rf1ZSeo5Smsu-5ZH7ZSEnhfaju9XW=68Pw@mail.gmail.com>
In-Reply-To: <CAMj1kXFL0F4H=vj9Rf1ZSeo5Smsu-5ZH7ZSEnhfaju9XW=68Pw@mail.gmail.com>
From: Nicholas Bishop <nicholasbishop@google.com>
Date: Fri, 14 Jun 2024 15:16:11 -0400
Message-ID: <CAAzv753ie4GeNa7VVieq=OEwLhfD1xcNkMtkuw6fwKe9HU7-cw@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Btw could you elaborate on the failure mode with mixed mode on recent
> edk2? The current tip of tree works happily for me.

After doing some checking, it looks like it's specifically an issue
with SMM -- without SMM_REQUIRE it works fine. I think it's the same
issue you reported here: https://edk2.groups.io/g/devel/message/108937

