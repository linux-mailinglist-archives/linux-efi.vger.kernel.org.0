Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4929EFF
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2019 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391184AbfEXTWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 May 2019 15:22:48 -0400
Received: from namei.org ([65.99.196.166]:34284 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfEXTWs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 May 2019 15:22:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4OJMYl9007828;
        Fri, 24 May 2019 19:22:34 GMT
Date:   Sat, 25 May 2019 05:22:34 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
In-Reply-To: <20190524103846.GA11695@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1905250506320.7233@namei.org>
References: <20190520205501.177637-1-matthewgarrett@google.com> <20190523121449.GA9997@linux.intel.com> <20190523122610.GA12327@linux.intel.com> <alpine.LRH.2.21.1905240252440.31508@namei.org> <20190524103846.GA11695@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 May 2019, Jarkko Sakkinen wrote:

> I'm referring to these:
> 
> https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.intel.com/
> 
> I got response from you that those were applied and there is another
> response in that thread that they are being sent to Linus. That is why I
> haven't done anything since. Most of them are critical fixes to v5.1
> changes.

These are in Linus' tree.  

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a556810d8e06aa2da8bbe22da3d105eb5a0d0c7d

I initially queued them in the next-tpm branch, but forgot to drop them 
from there after sending them to Linus as a v5.1 fix. Linus was not happy 
to see them again in the v5.2 merge window.

Apologies for the confusion.

-- 
James Morris
<jmorris@namei.org>

