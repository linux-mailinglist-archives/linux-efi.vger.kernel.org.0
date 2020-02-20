Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC51665C7
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgBTSE6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 13:04:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33629 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTSE6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 13:04:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so4459843qkm.0
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2v9++VJstufH1+y//bzFzCtq58UjRbNISeQ4gDqrXYU=;
        b=kyCdSGwcUd9O1l0C+3nBR8qWqekP+Knv9T1hcQrkOH2hvb7BUvLs8AoKZ0kpZ0twno
         mQNPQmCaGC7Zagah367xpGYf2qPot4mY6l7GOPtyswseO+cbo6rdu+4nACZCA3PGrhID
         bEEDBajarCSrcKENhLYNE4wPzLgCkAfcO49zBBa5yT135rQto/uRLaQnDsdjB0W13KLr
         luCgHFDg6DBiA14y4RjHmZdTBJSLHtzo0kvFZVe20aKkEnh9d1k+hE7rALvWhsBUVnQT
         FKtM2bzD45DucI131kOHjKo3kRne+QL1p5cMWJ17GNw1TzrY0CkSfIg49RU5fcrYgjYs
         VU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2v9++VJstufH1+y//bzFzCtq58UjRbNISeQ4gDqrXYU=;
        b=sOm6vjH3tiF8tJle5UvYRZk3YxcIZDAHRrW/U9Sdci/ZxrsPUKhU+0sv4RlKeZITxO
         DdnlN08Swy0+NfK7TvNJtBgMKbARrhUk3u7Jy4m33oIY4mfKM2t6qBdhJnBluglOwXZ3
         7eGCl9SddcWpvdlHk0oLormk69XgPF4lG5Ra4LERRe9JxYz5Jd4nd+IcdqDjDQP7ewEJ
         6n3g8GokuMX5Gv7ncSatryzl7OiSjxnwh0mUNRxZarvspylqhxeKF33mqVQlJDgZFIzd
         4SCWXnD/x8Wl7bbyziJ8Qd+gvfq3D4NwP3zRCkR5PxHSsBUSIg6u43h4/18oSQ1H6+iw
         sWUg==
X-Gm-Message-State: APjAAAW48bdrrU4ax4UTf6Biocz8TdZvN7XwJTi6vHQ46AegRKyTr715
        ds5Poo4YrBXYmDLAFUDhVXg=
X-Google-Smtp-Source: APXvYqzpuBjcqxJlkti+FQl0Pjq/R3muKhLkRFuTs6sazIEzYXUnPxgzkPk0ep/LbcWyYKxEY2vAbg==
X-Received: by 2002:a37:b103:: with SMTP id a3mr29638147qkf.204.1582221896624;
        Thu, 20 Feb 2020 10:04:56 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a192sm168328qkb.53.2020.02.20.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:04:56 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Feb 2020 13:04:54 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
Message-ID: <20200220180454.GA2436919@rani.riverdale.lan>
References: <20200220110649.1303-1-ardb@kernel.org>
 <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan>
 <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> Another thing I wondered was whether we really need the .reloc
> section. We don't have one on ARM, and it works fine with the existing
> EDK2 loader.
> Peter: any idea whether the issue with .reloc you pointed out to me
> the other day still exists in EDK2 today?

commit 743628e868c5 ("x86, efi stub: Add .reloc section back into
image") says that
	Some UEFI firmware will not load a .efi with a .reloc section
	with a size of 0.

Is that the issue you're refering to? It is a bit odd, since we actually
leave base relocation table at a size of zero with an RVA of zero, so it
shouldn't even look at the .reloc section according to the spec. At
least current EKD2 code doesn't seem to -- I think it would even work if
you specify fewer tables than 6 so that the base relocation table is
missing altogether.
