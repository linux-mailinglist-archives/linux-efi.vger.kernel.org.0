Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFC469AC
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2019 22:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfFNUeb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jun 2019 16:34:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:54026 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfFNUeb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Jun 2019 16:34:31 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 20793128A;
        Fri, 14 Jun 2019 20:34:30 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:34:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 02/28] docs: arm64: convert docs to ReST and rename
 to .rst
Message-ID: <20190614143429.640226ec@lwn.net>
In-Reply-To: <20190614141041.335a76e5@lwn.net>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
        <8320e8e871660bf9fc426bc688f4808a1a7aa031.1560361364.git.mchehab+samsung@kernel.org>
        <20190614141041.335a76e5@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 Jun 2019 14:10:41 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Wed, 12 Jun 2019 14:52:38 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > The documentation is in a format that is very close to ReST format.
> > 
> > The conversion is actually:
> >   - add blank lines in order to identify paragraphs;
> >   - fixing tables markups;
> >   - adding some lists markups;
> >   - marking literal blocks;
> >   - adjust some title markups.
> > 
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.  
> 
> This one doesn't apply to docs-next, since there's a bunch of stuff in
> linux-next that I don't have.  I'd suggest that it either go by way of an
> ARM tree or send it my way again after the ARM changes go upstream.

Actually, nevermind.  Pulling my tree forward to 5.2-rc4 resolved the
issues here.

Thanks,

jon
