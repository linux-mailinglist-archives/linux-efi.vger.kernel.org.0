Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6519801F
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfHUQal (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 12:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfHUQal (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Aug 2019 12:30:41 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7367216F4;
        Wed, 21 Aug 2019 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566405040;
        bh=gV2U9wxJ+o1VAHDvjn0nJpm8IHEuAW3n7lpukRD1/FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kV/oZ5n9xXqyLF0Na9idXpoU8mK4hSSEEUmF6K82W6dFdai4zw6/w7E2ka1zOHleG
         Q6/BBUDxq8GiIaY+juXKmrYPRYHoShYKvVU5/D+EVtYLiGTPzjKNqmF+1Hy3iBuBNf
         5DmnJoL4ZQZ4UpDvXbPQQzo0QyPujgv5r+HmhUqg=
Date:   Wed, 21 Aug 2019 09:30:38 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v2 3/4] x86/efi: move common keyring handler functions to
 new file
Message-ID: <20190821163038.GB28571@kroah.com>
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
 <1566400103-18201-4-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566400103-18201-4-git-send-email-nayna@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 21, 2019 at 11:08:22AM -0400, Nayna Jain wrote:
> This patch moves the common code to keyring_handler.c

That says _what_ you are doing, but not _why_ you are doing it.  We have
no idea :(

