Return-Path: <linux-efi+bounces-4253-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26EBAFEC60
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCBF1C44010
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A582E5B2E;
	Wed,  9 Jul 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUX+twZ4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D532E3B1E;
	Wed,  9 Jul 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072038; cv=none; b=TwLOmUa2b2xQM2RhlegjQTKYmCh7YIgnsjsALveJsqoyZW0OkgLX6Gm0PgOXEg/PS9cg2A7G+T0fsWCswwI+QyZ82d3QVoeZtlqoqZyHL51FN8b5+qtazhM534Pt4oM8CL8viUHzuRx+MSIDe8pBRCr7Di4ARglgrMd9pFjRZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072038; c=relaxed/simple;
	bh=4gltpAo6G2z6Uhvda05MhKbl9p35Vf6wHr1KiUVlyP4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=THUcBBUGJuEv6RqZsKw8jWy4GRZL4cO5qCSNm31QWW+l94NSxwYaH9hPuiG5SLRDNIiqrPgSmYQfbuOIQiLRrLkTUV3cqwMoHEMuvvtnCSV1CUVhNpIura72RVks9S0X3sNwUkbCY4khmouA0jXkIlNyN3fyAqt08Sf2fzh1MgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUX+twZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E68C4CEEF;
	Wed,  9 Jul 2025 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752072038;
	bh=4gltpAo6G2z6Uhvda05MhKbl9p35Vf6wHr1KiUVlyP4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ZUX+twZ4+jBAoRIbfBQCT00xQ5+ZsirmbzJun1ukTD3QAdiA6hDRfv6zD4durLKoP
	 lvG0zq/8mCTPsYPkQY839i2JSeyzaYTJlpNiKcDF4YKmpnm6eXf/Mx3qCxGI4APTAh
	 fhNKrq0HWZRMqZTUOGevD2ZEcc56hjNiHQ4H+4WdXBjaQv3OuhT/HqEyh2S04NZM6k
	 P3mNWKvufwKJBKWlL2VlL41ZCMz35GxdR4qIvEuXxfZDffhzck9ww0zBQqu6B+gziJ
	 RpEa1cTsFcW4zKN8guGq84wsRlfHfApPHxJ/GB6u/EQmwHYi6I3nu7/mUkVFgI92rK
	 CpMyt6CIqOiqg==
Message-ID: <73a18fe6-daef-4035-abb2-67db2c5619e2@kernel.org>
Date: Wed, 9 Jul 2025 16:40:35 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi: add ovmf debug log driver
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250708125624.734132-1-kraxel@redhat.com>
 <6edfa099-ab0c-41f6-89ea-0fd67666dd05@kernel.org>
 <2mn65slwkwmjpeilma2isw7zgabdmda4rhpqjiutwdwqno2wrh@zghymlce2fiy>
 <8621135e-445a-42dd-89e0-bf8fc3e2b6b7@kernel.org>
 <4cix3k4h32wozt3nxic5un7jyzfjrmqmzbzmtr3ivw5b2bz363@mw6bke7w4oaq>
 <5800c426-95fd-4a81-b979-c0bc2bc293dd@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <5800c426-95fd-4a81-b979-c0bc2bc293dd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2025 16:39, Krzysztof Kozlowski wrote:
> On 09/07/2025 16:31, Gerd Hoffmann wrote:
>> On Wed, Jul 09, 2025 at 04:20:49PM +0200, Krzysztof Kozlowski wrote:
>>> On 09/07/2025 16:17, Gerd Hoffmann wrote:
>>>> On Wed, Jul 09, 2025 at 03:58:58PM +0200, Krzysztof Kozlowski wrote:
>>>>> On 08/07/2025 14:56, Gerd Hoffmann wrote:
>>>>>> +MODULE_DESCRIPTION("OVMF debug log");
>>>>>> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
>>>>>> +MODULE_LICENSE("GPL");
>>>>>> +MODULE_ALIAS("platform:ovmf_debug_log");
>>>>>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>>>>>> index db8c5c03d3a2..ac0a03ec3452 100644
>>>>>> --- a/drivers/firmware/efi/Kconfig
>>>>>> +++ b/drivers/firmware/efi/Kconfig
>>>>>> @@ -263,6 +263,14 @@ config EFI_COCO_SECRET
>>>>>>  	  virt/coco/efi_secret module to access the secrets, which in turn
>>>>>>  	  allows userspace programs to access the injected secrets.
>>>>>>  
>>>>>> +config OVMF_DEBUG_LOG
>>>>>> +	tristate "Expose OVMF firmware debug log via sysfs"
>>>>>> +	depends on EFI
>>>>>> +	help
>>>>>> +	  Recent OVMF versions (edk2-stable202508 + newer) can write
>>>>>> +	  their debug log to a memory buffer.  This driver exposes the
>>>>>> +	  log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
>>>>>
>>>>> Where did you document new ABI?
>>>>
>>>> The log buffer header struct is documented in the header file for the
>>>> edk2 code:
>>>> https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Library/MemDebugLogLib.h
>>>
>>> You added a new sysfs interface. I meant documentation for this.
>>
>> The sysfs file contains the log and you can simply use
>> 'cat /sys/firmware/efi/ovmf_debug_log' to read it.
> 
> Don't explain how it works to me. I did not ask how it works. I asked
> where is the new ABI documented?
... and if answer is nowhere, then that's the problem. You need to
document new ABI - see docs in kernel sources.

Best regards,
Krzysztof

