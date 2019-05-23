Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169D328265
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2019 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfEWQQA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 May 2019 12:16:00 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38084 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfEWQQA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 May 2019 12:16:00 -0400
Received: by mail-ua1-f68.google.com with SMTP id r19so2392384uap.5
        for <linux-efi@vger.kernel.org>; Thu, 23 May 2019 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXMl9P+TGNueE5euLoOAhBRVyH0nXGkNGXAvhSh7+OU=;
        b=RBmoo21sPuzUV/EQovrxfLit8XjveVUpH/oRQNXVl7Q6wTjT2WhMeju7re3mqz8IBN
         fGdQdayykoLjbugpvir9+tXe/l0zWxJ6gCEaAte21ryH3NxdCpos865hXneKhcdNkwow
         I29SNtgGZwYGEa/J5emaZ+P8ZhtfSl4GL1UyTdj80GPWBCJWSenaQj7B4XRJ09R2a+fh
         +C9erGAG6rC9BLBZiGL+ifwexjPk5kRHwJE2C6SvKk2xFEY/klwYPfG+k1WD1LJ+XPWX
         Cv+wD6cHdbdKCDVNXBvakwQoxcPGeb0X7qvoKYFFJGNz7P6CWVRZGU47e9KNUyuqFZOj
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXMl9P+TGNueE5euLoOAhBRVyH0nXGkNGXAvhSh7+OU=;
        b=muhuPrYoPadv13JlZbGWLQV5GsC0or93ySPHoOCe2Oym3cS0D0gYE98XluEUBZDqkE
         LNfrTzRBCBPltEae6lpp19aXqxMVyMadctyyRT85a3cmK/BfxIDWraUo+u0zvIIxujxn
         xp1VLk6wGy9Panc746hsxU6E0MDOxe5QJAeFaF/O0auJa40ZN2ueJY1vfCFHnV+L+FqM
         8E4dKk+m/1qeV3GcTS/ot7WC9bHIRevs/awk2IXJBWOAyvuoW3J03SHejUn/PIIZH4nl
         La/9zKiqdTJ6HNzKtzPsHUkghZ5DRLWhdUFPZKkRz3/8i9S+z5qxhkCYL/X5Zxv6gXQ8
         Oimw==
X-Gm-Message-State: APjAAAV1Slog7OSqi0b6zfyg6y693nIbYaYghAtI/Kti77E4XhzvQPWk
        GTMRMxrEopC+J6HJZqZX1Qw1iY82ONK+LWTOwSN2+Q==
X-Google-Smtp-Source: APXvYqyKyrA3Zqk0VgrKQ9df6i2EvyciTk799ILFHCqR2AZ71fV4FIj6HG11qTQ2eMLBgGuo+Uu4fS1QUy9VmXaig2s=
X-Received: by 2002:ab0:670c:: with SMTP id q12mr24858805uam.106.1558628159122;
 Thu, 23 May 2019 09:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 23 May 2019 18:15:48 +0200
Message-ID: <CABLO=+=5D2v2TQ6HWSByJjnb4pzXZxXAs1jJgcFtVNYk5PYrjw@mail.gmail.com>
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 20, 2019 at 10:55 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Identical to previous version except without the KSAN workaround - Ard
> has a better solution for that.

Just tested the patchset on aarch64, all works fine.

Reviewed-by: Bartosz Szczepanek <bsz@semihalf.com>
Tested-by: Bartosz Szczepanek <bsz@semihalf.com>
