Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8059210F432
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 01:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLCAnS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 19:43:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35234 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfLCAnK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 19:43:10 -0500
Received: by mail-io1-f68.google.com with SMTP id v18so1695656iol.2
        for <linux-efi@vger.kernel.org>; Mon, 02 Dec 2019 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jnL6iDubLY8gL5JP3QSc0ju+BQUG+h8VIAOn+X5oWQ=;
        b=T00bsc0APIQpp0kFPoFsLBa72cSKQI8/kvf/jrmlw4YTXIkoV3Uo9vYbKOVb/uvmMa
         Fx0TgLfE1CVyHBCn7J7nM976Z7PON3M3w+uSZtQ2kTxe+7DNpYO1vky1kHc7MGIzcifk
         Rsgk4WafvGso2zBq8zzPlQSTSk797b7OEJlbteHeDpdZ+gwvXPs5Nniz0vbM33QLo++f
         5WJ3xnuNz/Crxcb8d8IUNaOA8+ssCGZqzJbMWlPmvRzBWmuRrGqBI8UecAbi+m6cUljH
         FvUNkjv38k90sNUFreVKS1i8TAkgxv4pKR1dCeBNykyTp5S+fR9yd6wQ6dhzRH2CzVjC
         hetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jnL6iDubLY8gL5JP3QSc0ju+BQUG+h8VIAOn+X5oWQ=;
        b=JGv/ccKnFluRIHtPsJqB87ovG8uXkWKCNDzAxVXWZPyCZLFa7Wukb6BcMW9jzTjS3H
         OpL8wbfHkE2zbvR5mqu8yYaw8HJ6IQ0O/D7PKbBaxnDDlcXeXduGY4RG4TAtcMbAt/mJ
         wYNcyEcdzFmPQTmmxB2NmSK59eK5F4Y6jtIGB9inYIFkOJJGM8jNeubyV8m0SBHnUXoA
         6up48lpIcoWHRQNaQXJsqyluW5ObobzWr3kbdkf3brLK/hV5xjN15M7mflfFvxqDIbdl
         1AojmmnZ5X/thfwXG/9o1Wy/bzpUh1+sUh4PbXlWtG+DTkNG7SEERP3cXtgpRLg868i3
         ecQg==
X-Gm-Message-State: APjAAAU+QqqOHEipARc6Hz9y1vo8qz5vegVvgDedA/gC0DcO5NpUQFi7
        IUVnWi+BVmif9uA669DbULdD/iW9nV+anSmjZEMOm4+aWRY=
X-Google-Smtp-Source: APXvYqxJrkK1ZdE65kA4EuWOJ5vb0zsDMEQ4ZrjeW7uzvZYJCxvo09UHOuHs6AjLENBNZOWUxi9WR6+6dwVQ5+rKKQ4=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr235848ioq.84.1575333788813;
 Mon, 02 Dec 2019 16:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
In-Reply-To: <20191203004043.174977-1-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 16:42:57 -0800
Message-ID: <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 2, 2019 at 4:40 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Add an option to disable the busmaster bit in the control register on
> all PCI bridges before calling ExitBootServices() and passing control to
> the runtime kernel. System firmware may configure the IOMMU to prevent
> malicious PCI devices from being able to attack the OS via DMA. However,
> since firmware can't guarantee that the OS is IOMMU-aware, it will tear
> down IOMMU configuration when ExitBootServices() is called. This leaves
> a window between where a hostile device could still cause damage before
> Linux configures the IOMMU again.

I don't know enough about ARM to know if this makes sense there as well. Anyone?
