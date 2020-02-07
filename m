Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE123155E5C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGSph (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 13:45:37 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42435 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGSph (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 13:45:37 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so76135qvb.9
        for <linux-efi@vger.kernel.org>; Fri, 07 Feb 2020 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4WoqZWhlFigowj5nWAxAoZuoh6Wc+IYKOBSeIA3KMeY=;
        b=XM2lXlMP2sn+m1mIjaaP947U0iR9QtZ82UpnD9WqCfJgDquwi86QWmxWgg+jyPWB3c
         l0S9UFQTr4e6lnpjcMEJHyRamSVdMUM06phOyWpJpB6V3XMR1v+ypWQKwrF0m7eUvqMZ
         Vm3YlfwGch2ZfKdys6dvcNqNDsJgLkbpqbCNFEWPJGKxSDnsi00XIIAVWvJ/i38gcQAO
         HkRm19Y83pz16SAin7Xib0X/38x9C86HNVr0ilp0p8bYQFnHTyofKTMJpj8IRLufE2uC
         g3/JzUOWUZOwiKApW/qZytVwaIphsiSviWTeb8uUV/VrJMwygmihjx14jYNEc3Px7Nbm
         i2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4WoqZWhlFigowj5nWAxAoZuoh6Wc+IYKOBSeIA3KMeY=;
        b=BADTlzwxBtGzcF3ciig/4fEIVlS+KHHtOfTOIZu2oPi79B5ky5QLsAW9cZwNQEnaaA
         +LcP5unIhlBypk7mPNKlY6BkcpRXw3ttvIK7WsYNzWdBfExw+OTKunHDinUTv6F/iGce
         W7f01qd72j4RPSJeirXfwi/CLMXYi3oo9qT6pt/4hH5vaR5lqA+6OvwI2NdBmLVPgZvQ
         P2KxVgQ/AT2UBUvUF0aDxOayYq3SrrSbbR5Bblb+M8eBaLdNJz/2vgFMR3rURpqb7zWQ
         bgufYuencELdhZO9arOx/PYmP+4wM1OMtR+a4bYhlvgrXKKuikv3DY0VXxl9eVm7Qqib
         diKg==
X-Gm-Message-State: APjAAAWefqxdFRP3CUcnC86cFCbqG57fq494DYrsaEJAfjegKAUDJN+t
        6oxcYVbXFqdYA2PU8hdgFJ0=
X-Google-Smtp-Source: APXvYqxhjNUXNB9tXrt+KrnUN2gKsbN6PjyaSzDloBuQ41XSA3y05a5xQPsnanLI4Iv7WvdMG73t3Q==
X-Received: by 2002:a05:6214:b23:: with SMTP id w3mr208717qvj.181.1581101136603;
        Fri, 07 Feb 2020 10:45:36 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o7sm1722563qkd.119.2020.02.07.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 10:45:36 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 7 Feb 2020 13:45:34 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, ilias.apalodimas@linaro.org,
        xypron.glpk@gmx.de, daniel.kiper@oracle.com
Subject: Re: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
Message-ID: <20200207184532.GA3276112@rani.riverdale.lan>
References: <20200206140352.6300-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206140352.6300-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 06, 2020 at 02:03:50PM +0000, Ard Biesheuvel wrote:
>   data structure. It also creates a time window where the initrd data sits
>   in memory, and can potentially be corrupted before the kernel is booted.
> 

I don't quite understand the time window aspect -- can you expand on
that? It seems like the same time window exists between when the kernel
is loaded and when it actually runs, no? Why is this more important for
initrd?
