Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9109D28447
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2019 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfEWQyj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 May 2019 12:54:39 -0400
Received: from namei.org ([65.99.196.166]:34068 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfEWQyj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 May 2019 12:54:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4NGsKW4031672;
        Thu, 23 May 2019 16:54:20 GMT
Date:   Fri, 24 May 2019 02:54:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
In-Reply-To: <20190523122610.GA12327@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1905240252440.31508@namei.org>
References: <20190520205501.177637-1-matthewgarrett@google.com> <20190523121449.GA9997@linux.intel.com> <20190523122610.GA12327@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 23 May 2019, Jarkko Sakkinen wrote:

> On Thu, May 23, 2019 at 03:14:49PM +0300, Jarkko Sakkinen wrote:
> > On Mon, May 20, 2019 at 01:54:57PM -0700, Matthew Garrett wrote:
> > > Identical to previous version except without the KSAN workaround - Ard
> > > has a better solution for that.
> > 
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Only applied to my master at this point becaues the patches from
> my earlier PRs are not yet mirrored to security/next-general.

Which PRs are these?

btw, Linus wants security subsystem maintainers to submit PRs directly to 
him from now on.

I'll only be carrying patches for the core LSM and new security mechanisms 
before they're merged and have a maintainer assigned.


-- 
James Morris
<jmorris@namei.org>

