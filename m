Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1854812DC1B
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLaWWA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 17:22:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38127 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfLaWWA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 17:22:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id d7so47335724otf.5
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 14:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlT2jnj7z1iFkAKUNQWbQsSo+TR/YWaOOgSod0k7w7Q=;
        b=SDs1XLSXb/UhPFICpRz+QEz2jdxJ6mnD5z1RgiUjXl2kSN/SRjY9qdkxJyPAomSFTo
         4W9MT/Op5DGfy6j89Y0CN+wSoO62llB4hEsqZe/GklaDrEVyBKPBfqdEaWhDU8nIxLmJ
         9G0L5DxAM6OUB020gwJZmEOLfI2umTuE8DSX41pN9b6WJW23421YpX2Wkr4V9QE/5XC1
         TzPh49oF7f8lsyZ4X7hp8T26FyBOWgQZPAGfV5pzgheLaoIKmuE6AU6YHebo+rk5XUYQ
         tjdS2jb/XLEk3L/6NONnK54wVAI1n0emlo3so96l7qP/07/oL/REYGzpBJAAD9H4Sk7W
         lbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlT2jnj7z1iFkAKUNQWbQsSo+TR/YWaOOgSod0k7w7Q=;
        b=bzOFQibQfAxH8ylE6HMe42aYOqdpwVv45qINqXtEirhozmOp0ec/qjWJ3xT0P5zZx8
         ZZU/ExA9lVDNtBEfSDVbEhVGIuVat0P7opO6M0epGEFATQWKIgci1BqEPQJAJ3lwU0am
         rOilZYlm4MWrnSYNMD+Ixqhf4N7lC+xuTu5rrpar9TqrZLRS6K8pgcVKsvMTdeReA5KP
         EhIJR0K7on+7jbmsebG8KDQAZj+fZ7/Rg04Rk69c8SF8irJu/XOO1eyRbmkFtaY2h6kZ
         JoF2OOqTBq1tZD+id3AZeF3DPOY/pcDrY+nxEhLjsfx11pxfEVjaI5fYza1+rb7oZEmN
         KuIA==
X-Gm-Message-State: APjAAAXyPqDy8b6Se9tWpHK/aPScOugfchngju/wWIhTaIMAOVjqrLdM
        upk38dLXbMdd4DgIQ8XEdu6Nwy3o2wklD8wHJJCfAQ==
X-Google-Smtp-Source: APXvYqy1Nlu/1GbgH0I6iq3zMFnAaxwd8ZFUXv3pxT0OCb9TlTQPfJLMpeN7TKNH/fK7w1/i3uKBuqDIMtTj0BVo/Zw=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr84887327otk.363.1577830919298;
 Tue, 31 Dec 2019 14:21:59 -0800 (PST)
MIME-Version: 1.0
References: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191231014630.GA24942@dhcp-128-65.nay.redhat.com> <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
In-Reply-To: <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Dec 2019 14:21:48 -0800
Message-ID: <CAPcyv4idLx58iH0tA08vrVdvornd-jAwSwHQ6Eha+Z_UQUDDAQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 31, 2019 at 1:11 PM Dan Williams <dan.j.williams@intel.com> wrote:
> Perhaps a prettier way to do this is to push the handling of each
> efi_fake_mem entry into a subroutine. However, I notice when a memmap
> allocated by efi_memmap_alloc() is replaced by another dynamically
> allocated memmap the previous one isn't released. I have a series that
> fixes that up as well.

Available here:
http://lore.kernel.org/r/157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com
